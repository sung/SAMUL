-- MySQL dump 10.10
--
-- Host: spunky.bioc.cam.ac.uk    Database: SAMUL
-- ------------------------------------------------------
-- Server version	5.0.26

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
-- Table structure for table `SCOPMap`
--

DROP TABLE IF EXISTS `SCOPMap`;
CREATE TABLE `SCOPMap` (
  `id` int(4) NOT NULL auto_increment,
  `sid` char(10) NOT NULL,
  `px` int(11) not null,
  `sccs` varchar(50) NOT NULL,
  `sunid` int(11) NOT NULL,
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin default NULL,
  `pdb_res_start` int(5) default NULL,
  `ins_code_start` char(1) default NULL,   
  `pdb_res_end` int(5) default NULL,
  `ins_code_end` char(1) default NULL,   
  `pdb_local_res_start` int(5) default NULL,
  `pdb_local_res_end` int(5) default NULL,
  `pdb_local_rescued_res_start` int(5) default NULL,
  `pdb_local_rescued_res_end` int(5) default NULL,

  PRIMARY KEY  (`id`),
  KEY `sccs` (`sccs`),
  KEY `sid` (`sid`),
  KEY `px` (`px`),
  KEY `pdb` (`pdb`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
