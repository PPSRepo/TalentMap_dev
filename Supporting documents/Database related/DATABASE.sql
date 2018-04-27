CREATE DATABASE  IF NOT EXISTS `talentmapdev` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `talentmapdev`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: talentmapdev
-- ------------------------------------------------------
-- Server version	5.6.39-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `client_details`
--

DROP TABLE IF EXISTS `client_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_details` (
  `id` int(11) NOT NULL COMMENT 'user_details ''s fk',
  `number_of_employees` int(6) DEFAULT NULL,
  KEY `fk__idx` (`id`),
  CONSTRAINT `fk_user_id_T_client_details` FOREIGN KEY (`id`) REFERENCES `user_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores client specific details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_details`
--

LOCK TABLES `client_details` WRITE;
/*!40000 ALTER TABLE `client_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_project_idea`
--

DROP TABLE IF EXISTS `client_project_idea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_project_idea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL COMMENT 'fk from client_details table(indirectly user_details table)',
  `project_sponsor_name` varchar(250) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `email` varchar(70) DEFAULT NULL,
  `telephone_direct` varchar(15) DEFAULT NULL,
  `available_few_hours` tinyint(4) DEFAULT NULL,
  `feedback_given` tinyint(4) DEFAULT '0',
  `project_title` varchar(150) DEFAULT NULL,
  `project_description` longtext,
  `attachments_provided` tinyint(4) DEFAULT NULL,
  `problems_opportunity` mediumtext,
  `research_required` mediumtext,
  `analysis_required` mediumtext,
  `estimated_effort_hours` int(5) DEFAULT NULL,
  `report_format` mediumtext,
  `other_deliverables` mediumtext,
  `skill_needed_1` varchar(250) DEFAULT NULL,
  `skill_needed_2` varchar(250) DEFAULT NULL,
  `skill_needed_3` varchar(250) DEFAULT NULL,
  `required_training` tinyint(4) DEFAULT NULL,
  `training_details` mediumtext,
  `international_component` tinyint(4) DEFAULT NULL,
  `international_component_details` mediumtext,
  `coop_opportunity` tinyint(4) DEFAULT NULL,
  `coop_opportunity_details` mediumtext,
  `year_submitted` int(4) DEFAULT NULL,
  `month` int(2) DEFAULT NULL,
  `day` int(2) DEFAULT NULL,
  `project_status` int(11) DEFAULT '1' COMMENT 'fk from project_status table',
  `sponsor_id` int(11) DEFAULT NULL COMMENT 'fk from sponser table to enable those group which belongs to this sponsor',
  PRIMARY KEY (`id`),
  KEY `fk_project_status_T_client_project_idea_idx` (`project_status`),
  KEY `fk_sponsor_id_T_client_project_idea_idx` (`sponsor_id`),
  KEY `fk_client_id_T_client_project_idea` (`client_id`),
  CONSTRAINT `fk_client_id_T_client_project_idea` FOREIGN KEY (`client_id`) REFERENCES `client_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_status_T_client_project_idea` FOREIGN KEY (`project_status`) REFERENCES `project_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sponsor_id_T_client_project_idea` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='stores details of project idea posted by client';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_project_idea`
--

LOCK TABLES `client_project_idea` WRITE;
/*!40000 ALTER TABLE `client_project_idea` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_project_idea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_status`
--

DROP TABLE IF EXISTS `project_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL COMMENT 'posted,approved,rejected,onhold, in progress, incomplete, complete',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='stores details of different project status';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_status`
--

LOCK TABLES `project_status` WRITE;
/*!40000 ALTER TABLE `project_status` DISABLE KEYS */;
INSERT INTO `project_status` VALUES (1,'proposed'),(2,'evaluation'),(3,'approved'),(4,'rejected'),(5,'on-hold'),(6,'not-assigned'),(7,'assigned'),(8,'complete'),(9,'incomplete');
/*!40000 ALTER TABLE `project_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_request`
--

DROP TABLE IF EXISTS `registration_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requester_id` int(11) NOT NULL COMMENT 'fk from user_details table',
  `requester_type` int(11) DEFAULT NULL COMMENT 'Fk from user_types table',
  `requested_date` date DEFAULT NULL,
  `request_fulfilled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk__idx` (`requester_id`),
  KEY `fk_idx` (`requester_type`),
  CONSTRAINT `fk_user_details` FOREIGN KEY (`requester_id`) REFERENCES `user_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_types` FOREIGN KEY (`requester_type`) REFERENCES `user_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='stores details of client/talent/sponsor request for password';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_request`
--

LOCK TABLES `registration_request` WRITE;
/*!40000 ALTER TABLE `registration_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(250) DEFAULT NULL COMMENT 'name of organization which provides talent',
  `address` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='stores list of different sponsors - college, university, etc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
INSERT INTO `sponsor` VALUES (1,'Conestoga College','Doon valley'),(2,'Humber','Toronto');
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor_representative_details`
--

DROP TABLE IF EXISTS `sponsor_representative_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsor_representative_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `representative_designation` varchar(150) DEFAULT NULL,
  `sponsor_id` int(11) DEFAULT NULL COMMENT 'fk from sponsor table',
  PRIMARY KEY (`id`),
  KEY `fk_sponsor_id_T_sponsor_representative_details_idx` (`sponsor_id`),
  CONSTRAINT `fk_sponsor_id_T_sponsor_representative_details` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores details of sponsor specific - college, university or any other';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor_representative_details`
--

LOCK TABLES `sponsor_representative_details` WRITE;
/*!40000 ALTER TABLE `sponsor_representative_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsor_representative_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_owner_user`
--

DROP TABLE IF EXISTS `system_owner_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_owner_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) DEFAULT NULL COMMENT 'email id',
  `password` varchar(45) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores login details of admin and any other user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_owner_user`
--

LOCK TABLES `system_owner_user` WRITE;
/*!40000 ALTER TABLE `system_owner_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_owner_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talent_details`
--

DROP TABLE IF EXISTS `talent_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talent_details` (
  `id` int(11) NOT NULL COMMENT 'fk from user_details table',
  `skills` mediumtext,
  `current_status` int(11) DEFAULT NULL COMMENT 'fk from talent_status table',
  `organization_name` varchar(250) DEFAULT NULL,
  `id_in_organization` varchar(100) DEFAULT NULL,
  `graduation_year` int(4) DEFAULT NULL,
  `graduation_month` int(2) DEFAULT NULL,
  KEY `fk_id_T_talent_details_idx` (`id`,`current_status`),
  KEY `fk_current_status_T_talent_details_idx` (`current_status`),
  KEY `fk_talent_id_T_talent_details_idx` (`id`),
  KEY `fk_talent_current_status_T_talent_details_idx` (`current_status`),
  CONSTRAINT `fk_current_status_T_talent_details` FOREIGN KEY (`current_status`) REFERENCES `talent_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_talent_id_T_talent_details` FOREIGN KEY (`id`) REFERENCES `user_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores talent specific details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talent_details`
--

LOCK TABLES `talent_details` WRITE;
/*!40000 ALTER TABLE `talent_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `talent_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talent_group`
--

DROP TABLE IF EXISTS `talent_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talent_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `talent_sponsor_group_id` varchar(45) DEFAULT NULL COMMENT 'unique group id assigned by the sponsor to the group if any',
  `sponsor_id` int(11) DEFAULT NULL COMMENT 'fk from sponsor table to get the organization name',
  `year` int(4) DEFAULT NULL,
  `month` int(2) DEFAULT NULL,
  `session` varchar(45) DEFAULT NULL COMMENT 'fall / winter / spring',
  PRIMARY KEY (`id`),
  KEY `fk_sponsor_id_T_talent_group_idx` (`sponsor_id`),
  CONSTRAINT `fk_sponsor_id_T_talent_group` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores details of talent in a group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talent_group`
--

LOCK TABLES `talent_group` WRITE;
/*!40000 ALTER TABLE `talent_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `talent_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talent_group_members`
--

DROP TABLE IF EXISTS `talent_group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talent_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_group_id` int(11) DEFAULT NULL COMMENT 'fk from talent_group_project_pitch table',
  `talent_id` int(11) DEFAULT NULL COMMENT 'fk from talent_details (indirectly from user_details) table',
  PRIMARY KEY (`id`),
  KEY `fk_talent_project_group_id_T_talent_group_members_idx` (`project_group_id`),
  KEY `fk_talent_id_T_talent_group_members_idx` (`talent_id`),
  CONSTRAINT `fk_talent_id_T_talent_group_members` FOREIGN KEY (`talent_id`) REFERENCES `talent_details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_talent_project_group_id_T_talent_group_members` FOREIGN KEY (`project_group_id`) REFERENCES `talent_group_project_pitch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores details of talent in a group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talent_group_members`
--

LOCK TABLES `talent_group_members` WRITE;
/*!40000 ALTER TABLE `talent_group_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `talent_group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talent_group_project_pitch`
--

DROP TABLE IF EXISTS `talent_group_project_pitch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talent_group_project_pitch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `talent_group_id` int(11) DEFAULT NULL COMMENT 'fk from talent_group table',
  `project_id` int(11) DEFAULT NULL COMMENT 'fk from client_project _idea table',
  `date` date DEFAULT NULL,
  `is_assigned` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_talent_group_id_T_talent_group_project_pitch_idx` (`talent_group_id`),
  KEY `fk_project_id_T_talent_group_project_pitch_idx` (`project_id`),
  CONSTRAINT `fk_project_id_T_talent_group_project_pitch` FOREIGN KEY (`project_id`) REFERENCES `client_project_idea` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_talent_group_id_T_talent_group_project_pitch` FOREIGN KEY (`talent_group_id`) REFERENCES `talent_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores details of groups pitched for project';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talent_group_project_pitch`
--

LOCK TABLES `talent_group_project_pitch` WRITE;
/*!40000 ALTER TABLE `talent_group_project_pitch` DISABLE KEYS */;
/*!40000 ALTER TABLE `talent_group_project_pitch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talent_status`
--

DROP TABLE IF EXISTS `talent_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talent_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL COMMENT 'student / job / NA',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='stores details of different status of talent';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talent_status`
--

LOCK TABLES `talent_status` WRITE;
/*!40000 ALTER TABLE `talent_status` DISABLE KEYS */;
INSERT INTO `talent_status` VALUES (1,'student'),(2,'employee'),(3,'N/A');
/*!40000 ALTER TABLE `talent_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `password` varchar(35) DEFAULT NULL COMMENT 'stored in MD5 - 32 CHARS only',
  `user_type` int(11) DEFAULT NULL COMMENT 'fk from user_type table',
  `phone_number` varchar(15) DEFAULT NULL COMMENT 'xxx-xxx-xxxx format',
  `address` varchar(150) DEFAULT NULL,
  `city` varchar(70) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `postal` varchar(10) DEFAULT NULL COMMENT 'xxx-xxx format',
  PRIMARY KEY (`id`),
  KEY `fk_user_types_idx` (`user_type`),
  KEY `fk_user_types_T_user_details` (`user_type`),
  CONSTRAINT `fk_user_types_T_user_details` FOREIGN KEY (`user_type`) REFERENCES `user_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='stores the common details of every user - talent , sponsor, client';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_details`
--

LOCK TABLES `user_details` WRITE;
/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_types`
--

DROP TABLE IF EXISTS `user_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='stores details of different user types of the system - talent,sponsor';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_types`
--

LOCK TABLES `user_types` WRITE;
/*!40000 ALTER TABLE `user_types` DISABLE KEYS */;
INSERT INTO `user_types` VALUES (1,'Talent'),(2,'Sponsor'),(3,'Client'),(4,'Admin');
/*!40000 ALTER TABLE `user_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'talentmapdev'
--

--
-- Dumping routines for database 'talentmapdev'
--
/*!50003 DROP PROCEDURE IF EXISTS `registerUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registerUser`(firstname varchar(100),lastname varchar(100),email varchar(100), userPassword varchar(100), userType int)
BEGIN
/* MUST have this handler to handle exception if query goes wrong */
DECLARE exit handler for sqlexception
  BEGIN
    -- ERROR
    select "error Occured in stored procedure";
  ROLLBACK;
END;

set @email  = email;
set @userType = userType;
set @firstname = firstname;
set @lastname = lastname;
set @userPassword = userPassword;

/* MUST HAVE THIS start transction before making any query */
start transaction;
insert into user_details (first_name,last_name,`password`,email,user_type) values(@firstname,@lastname,@userPassword,@email,@userType);
set @userId = LAST_INSERT_ID();

INSERT INTO `talentmapdev`.`talent_details`
(`id`)
VALUES
(@userId);


select  "Registration request fulfilled" as res;
commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registerUserWithEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registerUserWithEmail`(email varchar(100), userType int)
BEGIN
/* MUST have this handler to handle exception if query goes wrong */
DECLARE exit handler for sqlexception
  BEGIN
    -- ERROR
    select "error Occured in stored procedure";
  ROLLBACK;
END;

set @email  = email;
set @userType = userType;

/* MUST HAVE THIS start transction before making any query */
start transaction;
insert into user_details (email,user_type) values(@email,@userType);
set @userId = LAST_INSERT_ID();
insert into client_details (id) values(@userId);
INSERT INTO `talentmapdev`.`registration_request`
(
`requester_id`,
`requester_type`,
`requested_date`,
`request_fulfilled`)
VALUES
(
@userId,
@userType,
curDate(),
0
);


select  "Registration request fulfilled" as res;
commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `setRequesterPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setRequesterPassword`(user_id int, requester_id int, user_password varchar(35))
BEGIN
/* MUST have this handler to handle exception if query goes wrong */
DECLARE exit handler for sqlexception
  BEGIN
    -- ERROR
    select "error Occured in stored procedure - setRequesterPassword";
  ROLLBACK;
END;

set @user_id  = user_id;
set @requester_id = requester_id;
set @user_password =  user_password;

/* MUST HAVE THIS start transction before making any query */
start transaction;

update user_details set `password` = @user_password where  id = @user_id;
update  registration_request set request_fulfilled = 1 where id = @requester_id;


select  email from user_details where id = @user_id;
commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-23 19:16:13
