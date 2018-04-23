CREATE TABLE `talentmapdev`.`system_owner_user` (
  `id` INT NOT NULL,
  `user_name` VARCHAR(45) NULL COMMENT 'email id',
  `password` VARCHAR(45) NULL,
  `last_login` DATETIME NULL,
  PRIMARY KEY (`id`))
COMMENT = 'stores login details of admin and any other user';



CREATE TABLE `talentmapdev`.`user_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
COMMENT = 'stores details of different user types of the system - talent,sponsor';



//added fk here
CREATE TABLE `talentmapdev`.`registration_request` (
  `id` INT NOT NULL,
  `requester_id` INT NOT NULL COMMENT 'fk from user_details table',
  `requester_type` INT NULL COMMENT 'Fk from user_types table',
  `requested_date` DATE NULL,
  `request_fulfilled` TINYINT NULL,
  PRIMARY KEY (`id`))
COMMENT = 'stores details of client/talent/sponsor request for password';

// added fk here
CREATE TABLE `talentmapdev`.`user_details` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(60) NULL,
  `password` VARCHAR(35) NULL COMMENT 'stored in MD5 - 32 CHARS only',
  `user_type` INT NULL COMMENT 'fk from user_type table',
  `phone_number` VARCHAR(15) NULL COMMENT 'xxx-xxx-xxxx format',
  `address` VARCHAR(150) NULL,
  `city` VARCHAR(70) NULL,
  `state` VARCHAR(45) NULL,
  `postal` VARCHAR(10) NULL COMMENT 'xxx-xxx format',
  PRIMARY KEY (`id`))
COMMENT = 'stores the common details of every user - talent , sponsor, client';


//added fk
CREATE TABLE `talentmapdev`.`client_details` (
  `id` INT NOT NULL COMMENT 'user_details \'s fk',
  `number_of_employees` INT(6) NULL)
COMMENT = 'stores client specific details';


//added fk
CREATE TABLE `talentmapdev`.`client_project_idea` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NULL COMMENT 'fk from client_details table(indirectly user_details table)',
  `project_sponsor_name` VARCHAR(250) NULL,
  `title` VARCHAR(250) NULL,
  `email` VARCHAR(70) NULL,
  `telephone_direct` VARCHAR(15) NULL,
  `available_few_hours` TINYINT NULL,
  `feedback_given` TINYINT NULL DEFAULT 0,
  `project_title` VARCHAR(150) NULL,
  `project_description` LONGTEXT NULL,
  `attachments_provided` TINYINT NULL,
  `problems_opportunity` MEDIUMTEXT NULL,
  `research_required` MEDIUMTEXT NULL,
  `analysis_required` MEDIUMTEXT NULL,
  `estimated_effort_hours` INT(5) NULL,
  `report_format` MEDIUMTEXT NULL,
  `other_deliverables` MEDIUMTEXT NULL,
  `skill_needed_1` VARCHAR(250) NULL,
  `skill_needed_2` VARCHAR(250) NULL,
  `skill_needed_3` VARCHAR(250) NULL,
  `required_training` TINYINT NULL,
  `training_details` MEDIUMTEXT NULL,
  `international_component` TINYINT NULL,
  `international_component_details` MEDIUMTEXT NULL,
  `coop_opportunity` TINYINT NULL,
  `coop_opportunity_details` MEDIUMTEXT NULL,
  `year_submitted` INT(4) NULL,
  `month` INT(2) NULL,
  `day` INT(2) NULL,
  `project_status` INT NULL COMMENT 'fk from project_status table',
  `sponsor_id` INT NULL COMMENT 'fk from sponser table to enable those group which belongs to this sponsor',
  PRIMARY KEY (`id`))
COMMENT = 'stores details of project idea posted by client';



CREATE TABLE `talentmapdev`.`project_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NULL COMMENT 'posted,approved,rejected,onhold, in progress, incomplete, complete',
  PRIMARY KEY (`id`))
COMMENT = 'stores details of different project status';


//added fk 

