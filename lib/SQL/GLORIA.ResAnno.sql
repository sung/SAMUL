DROP TABLE IF EXISTS `ResAnno`;
CREATE TABLE `ResAnno` (
  `id` int(11) NOT NULL auto_increment,
  `res_id` int(11) default NULL,
  `pdb` char(4) not NULL,                                                
  `pdb_chain_id` char(2) character set utf8 collate utf8_bin not NULL,
  `pdb_local_rescued_res_num` int(5) default NULL,

  `res_1code` char(1) NOT NULL default '',    
  `ss_phi` enum('H','E','P','C') NOT NULL,       
  `solv_acc` enum('T','F') NOT NULL,     
  `hbond_co` enum('T','F') NOT NULL,     
  `hbond_nh` enum('T','F') NOT NULL,     
  `hbond_sc` enum('T','F') NOT NULL,     
  `cispep` enum('T','F') NOT NULL,       
  `hbond_het` enum('T','F') NOT NULL,    
  `covbond_het` enum('T','F') NOT NULL,  
  `disulph` enum('T','F') NOT NULL,      
  `mcmc_amide` enum('T','F') not NULL,   
  `mcmc_carb` enum('T','F') NOT NULL,    
  `dssp` enum('C','G','E','H','I') NOT NULL,         
  `pos_phi` enum('T','F') NOT NULL,      
  `pc_acc` char(1) NOT NULL,       
  `ooi` char(1) NOT NULL,          
  `env` char(5) character set utf8 collate utf8_bin NOT NULL,          

  PRIMARY KEY  (`id`),                                                  
  UNIQUE KEY  (`pdb`,`pdb_chain_id`, `pdb_local_rescued_res_num`, `res_1code`),
  INDEX (`env`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
