<?php
	$file = "config.json";
	$arr = array ();
	$data = json_decode(file_get_contents("php://input"), TRUE);
	$jsondata = ReadJSON($file);

	// Endpoint to return the dashboard info to wizard
	
	if (isset($_GET['dashboard-info'])) {
		$arr = array ( 
      
		        "accessKey" => $jsondata['AccessKey'], 
		        "secretKey" => $jsondata['SecretKey'],
		        "satellite" => $jsondata['Satellite'],
		); 
  
		echo json_encode($arr); 
	}

	// Endpoint to save the parameters and configuring the gateway
	else if (isset($_GET['wizard-save'])) {
		if($data['satellite'] == "" || $data['satellite'] == null || $data['apiKey'] == "" || $data['apiKey'] ==null || $data['passphrase'] =="" || $data['passphrase'] ==null){
		    $arr = array ( "Error" => "Kindly check inputs vlues!"); 
			echo json_encode($arr); 
		}else{
			$satellite = $data['satellite'];
		   	$apiKey = $data['apiKey'];
		    $passphrase = $data['passphrase'];
		}
	}

	// Endpoint to send commands to gateway

	else if (isset($_GET['gateway-action'])) {
		if($data['action'] == "" || $data['action'] == null){
			$arr = array ( "error" => "Kindly check action!"); 
			
		}else{
			if($data['action'] == "run"){

				$arr = array ( "status" => "running"); 

			}else if($data['action'] == "stop"){

				$arr = array ( "status" => "stopped"); 
			}else if($data['action'] == "restart"){

				$arr = array ( "status" => "restarting"); 
			}
		}

		echo json_encode($arr); 

	}

	function ReadJSON($file)
	{
		$content = file_get_contents($file);
		$prop = json_decode($content, true);

		return array('AccessKey'=>$prop['AccessKey'],'SecretKey'=>$prop['SecretKey'],'Satellite'=>$prop['Satellite']);
	}

?>
