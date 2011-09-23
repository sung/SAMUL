-- MySQL dump 10.10
--
-- Host: spunky.bioc.cam.ac.uk    Database: GLORIA
-- ------------------------------------------------------
-- Server version	5.0.45

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
-- Table structure for table `ResidueMap`
--

DROP TABLE IF EXISTS `ResidueMap`;
CREATE TABLE `ResidueMap` (
  `res_id` int(10) NOT NULL auto_increment,
  `entry` char(4) NOT NULL,
  `seg_name` varchar(15) character set utf8 collate utf8_bin NOT NULL default '',
  `seg_chain_id` char(2) character set utf8 collate utf8_bin default NULL,
  `res_num` int(5) NOT NULL,
  `res_3code` char(3) NOT NULL,
  `res_1code` char(1) default NULL,
  `ss_code` char(1) default NULL,
  `pdb` char(4) default NULL,
  `pdb_chain_id` char(2) character set utf8 collate utf8_bin default NULL,
  `pdb_local_res_num` int(5) default NULL,
  `pdb_res_num` int(5) default NULL,
  `ins_code` char(1) default NULL,
  `scop` int(6) default NULL,
  `scop_res_num` char(5) default NULL,
  `cath` char(6) default NULL,
  `cath_res_num` char(5) default NULL,
  `uniprot` char(6) default NULL,
  `uniprot_res_num` int(5) default NULL,
  `uniprot_res_code` char(1) default NULL,
  PRIMARY KEY  (`res_id`),
  UNIQUE KEY `position` (`entry`,`seg_chain_id`,`res_num`),
  KEY `pdb_chain_local_resnum` (`pdb`,`pdb_chain_id`,`pdb_local_res_num`),
  KEY `pdb` (`pdb`,`pdb_chain_id`,`pdb_res_num`),
  KEY `scop` (`scop`,`scop_res_num`),
  KEY `uniprot` (`uniprot`,`uniprot_res_num`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `Segment`
--

DROP TABLE IF EXISTS `Segment`;
CREATE TABLE `Segment` (
  `entry` char(4) NOT NULL,
  `seg_name` varchar(15) character set utf8 collate utf8_bin default NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `start` int(6) NOT NULL,
  `end` int(6) NOT NULL,
  PRIMARY KEY  (`entry`,`chain`,`start`,`end`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `2ndStructure`
--

DROP TABLE IF EXISTS `2ndStructure`;
CREATE TABLE `2ndStructure` (
  `ss_code` char(1) NOT NULL,
  `ss_name` varchar(20) NOT NULL,
  PRIMARY KEY  (`ss_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

