DROP TABLE IF EXISTS `Stat`;
CREATE TABLE `Stat` (
  `id` int(5) NOT NULL auto_increment,
  `type` enum('SNP', 'ResMap','FuncRes','Ensembl','UNIPROT') NOT NULL,
  `sub_type` enum('ENSG','ENST','cDNA','ENSP','coding','UNIPROT','PDB','DISULFID', 'ACT_SITE', 'CA_BIND', 'ZN_FING', 'DNA_BIND', 'NP_BIND', 'METAL', 'BINDING', 'LIPID', 'CSA_LIT', 'CSA_PSI', 'VARIANT', 'SAP', 'CREDO', 'BIPA', 'PICCOLO', 'INTERPARE') NOT NULL,
  `num` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `type` (`type`,`sub_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- SNP, ENSG
insert into FACEVIEW.Stat(type, sub_type, num)
select 'SNP', 'ENSG', count(distinct rs_id) from FACEVIEW.SNP2ENSG;
-- SNP, ENST
insert into FACEVIEW.Stat(type, sub_type, num)
select 'SNP', 'ENST', count(distinct rs_id) from FACEVIEW.SNP2ENST;
-- SNP, ENST(cDNA)
insert into FACEVIEW.Stat(type, sub_type, num)
select 'SNP', 'cDNA', count(distinct rs_id) from FACEVIEW.SNP2ENST where start is not null;
-- SNP, ENSP
insert into FACEVIEW.Stat(type, sub_type, num)
select 'SNP', 'ENSP', count(distinct rs_id) from FACEVIEW.SNP2ENSP;
-- SNP, ENSP(coding)
insert into FACEVIEW.Stat(type, sub_type, num)
select 'SNP', 'coding', count(distinct rs_id) from FACEVIEW.SNP2ENSP where start is not null;
-- SNP, UNIPROT 
insert into FACEVIEW.Stat(type, sub_type, num)
select 'SNP', 'UNIPROT', count(distinct rs_id) from FACEVIEW.SNP2UNIPROT;
-- SNP, PDB 
insert into FACEVIEW.Stat(type, sub_type, num)
select 'SNP', 'PDB', count(distinct rs_id) from FACEVIEW.SNP2PDB;

--ResMap
insert into FACEVIEW.Stat(type, sub_type, num)
select 'ResMap', 'PDB', count(distinct pdb) from GLORIA.ResMap;

--UNIPROT
insert into FACEVIEW.Stat(type, sub_type, num)
select 'UNIPROT', is_sp, count(id) from UNIPROT.UniProtSeq group by is_sp;

--UNIPROT (Human)
insert into FACEVIEW.Stat(type, sub_type, num)
select 'UNIPROT', concat('Human_',is_sp), count(id) from UNIPROT.UniProtSeq where tax_id=9606 group by is_sp;

--UNIPROT (Human gene)
insert into FACEVIEW.Stat(type, sub_type, num)
select 'UNIPROT', concat('Human_',is_sp), count(distinct gene) from UNIPROT.UniProtSeq where tax_id=9606 group by is_sp;
