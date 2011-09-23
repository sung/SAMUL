DROP TABLE IF EXISTS `Segment`;
CREATE TABLE IF NOT EXISTS `Segment` (
  `entry` char(4) NOT NULL,
  `seg_name` varchar(15) character set utf8 collate utf8_bin default NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `start` int(6) NOT NULL,
  `end` int(6) NOT NULL,
  PRIMARY KEY  (`entry`,`chain`,`start`,`end`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

