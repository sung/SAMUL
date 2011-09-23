DROP TABLE IF EXISTS `UniProtSeq`;
CREATE TABLE `UniProtSeq` (
  `id` int(11) NOT NULL auto_increment,
  `acc` char(12) NOT NULL,
  `display_id` char(12) NOT NULL,
  `name` varchar(300),
  `gene` char(20) not null,
  `length` int(5) NOT NULL,
  `mw` int(10) default NULL,
  `sequence` longtext,
  `is_sp` int(1) not null,
  `tax_id` int(11) not null,

  PRIMARY KEY  (`id`),
  UNIQUE KEY  (`acc`),
  UNIQUE KEY  (`display_id`),
  KEY (`tax_id`),
  KEY `gene` (`gene`),
  fulltext index (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
