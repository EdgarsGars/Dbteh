CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.5-m15

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
-- Temporary table structure for view `employeeinproject`
--

DROP TABLE IF EXISTS `employeeinproject`;
/*!50001 DROP VIEW IF EXISTS `employeeinproject`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `employeeinproject` (
  `accountID` tinyint NOT NULL,
  `firstname` tinyint NOT NULL,
  `lastname` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `projectID` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `role` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `alltasks`
--

DROP TABLE IF EXISTS `alltasks`;
/*!50001 DROP VIEW IF EXISTS `alltasks`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `alltasks` (
  `taskID` tinyint NOT NULL,
  `assignee` tinyint NOT NULL,
  `firstname` tinyint NOT NULL,
  `lastname` tinyint NOT NULL,
  `projectID` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `priority` tinyint NOT NULL,
  `subject` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `startDate` tinyint NOT NULL,
  `endDate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `employeeinproject`
--

/*!50001 DROP TABLE IF EXISTS `employeeinproject`*/;
/*!50001 DROP VIEW IF EXISTS `employeeinproject`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`edgars.garsneks`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `employeeinproject` AS select `e`.`accountID` AS `accountID`,`e`.`firstname` AS `firstname`,`e`.`lastname` AS `lastname`,`e`.`email` AS `email`,`p`.`projectID` AS `projectID`,`p`.`name` AS `name`,(select `r`.`Role` from `roles` `r` where (`r`.`roleID` = `pr`.`roleID`)) AS `role` from ((`employee` `e` join `project_roles` `pr` on((`e`.`accountID` = `pr`.`accountID`))) join `project` `p` on((`p`.`projectID` = `pr`.`projectID`))) order by `e`.`lastname`,`e`.`firstname` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `alltasks`
--

/*!50001 DROP TABLE IF EXISTS `alltasks`*/;
/*!50001 DROP VIEW IF EXISTS `alltasks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`edgars.garsneks`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `alltasks` AS select `t`.`taskID` AS `taskID`,`t`.`assignee` AS `assignee`,(select `e`.`firstname` from `employee` `e` where (`e`.`accountID` = `t`.`assignee`)) AS `firstname`,(select `e`.`lastname` from `employee` `e` where (`e`.`accountID` = `t`.`assignee`)) AS `lastname`,`t`.`projectID` AS `projectID`,(select `s`.`statusName` from `status` `s` where (`t`.`status` = `s`.`statusID`)) AS `status`,(select `ty`.`typeName` from `type` `ty` where (`ty`.`typeID` = `t`.`type`)) AS `type`,(select `pr`.`priorityName` from `priority` `pr` where (`t`.`priority` = `pr`.`priorityID`)) AS `priority`,`t`.`subject` AS `subject`,`t`.`description` AS `description`,`t`.`startDate` AS `startDate`,`t`.`endDate` AS `endDate` from `task` `t` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'mydb'
--

--
-- Dumping routines for database 'mydb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-15 16:49:33
