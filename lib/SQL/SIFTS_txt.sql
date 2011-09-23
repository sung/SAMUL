--
-- Table structure for table `PDB2CATH`
--

DROP TABLE IF EXISTS `PDB2CATH`;
CREATE TABLE IF NOT EXISTS `PDB2CATH` (
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `uniprot` char(6) NOT NULL,
  `cath` char(6) NOT NULL,
  PRIMARY KEY  (`pdb`,`chain`,`cath`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `PDB2Enzyme`
--

DROP TABLE IF EXISTS `PDB2Enzyme`;
CREATE TABLE IF NOT EXISTS `PDB2Enzyme` (
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `uniprot` char(6) NOT NULL,
  `ec_num` varchar(10) NOT NULL,
  KEY `enzyme` (`pdb`,`chain`,`ec_num`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `PDB2GO`
--

DROP TABLE IF EXISTS `PDB2GO`;
CREATE TABLE IF NOT EXISTS `PDB2GO` (
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `uniprot` char(6) NOT NULL,
  `go` varchar(15) NOT NULL,
  KEY `GO` (`pdb`,`chain`,`go`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `PDB2InterPro`
--

DROP TABLE IF EXISTS `PDB2InterPro`;
CREATE TABLE IF NOT EXISTS `PDB2InterPro` (
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `interpro` char(9) NOT NULL,
  KEY `interpro` (`pdb`,`chain`,`interpro`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `PDB2Pfam`
--

DROP TABLE IF EXISTS `PDB2Pfam`;
CREATE TABLE IF NOT EXISTS `PDB2Pfam` (
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `uniprot` char(6) NOT NULL,
  `pfam` char(7) NOT NULL,
  PRIMARY KEY  (`pdb`,`chain`,`pfam`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `PDB2PubMed`
--

DROP TABLE IF EXISTS `PDB2PubMed`;
CREATE TABLE IF NOT EXISTS `PDB2PubMed` (
  `pdb` char(4) NOT NULL,
  `ordinal` int(2) NOT NULL,
  `pubmed_id` int(10) NOT NULL,
  PRIMARY KEY  (`pdb`,`ordinal`,`pubmed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `PDB2SCOP`
--

DROP TABLE IF EXISTS `PDB2SCOP`;
CREATE TABLE IF NOT EXISTS `PDB2SCOP` (
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `uniprot` char(6) NOT NULL,
  `sun_id` int(6) NOT NULL,
  `sid` char(7) NOT NULL,
  PRIMARY KEY  (`pdb`,`chain`,`sid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `PDB2Taxonomy`
--

DROP TABLE IF EXISTS `PDB2Taxonomy`;
CREATE TABLE IF NOT EXISTS `PDB2Taxonomy` (
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `tax_id` int(8) NOT NULL,
  `mol_type` enum('PROTEIN','NUCLEIC') NOT NULL,
  `tax_name` tinytext NOT NULL,
  KEY `pdb` (`pdb`,`chain`),
  KEY `reference` (`pdb`,`chain`,`tax_id`,`tax_name`(50))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `PDB2UniProt`
--

DROP TABLE IF EXISTS `PDB2UniProt`;
CREATE TABLE IF NOT EXISTS `PDB2UniProt` (
  `pdb` char(4) NOT NULL,
  `chain` char(2) character set utf8 collate utf8_bin NOT NULL,
  `uniprot` char(6) NOT NULL,
  `seqres_begin` int(6) NOT NULL,
  `seqres_end` int(6) NOT NULL,
  `pdb_begin` varchar(6) NOT NULL,
  `pdb_end` varchar(6) NOT NULL,
  `uniprot_begin` int(6) NOT NULL,
  `uniprot_end` int(6) NOT NULL,
  KEY `pdb` (`pdb`,`chain`,`seqres_begin`,`seqres_end`,`pdb_begin`,`pdb_end`),
  KEY `reference` (`uniprot`,`uniprot_begin`,`uniprot_end`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

