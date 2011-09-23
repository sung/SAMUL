-- MySQL dump 10.11
--
-- Host: 192.168.1.2    Database: UNIPROT
-- ------------------------------------------------------
-- Server version	5.1.31-1ubuntu2

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
-- Table structure for table `AccAlias`
--

DROP TABLE IF EXISTS `AccAlias`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `AccAlias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acc` char(12) NOT NULL,
  `alias` char(12) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `acc` (`acc`),
  KEY `alias` (`alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `DbRef`
--

DROP TABLE IF EXISTS `DbRef`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `DbRef` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acc` char(12) NOT NULL,
  `db_id` int(3) NOT NULL,
  `entry` char(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `acc` (`acc`),
  KEY `db_id` (`db_id`,`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `IdAlias`
--

DROP TABLE IF EXISTS `IdAlias`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `IdAlias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_id` char(12) NOT NULL,
  `alias` char(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_id` (`display_id`,`alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `RefDbLists`
--

DROP TABLE IF EXISTS `RefDbLists`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `RefDbLists` (
  `id` int(3) NOT NULL,
  `db` char(12) NOT NULL,
  PRIMARY KEY (`id`,`db`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `SwissVariants`
--

DROP TABLE IF EXISTS `SwissVariants`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `SwissVariants` (
  `counter` int(15) NOT NULL AUTO_INCREMENT,
  `variant_id` char(10) NOT NULL DEFAULT '',
  `gene` varchar(20) DEFAULT NULL,
  `sp_acc` char(12) DEFAULT NULL,
  `sp_entry` char(12) DEFAULT NULL,
  `uniprot_res_num` int(5) DEFAULT NULL,
  `aa_original` char(1) DEFAULT NULL,
  `aa_variation` char(1) DEFAULT NULL,
  `type` enum('Disease','Polymorphism','Unclassified') NOT NULL,
  `disease_name` varchar(255) DEFAULT NULL,
  `mim` int(6) DEFAULT NULL,
  PRIMARY KEY (`counter`),
  KEY `variant` (`variant_id`,`gene`,`disease_name`),
  KEY `uniprot` (`sp_acc`,`sp_entry`,`uniprot_res_num`),
  KEY `type` (`type`,`aa_variation`,`aa_original`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Taxanomy`
--

DROP TABLE IF EXISTS `Taxanomy`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `Taxanomy` (
  `id` int(11) NOT NULL,
  `sn` tinyblob NOT NULL,
  `cn` tinyblob,
  PRIMARY KEY (`id`),
  KEY `sn` (`sn`(100))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `UniProtSeq`
--

DROP TABLE IF EXISTS `UniProtSeq`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `UniProtSeq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acc` char(12) NOT NULL,
  `display_id` char(12) NOT NULL,
  `name` tinyblob,
  `gene` char(20) NOT NULL,
  `length` int(5) NOT NULL,
  `mw` int(10) DEFAULT NULL,
  `sequence` longtext,
  `is_sp` int(1) NOT NULL,
  `tax_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acc` (`acc`),
  UNIQUE KEY `display_id` (`display_id`),
  KEY `tax_id` (`tax_id`),
  KEY `gene` (`gene`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `feature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acc` char(12) NOT NULL DEFAULT '',
  `start` int(11) DEFAULT NULL,
  `end` int(11) DEFAULT NULL,
  `featureVariant` int(11) DEFAULT NULL,
  `featureClass` int(11) NOT NULL DEFAULT '0',
  `featureType` int(11) DEFAULT NULL,
  `featureId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acc` (`acc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `featureClass`
--

DROP TABLE IF EXISTS `featureClass`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `featureClass` (
  `id` int(11) NOT NULL DEFAULT '0',
  `val` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `val` (`val`(12))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `featureId`
--

DROP TABLE IF EXISTS `featureId`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `featureId` (
  `id` int(11) NOT NULL DEFAULT '0',
  `val` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `val` (`val`(14))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `featureType`
--

DROP TABLE IF EXISTS `featureType`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `featureType` (
  `id` int(11) NOT NULL DEFAULT '0',
  `val` longtext,
  PRIMARY KEY (`id`),
  KEY `val` (`val`(12))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `featureVariant`
--

DROP TABLE IF EXISTS `featureVariant`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `featureVariant` (
  `id` int(11) NOT NULL DEFAULT '0',
  `ori` text,
  `vari` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-10-20 23:30:01