CREATE TABLE `talentmapdev`.`talent_details` (
  `id` INT NOT NULL COMMENT 'fk from user_details table',
  `skills` MEDIUMTEXT NULL,
  `current_status` INT NULL COMMENT 'fk from talent_status table',
  `organization_name` VARCHAR(250) NULL,
  `id_in_organization` VARCHAR(100) NULL,
  `graduation_year` INT(4) NULL,
  `graduation_month` INT(2) NULL)
COMMENT = 'stores talent specific details';



CREATE TABLE `talentmapdev`.`talent_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NULL COMMENT 'student / job / NA',
  PRIMARY KEY (`id`))
COMMENT = 'stores details of different status of talent';



//added fk
CREATE TABLE `talentmapdev`.`talent_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `talent_sponsor_group_id` VARCHAR(45) NULL COMMENT 'unique group id assigned by the sponsor to the group if any',
  `sponsor_id` INT NULL COMMENT 'fk from sponsor table to get the organization name',
  `year` INT(4) NULL,
  `month` INT(2) NULL,
  `session` VARCHAR(45) NULL COMMENT 'fall / winter / spring',
  PRIMARY KEY (`id`))
COMMENT = 'stores details of talent in a group';

//added fk

CREATE TABLE `talentmapdev`.`talent_group_project_pitch` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `talent_group_id` INT NULL COMMENT 'fk from talent_group table',
  `project_id` INT NULL COMMENT 'fk from client_project _idea table',
  `date` DATE NULL,
  `is_assigned` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
COMMENT = 'stores details of groups pitched for project';


//added fk
CREATE TABLE `talentmapdev`.`talent_group_members` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_group_id` INT NULL COMMENT 'fk from talent_group_project_pitch table',
  `talent_id` INT NULL COMMENT 'fk from talent_details (indirectly from user_details) table',
  PRIMARY KEY (`id`))
COMMENT = 'stores details of talent in a group';


//add fk
CREATE TABLE `talentmapdev`.`sponsor_representative_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `representative_designation` VARCHAR(150) NULL,
  `sponsor_id` INT NULL COMMENT 'fk from sponsor table',
  PRIMARY KEY (`id`))
COMMENT = 'stores details of sponsor specific - college, university or any other';

CREATE TABLE `talentmapdev`.`sponsor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `organization_name` VARCHAR(250) NULL COMMENT 'name of organization which provides talent',
  `address` VARCHAR(450) NULL,
  PRIMARY KEY (`id`))
COMMENT = 'stores list of different sponsors - college, university, etc';


----------------------------------------

ALTER TABLE `talentmapdev`.`registration_request` 
ADD INDEX `fk__idx` (`requester_id` ASC),
ADD INDEX `fk_idx` (`requester_type` ASC);
ALTER TABLE `talentmapdev`.`registration_request` 
ADD CONSTRAINT `fk_user_details`
  FOREIGN KEY (`requester_id`)
  REFERENCES `talentmapdev`.`user_details` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_user_types`
  FOREIGN KEY (`requester_type`)
  REFERENCES `talentmapdev`.`user_types` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
  
  ALTER TABLE `talentmapdev`.`user_details` 
ADD INDEX `fk_user_types_T_user_details` (`user_type` ASC);
ALTER TABLE `talentmapdev`.`user_details` 
ADD CONSTRAINT `fk_user_types_T_user_details`
  FOREIGN KEY (`user_type`)
  REFERENCES `talentmapdev`.`user_types` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  ALTER TABLE `talentmapdev`.`client_details` 
ADD INDEX `fk__idx` (`id` ASC);
ALTER TABLE `talentmapdev`.`client_details` 
ADD CONSTRAINT `fk_user_id_T_client_details`
  FOREIGN KEY (`id`)
  REFERENCES `talentmapdev`.`user_details` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  
  
  
  
  ALTER TABLE `talentmapdev`.`client_project_idea` 
