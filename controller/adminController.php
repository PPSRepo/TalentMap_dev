<?php
include_once   '../config/config.php';
include_once   '../connections/dbCon.php';

class adminController
{

    // TODO - Insert your code here
    public function __construct()
    {
        
        // TODO - Insert your code here
    }
    public function getAdminDashboardCounterData ($data){
        
        $responseData = phpConfig::$config["responseDataFormat"];
        $resData = array();
              
        $conn = dbCon::getDbCon();
        $sql = "SELECT 
                (select count(*) from client_project_idea where project_status = 1) as 'proposed_project_count',
                (select count(*) from registration_request where request_fulfilled = 0) as 'client_registration_count' ";
             
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
    
    public function getClientProjectList ($data){
        
        $responseData = phpConfig::$config["responseDataFormat"];
        $resData = array();
        
        $conn = dbCon::getDbCon();
        $sql = "SELECT `cpi`.`id` as 'project_id',
    `ud`.`email` as `proposor_email`,
    `cpi`.`client_id`,
    `cpi`.`project_sponsor_name`,
    `cpi`.`title`,
    `cpi`.`email`,
    `cpi`.`telephone_direct`,
    `cpi`.`available_few_hours`,
    `cpi`.`feedback_given`,
    `cpi`.`project_title`,
    `cpi`.`project_description`,
    `cpi`.`attachments_provided`,
    `cpi`.`problems_opportunity`,
    `cpi`.`research_required`,
    `cpi`.`analysis_required`,
    `cpi`.`estimated_effort_hours`,
    `cpi`.`report_format`,
    `cpi`.`other_deliverables`,
    `cpi`.`skill_needed_1`,
    `cpi`.`skill_needed_2`,
    `cpi`.`skill_needed_3`,
    `cpi`.`required_training`,
    `cpi`.`training_details`,
    `cpi`.`international_component`,
    `cpi`.`international_component_details`,
    `cpi`.`coop_opportunity`,
    `cpi`.`coop_opportunity_details`,
    `cpi`.`year_submitted`,
    `cpi`.`month`,
    `cpi`.`day`,
    `cpi`.`project_status` as 'project_status_id',
    `ps`.`status` as 'project_status',
    `cpi`.`sponsor_id`,
    (select `s`.`organization_name`  from `sponsor` as `s` where `s`.id = `cpi`.`sponsor_id`) as 'sponsor_name'
FROM `talentmapdev`.`client_project_idea` as `cpi` ,  `project_status` as `ps`,`user_details` as `ud` where  `cpi`.`project_status`=`ps`.`id` and `ud`.`id` =`cpi`.`client_id`;
";
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
    public function getClientList ($data){
        
        $responseData = phpConfig::$config["responseDataFormat"];
        $resData = array();
        
        $conn = dbCon::getDbCon();
        $sql = "SELECT
                    first_name as company_name,
                    email,phone_number,address,city,state,postal,
                    (select count(*) from client_project_idea where client_id = `ud`.`id`) as `project_count`
                from user_details as `ud` where user_type = 3";
                
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
    
    public function updateClientProjectDetails($data){
        $responseData = phpConfig::$config["responseDataFormat"];
        $resData = array();
        
        
        $conn = dbCon::getDbCon();
        $sql = 'update client_project_idea   set
    
    project_sponsor_name = ?,
    title = ? ,
    email = ?,
    telephone_direct = ? ,
    available_few_hours = ?,
    feedback_given = ?,
    project_title = ?,
    project_description = ?,
    attachments_provided = ?,
    problems_opportunity = ?,
    research_required = ?,
    analysis_required = ?,
    estimated_effort_hours = ?,
    report_format = ?,
    other_deliverables = ?,
    skill_needed_1 = ?,
    skill_needed_2 = ?,
    skill_needed_3 = ?,
    required_training = ?,
    training_details = ?,
    international_component = ?,
    international_component_details = ?,
    coop_opportunity = ?,
    coop_opportunity_details = ?,
    year_submitted = ?,
    month = ?,
    day = ?,
    project_status = ?,
    sponsor_id = ?
        where id = ?        
';  //28 columns
        
        $stmt = $conn->prepare($sql);
        
        $stmt->bind_param("ssssiississsisssssisisisiiiiii",$data["project_sponsor_name"],$data["title"],$data["email"],$data["telephone_direct"],     $data["available_few_hours"],$data["feedback_given"],$data["project_title"],$data["project_description"],$data["attachments_provided"],     $data["problems_opportunity"],$data["research_required"],$data["analysis_required"],$data["estimated_effort_hours"],$data["report_format"],     $data["other_deliverables"],$data["skill_needed_1"],$data["skill_needed_2"],$data["skill_needed_3"],$data["required_training"],     $data["training_details"],$data["international_component"],$data["international_component_details"],$data["coop_opportunity"],$data["coop_opportunity_details"],     $data["year_submitted"], $data["month"],$data["day"],$data["project_status"], $data["sponsor_id"],$data["project_id"]);
        if($stmt->execute()){
            $resData["update_status"] = 1;
        }else{
            $resData["update_status"] = 0;
        }
        
        $stmt->close();
        
        
        //last line
        $responseData["data"] = $resData;
        
        return $responseData;
    }
    
    
    
    
    
    
 //end of file   
}


