-- MySQL dump 10.11
--
-- Host: 192.168.1.2    Database: SAMUL
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
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `News`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `News` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(255) DEFAULT NULL,
  `description` text not null,
  `link` varchar(255) default null,

  PRIMARY KEY (`id`),
  KEY `index_news_on_date` (`created`),
  UNIQUE KEY (link)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

insert into News (title, description, link)
values
('Hello world!', 'Initial service launched', 'messenger/news/1'),
('Gbrowse', 'Domains, SNPs, and disease-related amino acids can be viewed in 2D image (http://faceview.bio.cc/cgi-bin/gbrowse/samul', 'messenger/news/2'),
('Jmol', 'Amino acids variants can be viewed in 3D structure using Jmol', 'messenger/news/3'),
('Jmol', 'SCOP domains can be selected in the 3D structure of a PDB entry', 'messenger/news/4'),
('remediated PDB files', 'We use PDB files based on the remediated files (http://remediation.wwpdb.org/)', 'messenger/news/5'),
('UniProt FT', 'UniProt feature lines (FT) are incorporated into Gbrowse (http://faceview.bio.cc/cgi-bin/gbrowse/samul', 'messenger/news/6'),
('Jmol', 'Solvent (in)accessible area can be browseable within Jmol', 'messenger/news/7'),
('Gbrowse', 'Selected SNPs are highlighed in Gbrowse', 'messenger/news/8'),
('DAS', 'FaceView servers as a DAS server (DSN:http://faceview.bio.cc/cgi-bin/das/dsn, SAMUL:http://faceview.bio.cc/cgi-bin/das/samul, (e.g. http://faceview.bio.cc/cgi-bin/das/samul/features?segment=P24941)', 'messenger/news/9'),
('ResMap', 'Showing alignments between PDB and its corresponding UniProt sequence (known as Double-map)', 'messenger/news/10'),
('Face lifted', 'SAMUL (aka. FaceView) has been face-lifted', 'messenger/news/11');

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-03-12 11:05:55
