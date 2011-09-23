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
-- Temporary table structure for view `AccHuman`
--

--DROP TABLE IF EXISTS `AccHuman`;
--/*!50001 DROP VIEW IF EXISTS `AccHuman`*/;
--/*!50001 CREATE TABLE `AccHuman` (
--  `acc` char(12)
--) */;

--
-- Table structure for table `SwissProtSeq`
--

--DROP TABLE IF EXISTS `SwissProtSeq`;
CREATE TABLE if not exists `SwissProtSeq`(
  `acc` char(12) NOT NULL,
  `display_id` char(12) NOT NULL,
  `length` int(5) NOT NULL,
  `mw` int(10) default NULL,
  `sequence` longtext,
  PRIMARY KEY  (`acc`),
  KEY `display_id` (`display_id`,`sequence`(100))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `SwissProtVariants`
--

--DROP TABLE IF EXISTS `SwissProtVariants`;
CREATE TABLE if not exists `SwissProtVariants`(
  `counter` int(15) NOT NULL auto_increment,
  `variant_id` char(10) NOT NULL default '',

  `gene` varchar(20) default NULL,
  `sp_acc` char(12) default NULL,
  `sp_entry` char(12) default NULL,
  `uniprot_res_num` int(5) default NULL,

  `res_id` int(15) unsigned default null,
  `pdb` char(4) default NULL,
  `pdb_chain_id` char(2) character set utf8 collate utf8_bin default NULL,
  `pdb_res_num` char(5) default NULL,

  `aa_original` char(1) default NULL,
  `aa_variation` char(1) default NULL,
  `type` enum('Disease','Polymorphism','Unclassified') NOT NULL,
  `disease_name` varchar(255) default NULL,
  `mim` int(6) default NULL,
  PRIMARY KEY  (`counter`),
  KEY `variant` (`variant_id`,`gene`,`disease_name`),
  KEY `uniprot` (`sp_acc`,`sp_entry`,`uniprot_res_num`),
  KEY `pdb` (`res_id`,`pdb`,`pdb_chain_id`,`pdb_res_num`),
  KEY `type` (`type`,`aa_variation`,`aa_original`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `UniprotHuman`
--

--DROP TABLE IF EXISTS `UniprotHuman`;
CREATE TABLE if not exists `UniprotHuman`(
  `acc` varchar(20) NOT NULL,
  PRIMARY KEY  (`acc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `feature`
--

--DROP TABLE IF EXISTS `feature`;
CREATE TABLE if not exists `feature`(
  `acc` char(12) NOT NULL default '',
  `start` int(11) NOT NULL default '0',
  `end` int(11) NOT NULL default '0',
  `featureClass` int(11) NOT NULL default '0',
  `featureType` int(11) NOT NULL default '0',
  `softEndBits` tinyint(4) NOT NULL default '0',
  `featureId` int(11) NOT NULL default '0',
  KEY `acc` (`acc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `featureClass`
--

--DROP TABLE IF EXISTS `featureClass`;
CREATE TABLE if not exists `featureClass`(
  `id` int(11) NOT NULL default '0',
  `val` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `val` (`val`(12))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `featureId`
--

--DROP TABLE IF EXISTS `featureId`;
CREATE TABLE if not exists `featureId`(
  `id` int(11) NOT NULL default '0',
  `val` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `val` (`val`(14))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `featureType`
--

--DROP TABLE IF EXISTS `featureType`;
CREATE TABLE if not exists `featureType`(
  `id` int(11) NOT NULL default '0',
  `val` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `val` (`val`(12))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Final view structure for view `AccHuman`
--

/*!50001 DROP TABLE IF EXISTS `AccHuman`*/;
/*!50001 DROP VIEW IF EXISTS `AccHuman`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`Adrian`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `AccHuman` AS (select distinct `SwissProtSeq`.`acc` AS `acc` from `SwissProtSeq` where (substring_index(`SwissProtSeq`.`display_id`,_utf8'_',-(1)) = _utf8'HUMAN')) */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

