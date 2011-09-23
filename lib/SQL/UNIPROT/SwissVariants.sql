-- MySQL dump 10.10
--
-- Host: spunky.bioc.cam.ac.uk    Database: UNIPROT
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
-- Table structure for table `SwissProtVariants`
--

DROP TABLE IF EXISTS `SwissVariants`;
CREATE TABLE IF NOT EXISTS `SwissVariants` (
  `id` int(15) NOT NULL auto_increment,
  `variant_id` char(10) NOT NULL default '',
  `gene` varchar(20) default NULL,
  `sp_acc` char(12) default NULL,
  `sp_entry` char(12) default NULL,
  `uniprot_res_num` int(5) default NULL,
  `aa_original` char(1) default NULL,
  `aa_variation` char(1) default NULL,
  `type` enum('Disease','Polymorphism','Unclassified') NOT NULL,
  `disease_name` varchar(255) default NULL,
  `mim` int(6) default NULL,

  PRIMARY KEY  (`id`),
  KEY (`variant_id`),
  KEY (`gene`),
  KEY (`sp_acc`),
  KEY (`sp_acc`,`uniprot_res_num`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

