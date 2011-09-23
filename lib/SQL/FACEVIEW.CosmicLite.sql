DROP TABLE IF EXISTS `FACEVIEW`.`CosmicLite`;
CREATE TABLE `FACEVIEW`.`CosmicLite` (
	`id` int(6) not null auto_increment,
  `mutation_id` int(11) NOT NULL,
	`uniprot` char(6) not null,
	`position` int(5) DEFAULT NULL, 
  `wt` enum('A','C','D','E','F','G','H','I','K','L','M','N','P','Q','R','S','T','V','W','Y','J') default NULL,
  `mut` enum('A','C','D','E','F','G','H','I','K','L','M','N','P','Q','R','S','T','V','W','Y','J') default NULL,
  PRIMARY KEY (`id`),
  KEY (`mutation_id`),
  KEY `uniprot` (`uniprot`,`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
