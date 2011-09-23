-- MySQL dump 10.10
--
-- Host: spunky    Database: TOCCATA
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
-- Table structure for table `Aln`
--

DROP TABLE IF EXISTS `Aln`;
CREATE TABLE `Aln` (
  `id` int(11) NOT NULL auto_increment,
  `aln_id` int(11) NOT NULL,
  `aln_pos` int(11) NOT NULL,
  `px` int(11) NOT NULL,
  `res_1code` char(1) NOT NULL,
  `pdb_local_res_num` decimal(10,0) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `aln_px_resnum` (`aln_id`,`px`,`pdb_local_res_num`),
  KEY `aln_id` (`aln_id`,`aln_pos`)
) ENGINE=MyISAM AUTO_INCREMENT=130788 DEFAULT CHARSET=utf8;

--
-- Table structure for table `Ensp2ScopDomain`
--

DROP TABLE IF EXISTS `Ensp2ScopDomain`;
CREATE TABLE `Ensp2ScopDomain` (
  `ensp` varchar(50) NOT NULL,
  `length` mediumint(7) unsigned NOT NULL,
  `ensp_start` mediumint(7) unsigned NOT NULL default '0',
  `ensp_end` mediumint(7) unsigned NOT NULL default '0',
  `coverage` float(4,2) unsigned NOT NULL,
  `ensp_matched_seq` text NOT NULL,
  `sid` varchar(7) NOT NULL,
  `sccs` varchar(15) NOT NULL,
  `scop_start` mediumint(7) unsigned default NULL,
  `scop_end` mediumint(7) unsigned default NULL,
  `scop_matched_seq` text NOT NULL,
  `score` smallint(5) unsigned default NULL,
  `evalue` double unsigned default NULL,
  `similarity` float unsigned default NULL,
  PRIMARY KEY  (`ensp`,`ensp_start`,`ensp_end`),
  KEY `domain` (`sid`,`sccs`,`scop_start`,`scop_end`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `Ensp2ScopDomain_isl`
--

DROP TABLE IF EXISTS `Ensp2ScopDomain_isl`;
CREATE TABLE `Ensp2ScopDomain_isl` (
  `query` char(15) NOT NULL,
  `length` mediumint(7) unsigned NOT NULL,
  `q_start` mediumint(7) unsigned NOT NULL default '0',
  `q_end` mediumint(7) unsigned NOT NULL default '0',
  `coverage` float(4,2) unsigned NOT NULL,
  `q_matched_seq` text NOT NULL,
  `ish` mediumint(10) NOT NULL,
  `i_start` mediumint(7) NOT NULL,
  `i_end` mediumint(7) NOT NULL,
  `i_matched_seq` text NOT NULL,
  `sid` varchar(7) NOT NULL,
  `sccs` varchar(15) NOT NULL,
  `scop_start` mediumint(7) unsigned default NULL,
  `scop_end` mediumint(7) unsigned default NULL,
  `score` smallint(5) unsigned default NULL,
  `evalue` double unsigned default NULL,
  `similarity` float unsigned default NULL,
  PRIMARY KEY  (`query`,`q_start`,`q_end`),
  KEY `isl` (`ish`,`i_start`,`i_end`),
  KEY `domain` (`sid`,`sccs`,`scop_start`,`scop_end`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `HomMap`
--

DROP TABLE IF EXISTS `HomMap`;
CREATE TABLE `HomMap` (
  `fa_name` varchar(120) NOT NULL,
  `member` char(10) NOT NULL,
  `pdb` char(4) NOT NULL,
  `chain` char(1) default NULL,
  `pdb_res_start` varchar(5) NOT NULL,
  `pdb_local_res_start` int(5) NOT NULL,
  PRIMARY KEY  (`member`),
  KEY `chain` (`chain`,`pdb_res_start`,`pdb_local_res_start`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `HumanSprot2ScopDomain_isl`
--

DROP TABLE IF EXISTS `HumanSprot2ScopDomain_isl`;
CREATE TABLE `HumanSprot2ScopDomain_isl` (
  `query` char(15) NOT NULL,
  `length` mediumint(7) unsigned NOT NULL,
  `q_start` mediumint(7) unsigned NOT NULL default '0',
  `q_end` mediumint(7) unsigned NOT NULL default '0',
  `coverage` float(4,2) unsigned NOT NULL,
  `q_matched_seq` text NOT NULL,
  `ish` mediumint(10) NOT NULL,
  `i_start` mediumint(7) NOT NULL,
  `i_end` mediumint(7) NOT NULL,
  `i_matched_seq` text NOT NULL,
  `sid` varchar(7) NOT NULL,
  `sccs` varchar(15) NOT NULL,
  `scop_start` mediumint(7) unsigned default NULL,
  `scop_end` mediumint(7) unsigned default NULL,
  `score` smallint(5) unsigned default NULL,
  `evalue` double unsigned default NULL,
  `similarity` float unsigned default NULL,
  PRIMARY KEY  (`query`,`q_start`,`q_end`),
  KEY `isl` (`ish`,`i_start`,`i_end`),
  KEY `domain` (`sid`,`sccs`,`scop_start`,`scop_end`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `RepAln`
--

DROP TABLE IF EXISTS `RepAln`;
CREATE TABLE `RepAln` (
  `id` int(11) NOT NULL auto_increment,
  `sccs` int(11) NOT NULL,
  `aln_pos` int(11) NOT NULL,
  `sid` char(7) NOT NULL,
  `res_1code` char(1) NOT NULL,
  `pdb_local_res_num` decimal(10,0) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `aln_px_resnum` (`sccs`,`sid`,`pdb_local_res_num`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `Sub177`
--

DROP TABLE IF EXISTS `Sub177`;
CREATE TABLE `Sub177` (
  `counter` int(11) NOT NULL auto_increment,
  `fa_name` varchar(120) NOT NULL,
  `env` varchar(150) NOT NULL,
  `member` char(10) NOT NULL,
  `code` char(1) NOT NULL,
  `aln_pos` int(11) NOT NULL,
  `local_res_num` decimal(10,0) default NULL,
  PRIMARY KEY  (`counter`),
  KEY `env` (`env`),
  KEY `aln` (`fa_name`,`member`,`local_res_num`)
) ENGINE=MyISAM AUTO_INCREMENT=2506501 DEFAULT CHARSET=utf8;

--
-- Table structure for table `SwissProt2ScopDomain_1e_4`
--

DROP TABLE IF EXISTS `SwissProt2ScopDomain_1e_4`;
CREATE TABLE `SwissProt2ScopDomain_1e_4` (
  `acc` char(6) NOT NULL,
  `length` mediumint(7) unsigned NOT NULL,
  `sp_start` mediumint(7) unsigned NOT NULL default '0',
  `sp_end` mediumint(7) unsigned NOT NULL default '0',
  `coverage` float(4,2) unsigned NOT NULL,
  `sp_matched_seq` text NOT NULL,
  `sid` varchar(7) NOT NULL,
  `sccs` varchar(15) NOT NULL,
  `scop_start` mediumint(7) unsigned default NULL,
  `scop_end` mediumint(7) unsigned default NULL,
  `scop_matched_seq` text NOT NULL,
  `score` smallint(5) unsigned default NULL,
  `evalue` double unsigned default NULL,
  `similarity` float unsigned default NULL,
  PRIMARY KEY  (`acc`,`sp_start`,`sp_end`),
  KEY `domain` (`sid`,`sccs`,`scop_start`,`scop_end`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

