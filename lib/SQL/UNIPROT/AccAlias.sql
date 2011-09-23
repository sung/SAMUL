DROP TABLE IF EXISTS `AccAlias`;
CREATE TABLE `AccAlias` (
  `id` int(11) NOT NULL auto_increment,
  `acc` char(12) NOT NULL,
  `alias` char(12) NOT NULL,

  PRIMARY KEY  (`id`),
  KEY  (`acc`),
  KEY (`alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
