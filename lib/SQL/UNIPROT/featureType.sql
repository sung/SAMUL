DROP TABLE IF EXISTS `featureType`;
CREATE TABLE if not exists `featureType`(
  `id` int(11) NOT NULL default '0',
  `val` longtext default null,
  PRIMARY KEY  (`id`),
  KEY `val` (`val`(12))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
