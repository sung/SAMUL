DROP TABLE IF EXISTS `featureId`;
CREATE TABLE if not exists `featureId`(
  `id` int(11) NOT NULL default '0',
  `val` varchar(40) default null, 

  PRIMARY KEY  (`id`),
  KEY `val` (`val`(14))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
