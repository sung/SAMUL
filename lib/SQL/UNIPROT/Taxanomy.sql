DROP TABLE IF EXISTS `Taxanomy`;
CREATE TABLE `Taxanomy` (
  `id` int(11) NOT NULL,
  `sn` tinyblob NOT NULL,
  `cn` tinyblob default null,

  PRIMARY KEY  (`id`),
  KEY  (`sn`(100))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

