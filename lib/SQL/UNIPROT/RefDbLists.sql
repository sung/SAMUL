DROP TABLE IF EXISTS `RefDbLists`;
CREATE TABLE `RefDbLists` (
  `id` int(3) NOT NULL,
  `db` char(12) NOT NULL,
  PRIMARY KEY  (`id`,`db`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

