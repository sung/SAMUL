DROP TABLE IF EXISTS `Clusters`;
CREATE TABLE `Clusters` (
	`pid` int(3) not null,
	`cluster_id` int(5) not null,
	`member_id` int(3) not null,
	`pdb` char(4) not NULL,                                                
	`pdb_chain_id` char(2) character set utf8 collate utf8_bin not NULL,
	PRIMARY KEY  (`pid`,`cluster_id`,`member_id`),    
	KEY (`pid`),
	KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