ADD INDEX `fk_project_status_T_client_project_idea_idx` (`project_status` ASC),
ADD INDEX `fk_sponsor_id_T_client_project_idea_idx` (`sponsor_id` ASC);
ALTER TABLE `talentmapdev`.`client_project_idea` 
ADD CONSTRAINT `fk_client_id_T_client_project_idea`
  FOREIGN KEY (`client_id`)
  REFERENCES `talentmapdev`.`client_details` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_project_status_T_client_project_idea`
  FOREIGN KEY (`project_status`)
  REFERENCES `talentmapdev`.`project_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_sponsor_id_T_client_project_idea`
  FOREIGN KEY (`sponsor_id`)
  REFERENCES `talentmapdev`.`sponsor` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  
  
  
  ALTER TABLE `talentmapdev`.`talent_details` 
ADD INDEX `fk_talent_id_T_talent_details_idx` (`id` ASC),
ADD INDEX `fk_talent_current_status_T_talent_details_idx` (`current_status` ASC);
ALTER TABLE `talentmapdev`.`talent_details` 
ADD CONSTRAINT `fk_talent_id_T_talent_details`
  FOREIGN KEY (`id`)
  REFERENCES `talentmapdev`.`user_details` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_current_status_T_talent_details`
  FOREIGN KEY (`current_status`)
  REFERENCES `talentmapdev`.`talent_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


  ALTER TABLE `talentmapdev`.`talent_group` 
ADD INDEX `fk_sponsor_id_T_talent_group_idx` (`sponsor_id` ASC);
ALTER TABLE `talentmapdev`.`talent_group` 
ADD CONSTRAINT `fk_sponsor_id_T_talent_group`
  FOREIGN KEY (`sponsor_id`)
  REFERENCES `talentmapdev`.`sponsor` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  
  
  ALTER TABLE `talentmapdev`.`talent_group_project_pitch` 
ADD INDEX `fk_talent_group_id_T_talent_group_project_pitch_idx` (`talent_group_id` ASC),
ADD INDEX `fk_project_id_T_talent_group_project_pitch_idx` (`project_id` ASC);
ALTER TABLE `talentmapdev`.`talent_group_project_pitch` 
ADD CONSTRAINT `fk_talent_group_id_T_talent_group_project_pitch`
  FOREIGN KEY (`talent_group_id`)
  REFERENCES `talentmapdev`.`talent_group` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_project_id_T_talent_group_project_pitch`
  FOREIGN KEY (`project_id`)
  REFERENCES `talentmapdev`.`client_project_idea` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  
  ALTER TABLE `talentmapdev`.`talent_group_members` 
ADD INDEX `fk_talent_project_group_id_T_talent_group_members_idx` (`project_group_id` ASC),
ADD INDEX `fk_talent_id_T_talent_group_members_idx` (`talent_id` ASC);
ALTER TABLE `talentmapdev`.`talent_group_members` 
ADD CONSTRAINT `fk_talent_project_group_id_T_talent_group_members`
  FOREIGN KEY (`project_group_id`)
  REFERENCES `talentmapdev`.`talent_group_project_pitch` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_talent_id_T_talent_group_members`
  FOREIGN KEY (`talent_id`)
  REFERENCES `talentmapdev`.`talent_details` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  
  
  ALTER TABLE `talentmapdev`.`sponsor_representative_details` 
ADD INDEX `fk_sponsor_id_T_sponsor_representative_details_idx` (`sponsor_id` ASC);
ALTER TABLE `talentmapdev`.`sponsor_representative_details` 
ADD CONSTRAINT `fk_sponsor_id_T_sponsor_representative_details`
  FOREIGN KEY (`sponsor_id`)
  REFERENCES `talentmapdev`.`sponsor` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  
  ------------------------------- Run following in sql if using old db
  ALTER TABLE `talentmapdev`.`client_project_idea` 
DROP FOREIGN KEY `fk_project_status_T_client_project_idea`;
ALTER TABLE `talentmapdev`.`client_project_idea` 
CHANGE COLUMN `project_status` `project_status` INT(11) NULL DEFAULT 1 COMMENT 'fk from project_status table' ;
ALTER TABLE `talentmapdev`.`client_project_idea` 
ADD CONSTRAINT `fk_project_status_T_client_project_idea`
  FOREIGN KEY (`project_status`)
  REFERENCES `talentmapdev`.`project_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
  -----------------------------------------
  