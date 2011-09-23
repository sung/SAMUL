DROP TABLE IF EXISTS `featureVariant`;
CREATE TABLE if not exists `featureVariant`(
  `id` int(11) NOT NULL default '0',
  `ori` text default null,
  `vari` text default null,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
