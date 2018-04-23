<?php
//including dependent files
include_once  '../config/config.php';
require_once '../controller/userController.php';
require_once '../controller/registrationController.php';
require_once '../controller/loginController.php';
require_once '../controller/clientController.php';

//getting response format
$response = phpConfig::$config["responseFormat"];

$responseData = null;
$postdata = file_get_contents("php://input"); //when data sent through angular, $_POST or any other will not work. return string.
$request = json_decode($postdata,true); //converts json string to array and 'true' return assoc (key-pair) array
function checkToken($data){
    return (new loginController)->checkUserAlive($data);
}

if(isset($request["talentMap"])){
    
    //searching for api tobe called
    $response["status"] = phpConfig::$config["statusCode"]["validApiName"];
    switch($request["apiName"]){
        
        case "getUserDetails" :{

            $responseData = (new userController)->getUserDetails($request["data"]);
            break;
        }
        case "registerUserWithEmail" :{
            $responseData = (new registrationController)->registerNewUser($request["data"]);
            break;
        }
        case "registerUser" :{
            $responseData = (new registrationController)->registerUser($request["data"]);
            break;
        }
        case "getRegistrationRequestList" :{
            $responseData = (new registrationController)->getRegistrationRequestList($request["data"]);
            break;
        }
        
        case "setRequesterPassword" :{
            $responseData = (new registrationController)->setRequesterPassword($request["data"]);
            break;
        }
        case 'loginUser' :{
            $responseData = (new loginController)->loginUser($request["data"]);
            break;
        }
        case 'getClientProfileDetails' : {
            
            if(checkToken($request["data"])){
                $responseData =  (new clientController)->getClientProfileDetails($request["data"]);
            }else{
                $responseData = phpConfig::$config["invalidTokenReponse"];
            }
            
            break;
        }
        case 'updateClientProfileDetails' : {
            
            if(checkToken($request["data"])){
                $responseData =  (new clientController)->updateClientProfileDetails($request["data"]);
            }else{
                $responseData = phpConfig::$config["invalidTokenReponse"];
            }
            
            break;
        }
        case 'getClientProjectList' : {
            
            if(checkToken($request["data"])){
                $responseData =  (new clientController)->getClientProjectList($request["data"]);
            }else{
                $responseData = phpConfig::$config["invalidTokenReponse"];
            }
            
            break;
        }
        
        
         default :{
             $response["status"] = phpConfig::$config["statusCode"]["invalidApiName"];
             $response["error"] = "Invalid Api Name";
        }
    }
    
    //finally returning response with response data;
$response["responseData"] = $responseData;
echo json_encode($response);


}
else{
    $response = array();
    $response["error"] = "Unathoraised api call";
    $response["responseCode"] = "400";
    $response["subArray"] = array("abc"=>array("b"=>"b"),"xyz"=>array("a"=>"a"));
    echo json_encode($response);
}