DROP TABLE IF EXISTS `feature`;
CREATE TABLE if not exists `feature`(
  `id` int(11) NOT NULL auto_increment,
  `acc` char(12) NOT NULL default '',
  `start` int(11) default null,
  `end` int(11) default null,

  `featureVariant` int(11) default null,
  `featureClass` int(11) NOT NULL default '0',
  `featureType` int(11) default null,
  `featureId` int(11) default null,

  PRIMARY KEY  (`id`),
  KEY `acc` (`acc`, `start`, `end`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
