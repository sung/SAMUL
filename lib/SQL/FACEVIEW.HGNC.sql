-- MySQL dump 10.10
--
-- Host: spunky.bioc.cam.ac.uk    Database: FACEVIEW
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
-- Table structure for table `HGNC`
--

DROP TABLE IF EXISTS `HGNC`;
CREATE TABLE `HGNC` (
  `hgnc` mediumint(8) unsigned NOT NULL,
  `symbol` varchar(50) default NULL,
  `name` varchar(150) default NULL,
  `status` enum('Approved','Symbol Withdrawn','Entry Withdrawn') default NULL,
  `locus_type` varchar(150) default NULL,
  `prv_symbol` varchar(100) default NULL,
  `prv_name` varchar(255) default NULL,
  `aliases` varchar(150) default NULL,
  `chrom` varchar(40) default NULL,
  `enzymes` varchar(100) default NULL,
  `entrez_id` mediumint(8) unsigned default NULL,
  `mgd` mediumint(8) unsigned default NULL,
  `pubmed_ids` varchar(100) default NULL,
  `refseq_ids` varchar(100) default NULL,
  `gene_family` varchar(100) default NULL,
  `gdb` int(8) default NULL,
  `entrez_mapped` mediumint(8) unsigned default NULL,
  `mim` int(7) default NULL,
  `refseq_mapped` varchar(20) default NULL,
  `uniprot` char(6) default NULL,

  PRIMARY KEY  (`hgnc`),
  KEY `gene` (`symbol`,`name`),
  KEY `refseq` (`refseq_mapped`,`refseq_ids`),
  KEY `entrez` (`entrez_mapped`,`entrez_id`),
  KEY `uniprot` (`uniprot`),
  KEY `chr` (`chrom`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

