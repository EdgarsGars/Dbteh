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
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskID` int(11) NOT NULL AUTO_INCREMENT,
  `projectID` int(11) NOT NULL,
  `parentTask` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `assignee` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `subject` varchar(45) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime DEFAULT NULL,
  `progress` int(11) NOT NULL DEFAULT '0',
  `spentTime` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`taskID`),
  UNIQUE KEY `id_UNIQUE` (`taskID`),
  KEY `fk_Task_Project1_idx` (`projectID`),
  KEY `fk_Task_Task1_idx` (`parentTask`),
  KEY `fk_Task_Status1_idx` (`status`),
  KEY `fk_Task_Type1_idx` (`type`),
  KEY `fk_Task_Account2_idx` (`assignee`),
  KEY `fk_Task_Account1_idx` (`creator`),
  KEY `fk_Task_Priority1_idx` (`priority`),
  CONSTRAINT `fk_Task_Account1` FOREIGN KEY (`creator`) REFERENCES `account` (`accountID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_Account2` FOREIGN KEY (`assignee`) REFERENCES `account` (`accountID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_Priority1` FOREIGN KEY (`priority`) REFERENCES `priority` (`priorityID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_Project1` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_Status1` FOREIGN KEY (`status`) REFERENCES `status` (`statusID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_Task1` FOREIGN KEY (`parentTask`) REFERENCES `task` (`taskID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_Type1` FOREIGN KEY (`type`) REFERENCES `type` (`typeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,1,NULL,8,1,1,1,1,'Facebook integration','Anoying','2014-11-12 00:00:00',NULL,0,0.00),(2,1,1,8,3,3,1,4,'Facebook documentation',' Let see if it works','2014-11-12 00:00:00','2014-11-12 00:00:00',100,3.50),(3,2,NULL,1,1,2,1,1,'This is a task test','Creating some task','2014-11-12 00:00:00',NULL,0,60.00),(4,2,3,2,2,1,2,2,'This is a subtask','subtask of task','2014-11-12 00:00:00',NULL,75,13.00),(5,2,3,1,2,3,2,4,'This is a subtask #2',' Another subtask','2014-11-12 00:00:00',NULL,13,50.00),(6,1,2,8,3,1,1,3,'Depp subtask','Project 1 deep subtask','2014-11-12 00:00:00',NULL,14,13.00),(7,1,NULL,2,1,2,2,1,'Google+ authentication','Please provide google+','2014-11-12 00:00:00',NULL,0,0.00),(8,1,2,2,3,3,1,3,'This is a first test from form','LEts see it at work','2014-12-15 03:56:49',NULL,0,0.00),(10,4,1,8,2,1,1,4,'das','da','2014-12-15 09:59:05',NULL,0,0.00),(11,4,NULL,8,2,1,1,4,'sdsa','df','2014-12-15 10:22:56',NULL,0,0.00),(12,4,NULL,8,2,1,1,4,'This is a new Task','','2014-12-15 10:23:27',NULL,0,0.00),(13,1,NULL,7,2,1,1,5,'Yolo','YOLO BAGINS','2014-12-15 11:07:07',NULL,0,0.00),(14,5,NULL,4,3,1,1,1,'First task of this project','Lets sing!','2014-12-15 16:41:39',NULL,0,0.00);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-15 16:49:31
