DROP TABLE IF EXISTS `featureClass`;
CREATE TABLE if not exists `featureClass`(
  `id` int(11) NOT NULL default '0',
  `val` varchar(255) default null,

  PRIMARY KEY  (`id`),
  KEY `val` (`val`(12))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
