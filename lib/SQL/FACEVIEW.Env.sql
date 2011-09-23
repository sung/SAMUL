DROP TABLE IF EXISTS `Env`;
CREATE TABLE `Env` (
  `id` int(1) NOT NULL auto_increment,
  `env` varchar(150) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

insert into `Env` (`env`) values 
('sequence'),
('secondary structure and phi angle'),
('solvent accessibility'),
('hydrogen bond to mainchain CO'),
('hydrogen bond to mainchain NH'),
('hydrogen bond to other sidechain/heterogen'),
('cis-peptide bond'),
('hydrogen bond to heterogen'),
('covalent bond to heterogen'),
('disulphide'),
('mainchain to mainchain hydrogen bonds (amide)'),
('Mainchain to mainchain hydrogen bonds (carbonyl)'),
('DSSP'),
('positive phi angle'),
('percentage accessibility'),
('Ooi number');
