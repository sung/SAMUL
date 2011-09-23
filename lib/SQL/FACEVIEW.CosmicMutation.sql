-- MySQL dump 10.11
--
-- Host: 192.168.1.1    Database: FACEVIEW
-- ------------------------------------------------------
-- Server version	5.0.51a

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
-- Table structure for table `CosmicMutation`
--

DROP TABLE IF EXISTS `CosmicMutation`;
CREATE TABLE `CosmicMutation` (
  `id` int(11) NOT NULL auto_increment,
  `gene` varchar(50) default NULL,
  `hgnc_id` mediumint(8) default NULL,
  `sample_name` varchar(200) default NULL,
  `primary_site` varchar(200) default NULL,
  `subtype` varchar(200) default NULL,
  `primary_histology` varchar(200) default NULL,
  `histology_subtype` varchar(200) default NULL,
  `mutation_id` mediumint(8) unsigned default NULL,
  `mutation_cds` varchar(200) default NULL,
  `mutation_aa` varchar(200) default NULL,
  `position` int(6) default NULL,
  `wt` enum('A','C','D','E','F','G','H','I','K','L','M','N','P','Q','R','S','T','V','W','Y','J') default NULL,
  `mut` enum('A','C','D','E','F','G','H','I','K','L','M','N','P','Q','R','S','T','V','W','Y','J') default NULL,
  `chromosome` varchar(5) default NULL,
  `ncbi_genome_start` mediumint(10) default NULL,
  `ncbi_genome_end` mediumint(10) default NULL,
  `ncbi_genome_strand` enum('+','-') default NULL,
  `pubmed_id` mediumint(8) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `gene` (`gene`),
  KEY `hgnc_id` (`hgnc_id`),
  KEY `position` (`position`,`wt`,`mut`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-05-20 17:20:39
