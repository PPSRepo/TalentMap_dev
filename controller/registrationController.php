<?php
include_once   '../config/config.php';
include_once   '../connections/dbCon.php';
include_once 'mailerController.php';
class registrationController
{

    // TODO - Insert your code here
    public function __construct()
    {
        
        // TODO - Insert your code here
    }
    public function checkUserExists($data){
        //first line in each controller's function
        $responseData = phpConfig::$config["responseDataFormat"];
        
        //expecting 
        $userEmail = $data["email"];
        $userType = $data["userType"];
        
        $conn = dbCon::getDbCon();
        $sql = "select count(*) as 'row_count' from user_details where email = ? and user_type = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("si",$userEmail,$userType);
        $stmt->execute();
        $stmt->bind_result($rowCount);
        //when only one row
        $stmt->fetch();
               
        $resData = array();
        $resData["isAvailable"] = $rowCount == 0 ? false : true;
        
        $stmt->close();
        //last line
        $responseData["data"] = $resData;
        $responseData["status"] = phpConfig::$config["statusCode"]["taskCompleted"];
        return $responseData;
    }
    //method that registers new client
    public function registerNewUser($data){
        //first line in each controller's function
        $responseData = phpConfig::$config["responseDataFormat"];
        $resData = array();
        
        $param = array();
        $param["email"] = $data["email"];
        $param["userType"] = $data["userType"];
        $response = $this->checkUserExists($param);
        if($response["status"] == phpConfig::$config["statusCode"]["taskCompleted"] ){
            $userExists = $response["data"];
            
            if($userExists["isAvailable"] == false){
                
                $conn = dbCon::getDbCon();
                $sql = "CALL registerUserWithEmail(?,?)";
                $stmt = $conn->prepare($sql);
                $stmt->bind_param("si",$data["email"],$data["userType"]);
                if($stmt->execute()){
                    $stmt->bind_result($res);
                    //when only one row
                    $stmt->fetch();
                    $resData["message"] = $res;
                    //sending mail
                    $resData["mail"] =(new mailerController)->sendMail($data["email"],phpConfig::$config["registrationRequestMailTemplate"]);
                    $resData["resgistrationStatus"] = 1;
                }else{
                    $resData["message"] = "error occured in database";
                    $resData["resgistrationStatus"] = 0;
                }
                
                $stmt->close();                
                
            }else{
                $resData["resgistrationStatus"] = 0;
                $resData["message"] = "User with email " . $data["email"] . " already exists.";
            }
            
            
            $responseData["status"] = phpConfig::$config["statusCode"]["taskCompleted"];
        }else{
            $resData["received_data"] = array();
            $responseData["status"] = phpConfig::$config["statusCode"]["taskIncompleted"];
        }
                           
        //last line
        $responseData["data"] = $resData;
        
        return $responseData;
    }
       
    public function getRegistrationRequestList ($data){
          
            $responseData = phpConfig::$config["responseDataFormat"];
            $resData = array();
                        
            $conn = dbCon::getDbCon();
            $sql = "SELECT ud.id as 'user_id',
             ud.first_name,
             ud.last_name,
             ud.email,
             ud.user_type,
             rr.id as request_id,
             rr.requested_date,
             rr.request_fulfilled
             FROM user_details as ud, registration_request as rr where ud.id = rr.requester_id";
            $stmt = $conn->prepare($sql);
            $stmt->execute();
            $res = $stmt->get_result();
            $records = array();
            while($row = $res->fetch_assoc()){
                array_push( $records,$row);
            }
                      
            $stmt->close();
            $resData["records"] = $records;
                       
             //last line
            $responseData["data"] = $resData;
            
            return $responseData;
    }
    
    public function setRequesterPassword($data){
        //first line in each controller's function
        $responseData = phpConfig::$config["responseDataFormat"];
        $resData = array();
        
        $param = array();
        $param["raw_password"] = $data["raw_password"];
        $param["password"] = md5( $data["raw_password"]);
        $param["user_id"] = $data["user_id"];
        $param["request_id"] = $data["request_id"];
        
        $conn = dbCon::getDbCon();
        $sql = "CALL setRequesterPassword(?,?,?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("iis",$param["user_id"],$param["request_id"],$param["password"]);
        if($stmt->execute()){
            $stmt->bind_result($res);
            //when only one row
            $stmt->fetch();
            $param["email"] = $res;
                    
            //sending mail
            $email = phpConfig::$config["passwordSetMailTemplate"];
            $email["body"] = str_ireplace("__username__", $param["email"], $email["body"]);
            $email["body"] = str_ireplace("__password__", $param["raw_password"], $email["body"]);
            
            $resData["mail"] =(new mailerController)->sendMail($param["email"],$email);
            
            $resData["passwordSetStatus"] = 1;
            $resData["message"] = "Password set successfully";
        }else{
            $resData["message"] = "error occured in database";
        }
        
        
        $responseData["data"] = $resData;
        
        return $responseData;
    }

    public function registerUser($data){
        //first line in each controller's function
        $responseData = phpConfig::$config["responseDataFormat"];
        $resData = array();
        
        $param = array();
        $param["email"] = $data["email"];
        $param["userType"] = $data["userType"];
        $param["firstname"] = $data["firstname"];
        $param["lastname"] = $data["lastname"];
        $param["password"] = md5($data["password"]);
        
        $response = $this->checkUserExists($param);
        if($response["status"] == phpConfig::$config["statusCode"]["taskCompleted"] ){
            $userExists = $response["data"];
            
            if($userExists["isAvailable"] == false){
                
                $conn = dbCon::getDbCon();
                $sql = "CALL registerUser(?,?,?,?,?)";
                $stmt = $conn->prepare($sql);
                $stmt->bind_param("ssssi",$param["firstname"],$param["lastname"],$param["email"],$param["password"],$param["userType"]);
                if($stmt->execute()){
                    $stmt->bind_result($res);
                    //when only one row
                    $stmt->fetch();
                    $resData["message"] = $res;
                    //sending mail
                    $resData["mail"] =(new mailerController)->sendMail($data["email"],phpConfig::$config["registrationRequestTalentMailTemplate"]);
                    $resData["resgistrationStatus"] = 1;
                }else{
                    $resData["message"] = "error occured in database";
                    $resData["resgistrationStatus"] = 0;
                }
                $stmt->close();                
                
            }else{
                $resData["resgistrationStatus"] = 0;
                $resData["message"] = "User with email " . $data["email"] . " already exists.";
            }
            $responseData["status"] = phpConfig::$config["statusCode"]["taskCompleted"];
        }else{
            $resData["received_data"] = array();
            $responseData["status"] = phpConfig::$config["statusCode"]["taskIncompleted"];
        }
        //last line
        $responseData["data"] = $resData;
        
        return $responseData;
    }
    
}

