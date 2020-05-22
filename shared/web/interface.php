<?php
	$file = "config.json";
	$arr = array ();
	$data = json_decode(file_get_contents("php://input"), TRUE);
	$jsondata = ReadJSON($file);
	$apiRequest = "";

	// Endpoint to return the dashboard info to wizard
	if($data['apiRequest'] == "dashboard-info" || $data['apiRequest'] == "wizard-save" || $data['apiRequest'] == "gateway-action")  
	{
		$apiRequest = $data['apiRequest'];

		if ($apiRequest === 'dashboard-info') {
			$arr = array ( 
			        "accessKey" => $jsondata['AccessKey'], 
			        "secretKey" => $jsondata['SecretKey'],
			        "satellite" => $jsondata['Satellite'],
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

						$arr = array ( "status" => "running"); 

					}else if($data['action'] == "stop"){

						$arr = array ( "status" => "stopped"); 
					}else if($data['action'] == "restart"){

						$arr = array ( "status" => "restarting"); 
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

?>
