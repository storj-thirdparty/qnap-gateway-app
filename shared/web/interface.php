<?php
	# ------------------------------------------------------------------------
	#  Set environment variables
	# ------------------------------------------------------------------------
	$filename = "config.json";

	$platformBase   = $_SERVER['DOCUMENT_ROOT'];
	$moduleBase     = $platformBase . dirname($_SERVER['PHP_SELF']) ;
	$scriptsBase    = $moduleBase . '/scripts' ;


	$file           = $moduleBase  . DIRECTORY_SEPARATOR . $filename  ;
	$startScript    = $scriptsBase . DIRECTORY_SEPARATOR . 'gatewayrun.sh' ;
	$configureScript     = $scriptsBase . DIRECTORY_SEPARATOR . 'gatewayconfigure.sh' ;
	$stopScript     = $scriptsBase . DIRECTORY_SEPARATOR . 'gatewaystop.sh' ;
	$updateScript = $scriptsBase . DIRECTORY_SEPARATOR . 'gatewayupdate.sh' ;
	$isRunning      = $scriptsBase . DIRECTORY_SEPARATOR . 'isRunning.sh' ;
	$dockerConfigFile = 'gateway/config.yaml';
	logMessage("------------------------------------------------------------------------------");
	logMessage("Platform Base($platformBase), ModuleBase($moduleBase) scriptBase($scriptsBase)");
	# ------------------------------------------------------------------------


	$output = "";
	

	
	$arr = array ();
	$data = json_decode(file_get_contents("php://input"), TRUE);
	$apiRequest = "";

	// Endpoint to return the dashboard info to wizard
	if($data['apiRequest'] == "dashboard-info" || $data['apiRequest'] == "wizard-save" || $data['apiRequest'] == "gateway-action")  
	{
		$apiRequest = $data['apiRequest'];

		if ($apiRequest === 'dashboard-info') {
			$jsondata = ReadJSON($file);
			$arr = array ( 
			        "accessKey" => $jsondata['AccessKey'], 
			        "secretKey" => $jsondata['SecretKey'],
			        "satellite" => $jsondata['Satellite'],
			        "status" => status(),
			); 

	  
		}
		// Endpoint to save the parameters and configuring the gateway
		else if ($apiRequest === 'wizard-save') {
			if(isset($data['satellite']) && isset($data['apiKey']) && isset($data['passphrase'])){
				if(
				    $data['satellite'] == null  || $data['satellite'] == "" ||
				    $data['apiKey'] == null     || $data['apiKey'] == "" ||
				    $data['passphrase'] == null || $data['passphrase'] =="" )
				{

				    $arr = array ( "error" => "Invalid or Unknown API Request"); 
				}else{
				    $satellite = $data['satellite'];
				    $apiKey = $data['apiKey'];
					$passphrase = $data['passphrase'];
					$port = "127.0.0.1:7777:7777";

				    configureGateway($port,$satellite,$apiKey,$passphrase);

				}
			}else{
				$arr = array ( "error" => "Invalid or Unknown API Request"); 
			}
		}

		// Endpoint to send commands to gateway
		else if ( $apiRequest === 'gateway-action') {
			if(isset($data['action'])){
				if($data['action'] == null || $data['action'] == "" ) {
					$arr = array ( "error" => "Invalid or Unknown API Request"); 
					
				}else{
					if($data['action'] == "run"){

						$arr = array ( "status" => runGateway()); 

					}else if($data['action'] == "stop"){

						$arr = array ( "status" => stopGateway()); 

					}else if($data['action'] == "restart"){

						$arr = array ( "status" =>  restartGateway()); 
					}
				}
			}else{
				$arr = array ( "error" => "Invalid or Unknown API Request"); 
			}


		}
	}else{
		$arr = array ( "error" => "Invalid or Unknown API Request"); 
	}
	echo json_encode($arr); 

	function ReadJSON($file)
	{
		$content = file_get_contents($file);
		$prop = json_decode($content, true);

		return array('AccessKey'=>$prop['AccessKey'],'SecretKey'=>$prop['SecretKey'],'Satellite'=>$prop['Satellite']);
	}



	// Checking Geteway Process
	function status(){
		global $isRunning;
		$output = shell_exec("/bin/bash $isRunning ");
	    logMessage("Run status of container is $output ");
	    if($output ==1){
	    	 return "connected";
	    }else{
	    	return "stopped";
	    }
	}

	 // Run Gateway
	function runGateway(){
		global $startScript;
		global $file, $moduleBase;
		logMessage("Interface called to run Gateway ");
	    logEnvironment() ;
	   
	    $output = shell_exec("/bin/bash $startScript $moduleBase 2>&1 ");

		return status();
	}

	// Stop Gateway
	function stopGateway() {
		global $stopScript;
		global $file;
		// Excute shell script for stoping gateway process
		logMessage("Interface called to stop Gateway ");
		logEnvironment() ;

		$output = shell_exec("/bin/bash $stopScript 2>&1 ");


		return status();
	}

		// Restart Gateway
		function restartGateway() {
			global $stopScript;
			global $startScript;
			global $file;
			// Excute shell script for stoping gateway process
			logMessage("Interface called to restart Gateway ");

			logEnvironment() ;
			stopGateway() ;
			runGateway() ;
	
			return status();
		}

	// Configure Geteway
	function configureGateway($port,$satellite,$apiKey,$passphrase){
		global $file;
		global $output;
		global $configureScript, $moduleBase;
		$jsonString = file_get_contents($file);
	    $data = json_decode($jsonString, true);

		$data['Port'] = $port;
		$data['APIKey'] = $apiKey;
	    $data['Satellite'] = $satellite;

	    $newJsonString = json_encode($data);
		file_put_contents($file, $newJsonString);
		
		logMessage("Interface called to save parameters and configure Gateway ");
		$output = shell_exec("/bin/bash $configureScript $port $satellite $apiKey $passphrase $moduleBase 2>&1 ");




	    /* Reading Access key and secret key from YAML*/
	    $searchaccesskey = 'minio.access-key';
	    $searchsecretkey = 'minio.secret-key';
	    $accesskey = "";
	    $secretkey = "";

	    header('Content-Type: text/plain');

	    $contents = shell_exec('export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin ; docker run --rm -v $(pwd)/gateway:/root/.local/share/storj/gateway --entrypoint /bin/cat storjlabs/gateway:latest /root/.local/share/storj/gateway/config.yaml 2>&1 ');


	    $pattern = preg_quote($searchaccesskey, '/');
	    $pattern = "/^\s*${pattern}\s*:.*\$/m";

	    $pattern1 = preg_quote($searchsecretkey, '/');
	    $pattern1 = "/^\s*${pattern1}\s*:.*\$/m";

	    if(preg_match_all($pattern, $contents, $matches)){
	      $accesskey = implode("\n", $matches[0]);
	    }
	    else{
	          $arr = array ( "status" => "No matches found"); 
	    }

	    if(preg_match_all($pattern1, $contents, $matches1)){
	      $secretkey = implode("\n", $matches1[0]);
	    }
	    else{
	    	$arr = array ( "status" => "No matches found"); 
	    }
	    $parts = explode(':', $accesskey);
	    $parts1 = explode(':', $secretkey);
	    $accesskey = str_replace(' ', '', $parts[1]);
	    $secretkey = str_replace(' ', '', $parts1[1]);

	    /* Update File again with Log value as well */
	    $jsonfile = file_get_contents($file);
	    $properties = json_decode($jsonfile, true);
	    $properties['last_log'] = $output ;
	    $properties['AccessKey'] = $accesskey ;
	    $properties['SecretKey'] = $secretkey ;
	    file_put_contents($file, json_encode($properties));

	}


	function logEnvironment() {
	  logMessage(
	    "\n----------------------------------------------\n"
	    . "ENV is : " . print_r($_ENV, true)
	    . "POST is : " . print_r($_POST, true)
	    . "SERVER is : " . print_r($_SERVER, true)
	    . "----------------------------------------------\n"
	  );
	}

	function logMessage($message) {
	    $file = "/var/log/GATEWAY" ;
	    $message = preg_replace('/\n$/', '', $message);
	    $date = `date` ; $timestamp = str_replace("\n", " ", $date);
	    file_put_contents($file, $timestamp . $message . "\n", FILE_APPEND);
	}

?>
