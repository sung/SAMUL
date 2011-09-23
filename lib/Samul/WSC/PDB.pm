#!/usr/bin/perl -w

=head1 TODO
 [todo] Use 'deligation' of Moose for 'WWW::PDB' 
 http://search.cpan.org/~flora/Moose-1.03/lib/Moose/Manual/Delegation.pod
 e.g.
 has 'api' => (
	is	=>'ro',
	isa	=>'WWW::PDB', # the delegatee (the real 'class')
	handles	=>{
		get_title=>'get_primary_citation_title',
		get_status=>'get_status',
		get_pubmed=>'get_pubmed_id',
		...
	}

	# or simply
	handles => qr/^(?:get.*)/,
	...	
	#in the main consumer (no accessor needed for 'api', so is=>'ro' could be omitted from the above)
	$c->model('PDBWS')->get_title;
	$c->model('PDBWS')->get_status;
	$c->model('PDBWS')->get_pubmed;
=cut
package Samul::WSC::PDB;

use Moose;
use WWW::PDB;
#use LWP::Simple;	#XML::Twig::parseurl implements this functionality
use XML::Twig;
use namespace::clean -except=>'meta';

has 'soap_api' => (
	is=> 'ro',
	isa=>'Str', 
	lazy_build=>1,
	);

sub _build_soap_api {
	my ($self)=@_;
	return 'WWW::PDB';
}

=polymer
<structureId id="4HHB">
	<polymerDescriptions>
		<polymer entityNr="1" length="141" type="polypeptide(L)">
			<chain id="A" />
			<chain id="C" />
			<polymerDescription description="HEMOGLOBIN (DEOXY) (ALPHA CHAIN)" />
		</polymer>
		<polymer entityNr="2" length="146" type="polypeptide(L)">
			<chain id="B" />
			<chain id="D" />
			<polymerDescription description="HEMOGLOBIN (DEOXY) (BETA CHAIN)" />
		</polymer>
	</polymerDescriptions>
</structureId>
=cut
sub get_polymer{
	my ($self, $id)=@_;
	die "No pdb identified for buiding get_polymer\n" unless defined $id;
	my $base='http://www.rcsb.org/pdb/rest/describeMol?structureId=';

	my @polymer;
	my $t=XML::Twig->new(
    	twig_handlers=>{
        	'polymer'=>sub{
					my ($t,$elt)=@_;

					my $entity=$elt->att("entityNr") if defined $elt->att("entityNr");
					$polymer[$entity]->{entity}=$entity;
					$polymer[$entity]->{len}=$elt->att("length") if defined $elt->att("length");
					$polymer[$entity]->{type}=$elt->att("type") if defined $elt->att("type");

					my @chains;
					if(defined $elt->children("chain")){
						foreach my $chain($elt->children("chain")){
							push @chains, $chain->att("id");
						}
					}
					$polymer[$entity]->{chains}=\@chains;
					$polymer[$entity]->{desc}=$elt->first_child("polymerDescription")->att("description") if defined $elt->first_child("polymerDescription");
					$polymer[$entity]->{ec}=$elt->first_child("enzClass")->att("ec") if defined $elt->first_child("enzClass");
			},
		},
	);
	$t->safe_parseurl($base.$id);
	$t->purge;

	shift @polymer;	#somehow [0] contains null as $entity starts with '1'
	return \@polymer;
}

sub get_ligand{
	my ($self, $id)=@_;
	die "No pdb identified for buiding get_ligand\n" unless defined $id;
	my $base='http://www.rcsb.org/pdb/rest/ligandInfo?structureId=';

	return &_parse_ligandInfo($base.$id);
}

sub search_smiles{
	my ($self, $smile)=@_;
	die "No smile string identified for buiding search_smile\n" unless defined $smile;
	my $base='http://www.rcsb.org/pdb/rest/smilesQuery?dissimilarity=0.3&search_type=3&smiles=';

	return &_parse_ligandInfo($base.$smile);
}


=goTerms
<goTerms>
	<term id="GO:0005344" structureId="4HHB" chainId="A">
		<detail name="oxygen transporter activity" definition="Enables the directed movement of oxygen into, out of, within or between cells." synonyms="globin, hemerythrin, hemocyanin, oxygen-carrying" ontology="F" />
	</term>
</goTerms>
=cut
sub get_go_terms{
	my ($self, $pdb, $chain)=@_;

	die "No pdb identified\n" unless defined $pdb;
	die "No pdb chain identified\n" unless defined $chain;
	my $base='http://www.pdb.org/pdb/rest/goTerms?structureId=';	#1a25, 1a25.A

	my @go_terms; my $cnt=0;
	my $t=XML::Twig->new(
    	twig_handlers=>{
        	'term'=>sub{
					my ($t,$elt)=@_;

					$go_terms[$cnt]->{id}=$elt->att("id") if defined $elt->att("id");
					$go_terms[$cnt]->{structureId}=$elt->att("structureId") if defined $elt->att("structureId");
					$go_terms[$cnt]->{chainId}=$elt->att("chainId") if defined $elt->att("chainId");

					$go_terms[$cnt]->{name}=$elt->first_child("detail")->att("name") if defined $elt->first_child("detail");
					$go_terms[$cnt]->{definition}=$elt->first_child("detail")->att("definition") if defined $elt->first_child("detail");
					$go_terms[$cnt]->{synonyms}=$elt->first_child("detail")->att("synonyms") if defined $elt->first_child("detail");
					$go_terms[$cnt]->{ontology}=$elt->first_child("detail")->att("ontology") if defined $elt->first_child("detail");
					$cnt++;
			},
		},
	);
	$t->safe_parseurl($base."$pdb.$chain");
	$t->purge;

	return \@go_terms;
}

=ligandInfo
	<ligand structureId="1ETS" chemicalID="NAS"> 
		<chemicalName>2-NAPHTHALENESULFONIC ACID</chemicalName> 
		<formula>C10 H8 O3 S</formula> 
		<smiles>O[S](=O)(=O)c1ccc2ccccc2c1</smiles>
	</ligand>
=cut
sub _parse_ligandInfo{
	my($url)=@_;

	my @dummy; my %check; my @pdbs; my %pdbs; my $cnt=0;
	my $t=XML::Twig->new(
    	twig_handlers=>{
        	'ligand'=>sub{
					my ($t,$elt)=@_;

					my $chemicalID=$elt->att("chemicalID") if $elt->att("chemicalID");
					unless (exists $check{$chemicalID}){
						$dummy[$cnt]->{structureId}=$elt->att("structureId") if $elt->att("structureId");
						$dummy[$cnt]->{chemicalID}=$elt->att("chemicalID") if $elt->att("chemicalID");
						$dummy[$cnt]->{chemicalName}=$elt->first_child_text("chemicalName") if $elt->first_child_text("chemicalName");
						$dummy[$cnt]->{formula}=$elt->first_child_text("formula") if $elt->first_child_text("formula");
						$dummy[$cnt]->{smiles}=$elt->first_child_text("smiles") if $elt->first_child_text("smiles");

						$check{$chemicalID}='';
						$cnt++;
					}
					push @{ $pdbs{$chemicalID} }, $elt->att("structureId") if $chemicalID;
			},
		},
	);
	$t->safe_parseurl($url);
	$t->purge;

	my @ligand;
	$cnt=0;
	foreach my $id(@dummy){
		$ligand[$cnt]->{'chemicalID'}=$id->{'chemicalID'};
		$ligand[$cnt]->{'chemicalName'}=$id->{'chemicalName'};
		$ligand[$cnt]->{'formula'}=$id->{'formula'};
		$ligand[$cnt]->{'smiles'}=$id->{'smiles'};
		$ligand[$cnt]->{'pdbs'}=$pdbs{$id->{'chemicalID'}};

		$cnt++;
	}

	return \@ligand;
}
__PACKAGE__->meta->make_immutable;
1;
