-- MySQL dump 10.10
--
-- Host: spunky.bioc.cam.ac.uk    Database: GLORIA
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
-- Table structure for table `FuncRes`
--

DROP TABLE IF EXISTS `FuncRes`;
CREATE TABLE `FuncRes` (
  `id` int(11) NOT NULL auto_increment,
	`type` enum('DISULFID', 'ZN_FING', 'ACT_SITE', 'METAL', 'HELIX', 'TURN', 'REGION', 'NON_CONS', 'MOD_RES', 'UNSURE', 'LIPID', 'CHAIN', 'CARBOHYD', 'SIGNAL', 'REPEAT', 'VARIANT', 'COMPBIAS', 'TRANSMEM', 'CA_BIND', 'CROSSLNK', 'NON_TER', 'PEPTIDE', 'NON_STD', 'DNA_BIND', 'MUTAGEN', 'DOMAIN', 'COILED', 'MOTIF', 'STRAND', 'VAR_SEQ', 'BINDING', 'CONFLICT', 'TRANSIT', 'INIT_MET', 'NP_BIND', 'PROPEP', 'SITE', 'TOPO_DOM', 'CSA_LIT', 'CSA_PSI', 'HUMSAVAR', 'ENVAR', 'CREDO', 'BIPA', 'PICCOLO', 'INTERPARE', 'COSMIC', 'MODRES') not null,
  `res_id` int(11) NOT NULL,
  `ext_id` varchar(50) default null,
  `des` varchar(400) default null,
  PRIMARY KEY  (`id`),
  KEY `type` (`type`),
  KEY `res_id` (`res_id`),
  KEY `ext_id` (`ext_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

