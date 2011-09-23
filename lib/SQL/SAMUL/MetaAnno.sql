drop table if exists MetaAnno;
create table MetaAnno(
	id int(5) not null auto_increment,
	source enum('TLB', 'UNIPROT', 'CSA', 'COSMIC', 'ENSEMBL', 'PDB') not null,
	anno varchar(20) not null,
	version varchar(20) default null,
	url varchar(100) default null,
	des tinytext not null,
	res_cnt_pdb int(11) not null default 0,
	res_cnt_uniprot int(11) not null default 0,
	id_cnt_pdb int(11) not null default 0,
	id_cnt_uniprot int(11) not null default 0,
	total int(11) not null default 0,

	PRIMARY KEY  (`id`),
	UNIQUE KEY (`anno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


/*
 *insert data with URL and description
 */
insert into MetaAnno (source, anno, url, des)
values
('TLB','PICCOLO','http://mordred.bioc.cam.ac.uk/piccolo/piccolo.php', 'Protein-protein interaction database'),
('TLB','CREDO','http://www-cryst.bioc.cam.ac.uk/credo', 'A protein-ligand interaction database for drug discovery'),
('UNIPROT', 'REGION', 'http://www.uniprot.org/manual/region', 'Extent of a region of interest in the sequence'),
('UNIPROT', 'VAR_SEQ', 'http://www.uniprot.org/manual/var_seq', 'Description of sequence variants produced by alternative splicing, alternative promoter usage, alternative initiation and ribosomal frameshifting'), 
('UNIPROT', 'VARIANT', 'http://www.uniprot.org/manual/variant', 'Authors report that sequence variants exist'),
('TLB', 'BIPA', 'http://www-cryst.bioc.cam.ac.uk/bipa','Biological Interaction database for Protein-nucleic Acid'),
('ENSEMBL', 'ENVAR', 'http://www.ensembl.org/info/docs/variation/index.html', 'Ensembl Human variation database'),
('UNIPROT', 'HUMSAVAR', 'http://www.uniprot.org/docs/humsavar', 'Human polymorphisms and disease mutations'),
('CSA', 'CSA_PSI', 'http://www.ebi.ac.uk/thornton-srv/databases/CSA/', 'A database documenting enzyme active sites and catalytic residues in enzymes of 3D structure: homologous entries, found by PSI-BLAST alignment to one of the original entries'), 
('UNIPROT', 'TRANSMEM', 'http://www.uniprot.org/manual/transmem', 'Extent of a transmembrane region'),
('UNIPROT', 'NP_BIND', 'http://www.uniprot.org/manual/np_bind', 'Extent of a nucleotide phosphate-binding region'),
('UNIPROT', 'MUTAGEN', 'http://www.uniprot.org/manual/mutagen', 'Site which has been experimentally altered by mutagenesis'),
('UNIPROT', 'DISULFID','http://www.uniprot.org/manual/disulfid', 'Cysteine residues participating in disulfide bonds'),
('UNIPROT', 'METAL', 'http://www.uniprot.org/manual/metal', 'Binding site for a metal ion'),
('UNIPROT', 'DNA_BIND', 'http://www.uniprot.org/manual/dna_bind', 'Denotes the position and type of a DNA-binding domain'),
('UNIPROT', 'MODRES', 'http://www.uniprot.org/manual/mod_res', 'Modified residues excluding lipids, glycans and protein crosslinks'),
('PDB', 'MOD_RES', 'http://www.wwpdb.org/documentation/format32/sect3.html#MODRES', 'descriptions of modifications (e.g., chemical or post-translational) to protein and nucleic acid residues'),
('UNIPROT', 'BINDING', 'http://www.uniprot.org/manual/binding', 'Binding site for any chemical group (co-enzyme, prosthetic group, etc.)'),
('UNIPROT', 'ZN_FING', 'http://www.uniprot.org/manual/zn_fing', 'Denotes the position(s) and type(s) of zinc fingers within the protein'),
('UNIPROT', 'ACT_SITE', 'http://www.uniprot.org/manual/act_site', 'Amino acid(s) directly involved in the activity of an enzyme'),
('UNIPROT', 'PEPTIDE', 'http://www.uniprot.org/manual/peptide', 'Extent of an active peptide in the mature protein'),
('UNIPROT', 'MOTIF', 'http://www.uniprot.org/manual/motif', 'Short (up to 20 amino acids) sequence motif of biological interest'),
('COSMIC', 'COSMIC', 'http://www.sanger.ac.uk/genetics/CGP/cosmic/', 'Catalogue Of Somatic Mutations In Cancer'),
('UNIPROT', 'COMPBIAS', 'http://www.uniprot.org/manual/compbias', 'Region of compositional bias in the protein'),
('UNIPROT', 'CARBOHYD', 'http://www.uniprot.org/manual/carbohyd', 'Covalently attached glycan group(s)'),
('UNIPROT', 'CA_BIND', 'http://www.uniprot.org/manual/ca_bind', 'Denotes the position(s) of calcium binding region(s) within the protein'),
('UNIPROT', 'PROPEP', 'http://www.uniprot.org/manual/propep', 'Part of a protein that is cleaved during maturation or activation'), 
('UNIPROT', 'SITE', 'http://www.uniprot.org/manual/site', 'Any interesting single amino acid site on the sequence'),
('UNIPROT', 'SIGNAL', 'http://www.uniprot.org/manual/signal', 'Sequence targeting proteins to the secretory pathway or periplasmic space'),
('UNIPROT', 'TRANSIT', 'http://www.uniprot.org/manual/transit', 'Extent of a transit peptide for organelle targeting'),
('CSA', 'CSA_LIT', 'http://www.ebi.ac.uk/thornton-srv/databases/CSA/', 'A database documenting enzyme active sites and catalytic residues in enzymes of 3D structure: original hand-annotated entries, derived from the primary literature'),
('UNIPROT', 'CROSSLNK', 'http://www.uniprot.org/manual/crosslnk', 'Residues participating in covalent linkage(s) between proteins'),
('UNIPROT', 'NON_TER', 'http://www.uniprot.org/manual/non_ter', 'The sequence is incomplete. Indicate that a residue is not the terminal residue of the complete protein'),
('UNIPROT', 'LIPID', 'http://www.uniprot.org/manual/lipid', 'Covalently attached lipid group(s)');

/*
 * NO. of residue occurrence from FuncRes
update MetaAnno m
join (
	select if( type='PICCOLO' or type='CREDO' or type='BIPA', 'TLB', 
				if( type='CSA_PSI' or type='CSA_LIT', 'CSA', 
					if( type='COSMIC', 'COSMIC', 
						if(type='ENVAR', 'ENSEMBLVARIATION', 'UNIPROT') 
					) 
				)  
			) as source,
	type, count(id) cnt
	from GLORIA.FuncRes
	group by type
) t on m.source=t.source and m.anno=t.type
set m.res_cnt_pdb=t.cnt
 */

/*
 * NO. of residue occurrence from FuncRes
 */
update MetaAnno m
join (
	select type, count(id) cnt
	from GLORIA.FuncRes
	group by type
) t on m.anno=t.type
set m.res_cnt_pdb=t.cnt;

/*
 * NO. of PDB ID occurrence from FuncRes 
 */
update MetaAnno m
join (
	select t1.type, count(distinct t2.pdb) cnt
	from GLORIA.FuncRes t1
	join GLORIA.ResMap t2 on t1.res_id=t2.res_id
	group by t1.type
) t on m.anno=t.type
set m.id_cnt_pdb=t.cnt;

/*
 * NO. of residue occurrence from UniProt feature
 */
update MetaAnno m
join (
	select t2.val, sum(if(t2.val='DISULFID' or t2.val='CROSSLNK', 2, t1.end-t1.start+1)) total
	from UNIPROT.feature t1
	join UNIPROT.featureClass t2 on t1.featureClass=t2.id
	where (t2.val!='HELIX' and t2.val!='TURN' and t2.val!='NON_CONS' and t2.val!='UNSURE' and t2.val!='CHAIN' and t2.val!='REPEAT' and t2.val!='NON_STD' and t2.val!='DOMAIN' and t2.val!='COILED' and t2.val!='STRAND' and t2.val!='CONFLICT' and t2.val!='INIT_MET')
	group by t2.val
) t on m.anno=t.val
set m.res_cnt_uniprot=t.total;

/*
 * NO. of ID occurrence from UniProt feature
 */
update MetaAnno m
join (
	select 'UNIPROT', t2.val, count(distinct t1.acc) total
	from UNIPROT.feature t1
	join UNIPROT.featureClass t2 on t1.featureClass=t2.id
	where (t2.val!='HELIX' and t2.val!='TURN' and t2.val!='NON_CONS' and t2.val!='UNSURE' and t2.val!='CHAIN' and t2.val!='REPEAT' and t2.val!='NON_STD' and t2.val!='DOMAIN' and t2.val!='COILED' and t2.val!='STRAND' and t2.val!='CONFLICT' and t2.val!='INIT_MET')
	group by t2.val
) t on m.anno=t.val
set m.id_cnt_uniprot=t.total;

/*
 * NO. of total residue occurrence (with redudany)
 */
update MetaAnno m
join (
	select t2.type, count(*) total
	from GLORIA.ResMap t1
	left join GLORIA.FuncRes t2 on t1.res_id=t2.res_id
	where t1.pdb_res_num is not null
	group by t2.type
) t on m.anno=t.type
set m.total=t.total;
