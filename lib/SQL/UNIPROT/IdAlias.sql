DROP TABLE IF EXISTS `IdAlias`;
CREATE TABLE `IdAlias` (
  `id` int(11) NOT NULL auto_increment,
  `display_id` char(12) NOT NULL,
  `alias` char(12) NOT NULL,

  PRIMARY KEY  (`id`),
  UNIQUE KEY  (`display_id`,`alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

