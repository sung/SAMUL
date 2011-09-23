DROP TABLE IF EXISTS `Ensp2UniProt`;
CREATE TABLE `Ensp2UniProt` (
  `id` int(11) not null auto_increment,
  `ensp` varchar(50) NOT NULL,
  `ensp_res_num` int(5) not null,
  `ensp_res` char(1) not null,

  `uniprot` char(6) not null,
  `uniprot_res_num` int(5) default null,
  `uniprot_res` char(1) default null,
  `is_same_seq` int(1) not null,

  PRIMARY KEY  (`id`),
  index ensp_id (`ensp`),
  UNIQUE KEY (`ensp`, `ensp_res_num`, `uniprot`),
  KEY  (`uniprot`, `uniprot_res_num`, `uniprot_res`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

