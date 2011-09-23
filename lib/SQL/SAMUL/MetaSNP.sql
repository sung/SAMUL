drop table if exists SAMUL.MetaSNP;
create table SAMUL.MetaSNP(
	id int(5) not null auto_increment,
	source varchar(100) not null, /*chromosome, supercontig, level, SNP2ENSG, SNP2ENST, SNP2ENSP, SNP2UniProt, SNP2PDB*/
	version varchar(100) default null, /*GRCh37*/
	des varchar(255) not null,
	cnt int(11) default null,
	total int(11) default null,

  PRIMARY KEY  (`id`),
  KEY  (`source`),
  KEY  (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


/* 
 * cnt by chromosome or contig
 * (e.g 'chromosome', 'GRCh37', '1', 12345)
 * (e.g 'chromosome', 'GRCh37', 'X', 12345)
 * (e.g 'supercontig', '\N', 'GL000195.1', 12345)
 */
insert into SAMUL.MetaSNP(source, version, des, cnt) 
select t3.name, t3.version, t2.name, count(distinct t1.variation_id) cnt
from ENSEMBLVARIATION.variation_feature t1
join ENSEMBLCORE.seq_region t2 on t2.seq_region_id=t1.seq_region_id
join ENSEMBLCORE.coord_system t3 on t3.coord_system_id=t2.coord_system_id
group by t3.name, t3.version, t2.name
order by t3.name, cnt desc;

/* 
 * cnt by consequence type from SNP2ENSG
 * (e.g. 'SNP2ENSG', 'SYNONYMOUS_CODING', 12334)
 */
insert into SAMUL.MetaSNP(source, des, cnt, total) 
select 'SNP2ENSG', type, count(distinct rs_id) cnt, count(*) total
from SAMUL.SNP2ENSG
group by type
order by cnt desc;

/* 
 * cnt by consequence type from SNP2ENST 
 * (e.g. 'SNP2ENST', 'SYNONYMOUS_CODING', 12334)
 */
insert into SAMUL.MetaSNP(source, des, cnt, total) 
select 'SNP2ENST', type, count(distinct rs_id) cnt, count(*) total
from SAMUL.SNP2ENST
group by type
order by cnt desc;

/* 
-- cnt by consequence type from SNP2ENSP
 * (e.g. 'SNP2ENSP', 'SYNONYMOUS_CODING', 12334)
 */
insert into SAMUL.MetaSNP(source, des, cnt, total) 
select 'SNP2ENSP', type, count(distinct rs_id) cnt, count(*) total
from SAMUL.SNP2ENSP
group by type
order by cnt desc;

/* 
 * cnt by consequence type from SNP2UNIPROT
 * (e.g. 'SNP2UNIPROT', 'SYNONYMOUS_CODING', 12334)
 */
insert into SAMUL.MetaSNP(source, des, cnt, total) 
select 'SNP2UNIPROT', type, count(distinct rs_id) cnt, count(*) total
from SAMUL.SNP2UNIPROT
group by type
order by cnt desc;

/* 
 * cnt by consequence type from SNP2PDB
 * (e.g. 'SNP2PDB', 'SYNONYMOUS_CODING', 12334)
 */
insert into SAMUL.MetaSNP(source, des, cnt, total) 
select 'SNP2PDB', type, count(distinct rs_id) cnt, count(*) total
from SNP2PDB
group by type
order by cnt desc;

/*
 * cnt by source
 * (e.g. 'snSNP', '130', 'variation feature from dbSNP', 343)
 * (e.g. 'ENSEMBL:Venter', '\N', 'Variation features from the "ENSEMBL:Venter" source', 343)
 */
insert into SAMUL.MetaSNP(source, version, des, cnt, total) 
select t2.name, t2.version, t2.description, count(distinct t1.rs_id), count(*)
from SAMUL.SNP2ENSG t1
join SAMUL.source t2 on t2.source_id=t1.source_id
group by t2.name, t2.version;

/*
 * cnt by chromosime and snp types
 * (e.g. 'chromosome', '1', 'SYNONYMOUS_CODING', 343)
 * (e.g. 'chromosome', 'X', 'SYNONYMOUS_CODING', 343)
 */
insert into SAMUL.MetaSNP(source, version, des, cnt, total) 
select 'chromosome', coord_name, type, count(distinct rs_id) cnt, count(*) total
from SNP2ENSG
group by coord_name, type
order by coord_name, cnt desc;

/* 
 * cnt by level 
 * (e.g. 'level', 'SNP2ENSG', '\N', 12345) 
 * (e.g. 'level', 'SNP2ENST', '\N', 12345) 
 * (e.g. 'level', 'SNP2ENSP', '\N', 12345) 
 * (e.g. 'level', 'SNP2UNIPROT', '\N', 12345) 
 * (e.g. 'level', 'SNP2PDB', '\N', 12345) 
 */
insert into SAMUL.MetaSNP(source, version, cnt, total) 
select 'level', 'SNP2ENSG', count(distinct rs_id), count(*)
from SNP2ENSG;

insert into SAMUL.MetaSNP(source, version, cnt, total) 
select 'level', 'SNP2ENST', count(distinct rs_id), count(*) 
from SNP2ENST;

insert into SAMUL.MetaSNP(source, version, cnt, total) 
select 'level', 'SNP2ENSP', count(distinct rs_id), count(*)
from SNP2ENST;

insert into SAMUL.MetaSNP(source, version, cnt, total) 
select 'level', 'SNP2UNIPROT', count(distinct rs_id), count(*)
from SNP2UNIPROT;

insert into SAMUL.MetaSNP(source, version, cnt, total) 
select 'level', 'SNP2PDB', count(distinct rs_id), count(*)
from SNP2PDB;
