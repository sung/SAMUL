DROP TABLE IF EXISTS `DbRef`;
CREATE TABLE `DbRef` (
  `id` int(11) NOT NULL auto_increment,
  `acc` char(12) NOT NULL,
  `db_id` int(3) NOT NULL,
  `entry` char(100) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY (`acc`),
  KEY (`db_id`, `entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
