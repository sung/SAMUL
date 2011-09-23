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
-- Table structure for table `CoordLength`
--

--
-- Table structure for table `SNP2ENSG`
--

DROP TABLE IF EXISTS `SNP2ENSG`;
CREATE TABLE `SNP2ENSG` (
  `id` int(11) NOT NULL auto_increment,
  `rs_id` varchar(100) NOT NULL,
  `ensg` varchar(50) default NULL,
  `seq_region_id` int(10) unsigned NOT NULL,
  `source_id` int(2) unsigned NOT NULL,
  `strand` tinyint(4) default NULL,
  `start` int(11) default NULL,
  `end` int(11) default NULL,
  `allele` text,
  `genotyped` tinyint(1) NOT NULL default '0',
  `validation` set('cluster','freq','submitter','doublehit','hapmap') default NULL,
  `type` set('ESSENTIAL_SPLICE_SITE','STOP_GAINED','STOP_LOST','COMPLEX_INDEL','FRAMESHIFT_CODING','NON_SYNONYMOUS_CODING','SPLICE_SITE','SYNONYMOUS_CODING','REGULATORY_REGION','WITHIN_MATURE_miRNA','5PRIME_UTR','3PRIME_UTR','INTRONIC','UPSTREAM','DOWNSTREAM','WITHIN_NON_CODING_GENE','NO_CONSEQUENCE','INTERGENIC') NOT NULL default 'INTERGENIC', 

  PRIMARY KEY  (`id`),
  KEY `rs_id` (`rs_id`),
  KEY (`ensg`),
  KEY (`ensg`,`start`,`end`),
  KEY (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `SNP2ENSP`
--

DROP TABLE IF EXISTS `SNP2ENSP`;
CREATE TABLE `SNP2ENSP` (
  `id` int(11) NOT NULL auto_increment,
  `rs_id` varchar(100) NOT NULL,
  `ensp` varchar(50) default NULL,
  `start` int(11) default NULL,
  `end` int(11) default NULL,
  `allele` varchar(200) default NULL,
  `type` set('ESSENTIAL_SPLICE_SITE','STOP_GAINED','STOP_LOST','COMPLEX_INDEL','FRAMESHIFT_CODING','NON_SYNONYMOUS_CODING','SPLICE_SITE','SYNONYMOUS_CODING','REGULATORY_REGION','WITHIN_MATURE_miRNA','5PRIME_UTR','3PRIME_UTR','INTRONIC','UPSTREAM','DOWNSTREAM','WITHIN_NON_CODING_GENE') NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `rs_id` (`rs_id`),
  KEY (`ensp`),
  KEY (`ensp`,`start`,`end`),
  KEY (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `SNP2ENST`
--

DROP TABLE IF EXISTS `SNP2ENST`;
CREATE TABLE `SNP2ENST` (
  `id` int(11) NOT NULL auto_increment,
  `rs_id` varchar(100) NOT NULL default '',
  `enst` varchar(50) default NULL,
  `start` int(11) default NULL,
  `end` int(11) default NULL,
  `allele` varchar(200) default NULL,
  `type` set('ESSENTIAL_SPLICE_SITE','STOP_GAINED','STOP_LOST','COMPLEX_INDEL','FRAMESHIFT_CODING','NON_SYNONYMOUS_CODING','SPLICE_SITE','SYNONYMOUS_CODING','REGULATORY_REGION','WITHIN_MATURE_miRNA','5PRIME_UTR','3PRIME_UTR','INTRONIC','UPSTREAM','DOWNSTREAM','WITHIN_NON_CODING_GENE') NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `rs_id` (`rs_id`),
  KEY (`enst`),
  KEY (`enst`,`start`,`end`),
  KEY (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-01-20 12:39:56
