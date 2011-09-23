package Samul::Web::Controller::PDB;

use strict;
use warnings;
use parent 'Catalyst::Controller';


=head1 NAME

Samul::Web::Controller::PDB - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 set chache directory for pdbws
=cut
sub begin: Private{
    my ( $self, $c ) = @_;
	$c->model('PDBWS')->soap_api->cache($c->config->{pdbws_cache});
}


=head2 /pdb
=cut
sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    #$c->response->body('Matched Samul::Web::Controller::PDB in PDB.');
 	$c->stash->{type}='All';
	$c->forward('list');


}

=head2 /pdb?page=xx&limit=yy&total=zz
=cut
sub list :Args(0){
    my ( $self, $c ) = @_;

	my %cond; #constraints depending on $type
	$cond{is_resmap}=1;	#by default

	#/pdb/class/xx
	if($c->stash->{type} eq 'class'){
		$cond{header}=$c->stash->{list_this};
	}else{
	
	}

=pdbws using pdb web services (extrely slow)
	my $index=($page-1)*($limit-1);
    my @rs=$c->model("GLORIA::Pdb2uniprot")->search(
		undef,
		{
			# group by
			columns=>[qw/pdb/],
			distinct=>1,
		},
    #)->slice($index,$index+$limit-1);
	my @pdbs;
	foreach my $rs(@rs){
		push @pdbs, $rs->pdb;
	}
	$c->forward('get_www_pdbs', \@pdbs);
=cut

	# get total number of entries
	$c->stash->{total}= $c->request->params->{total} if $c->request->params->{total};
	unless($c->stash->{total}){
		$c->stash->{total}=$c->model("SAMUL::Metapdb")->search(
			\%cond,
			{
				column=>[qw/id/],
			},
    	)->count();
	}

	# alwasy set $c->stash-{total} before forwarding
	# set paging values (page, limit, pager)
	$c->forward('/pager/set_page',[10]);

	# get data
    $c->stash->{metapdbs}=[$c->model("SAMUL::Metapdb")->search(
		\%cond,
		{
			page=>$c->stash->{page},
			rows=>$c->stash->{limit},
		},
	)];

    $c->stash->{template} = 'PDB/list.tt2';
}

=head2 /PDB /PDB/1pdb /PDB/1pdb/jmol /PDB/1pdb/A /PDB/1pdb/A/resmap
	either redirected from /search/by_ids/id=xx&id_type=PDB 
	or direct access from the URL:/pdb/xx
=cut
sub base_cap1: Path('/PDB') Global{
    my ($self, $c) = @_;
	my $num_arg=scalar @{$c->req->args};

	$c->forward('index') if $num_arg==0;	# /PDB
	$c->forward('base1') if $num_arg==1;	# /PDB/1a25
	if($num_arg==2){
		# /PDB/1a25/jmol
		if($c->req->args->[1] eq 'jmol'){
			$c->forward('sanitize1');
			$c->forward('jmol');
		# /PDB/1a25/A
		}else{
			$c->forward('base2');
		}
	}
	if($num_arg==3){
		# /PDB/1a25/A/resmap
		$c->forward('sanitize2');
		$c->forward('resmap');
	}
}

=head1 /pdb/* (e.g. /pdb/1a25)
	either redirected from /search/by_ids/id=xx&id_type=yy 
	or direct access from the URL:/pdb/xx
=cut
sub base1: PathPart('pdb') Chained('/') Args(1){
    my ($self, $c, $id) = @_;
	$id=lc $id;

	# in case of calling from 'by_ids' which res->redirect 
	$c->stash->{id}=$id unless defined $c->stash->{id};

	# is $id OK
	$c->forward('check_id');
	# sanitize for a given id
	$c->forward('/search/sanitizer', [qw/pdb/]);

	# get chains and uniprot accessions from Pdb2uniprot
	# set $c->stash->{chains} (pdb_chain_id, uniprot)
	$c->forward('get_uniprots', [$id]);

	# get data from metapdb
	# set $c->stash->{metapdbs}
	$c->forward('get_meta_pdbs', [$id]);

	# get pdb info via pdbws
	# set $c->stash->{wwwpdbs}
	$c->forward('get_www_pdbs', [$id]);

	# set $c->stash->{polymers}
	$c->forward('get_polymers', [$id]);

	# set $c->stash->{ligands}
	$c->forward('get_ligands', [$id]);

	# [todo] mutations onto PDB
	$c->stash->{template} = 'PDB/pdb.tt2';
}

=head2 /pdb/class/* (e.g. /pdb/class/OXYGEN TRANSPORT)
	[todo] HYDROLASE/DNA (argument contains '/')
=cut
sub class_base :PathPart('pdb/class') :Chained('/'){
    my ($self, $c, @string) = @_;

	$c->detach('/messenger/err_msg', ["Please type pdb header to search"]) unless @string;
	my $header=join('/', @string); 

	$c->stash->{type}='class';
	$c->stash->{list_this}=$header;
	$c->forward('list');
}

=head1 /pdb/*/* (e.g. /pdb/1a25/A)
	preprocess pdb_id and pdb_chain
	is pdb_id and pdb_chain sane?
	pdb_id/chain both in the database?	
=cut
sub base2 :PathPart('pdb') :Chained('/') :Args(2){
    my ($self, $c, $id, $chain) = @_;

	$c->stash->{id}=lc$id;
	$c->stash->{chain}=$chain;	#chase sensitivie

	# is $id OK
	$c->forward('check_id');
	# is $chain OK
	$c->forward('check_chain');

	# sanitize for a given id
	$c->forward('/search/sanitizer', [qw/pdbc/]);

	# $c->stash->{go_terms}
	$c->forward('get_go_terms', [($id, $chain)]);

	# $c->stash->{funcres}
	$c->forward('get_funcres', [($id, $chain)]);

	# get annotation codes (this is mainly for toolitp)
	$c->stash->{metaannos} = [$c->model('SAMUL::Metaanno')->search(undef,{order_by=>[qw/source/]})];

	# [todo] displaying any other info rather than forwarding to */resmap ?
	$c->stash->{template} = 'PDB/pdb_chain.tt2';
}

=head2 /pdb/*/* (/pdb/1a25/jmol)
	pdb part
=cut
sub sanitize1: PathPart('pdb') Chained('/') CaptureArgs(1){
    my ($self, $c, $id) = @_;

	$c->stash->{id}=lc$id;
	# is $id OK
	$c->forward('check_id');

	# sanitize for a given id
	$c->forward('/search/sanitizer', [qw/pdb/]);
}

=head2 /pdb/1a25/A/jmol /pdb/1a25/A/resmap 
	pdb and chain part
=cut
sub sanitize2: PathPart('pdb') Chained('/') CaptureArgs(2){
    my ($self, $c, $id, $chain) = @_;

	$c->stash->{id}=lc$id;
	$c->stash->{chain}=$chain;	#chase sensitivie

	# is $id OK
	$c->forward('check_id');
	# is $chain OK
	$c->forward('check_chain');

	# sanitize for a given both pdb and chain
	$c->forward('/search/sanitizer', [qw/pdbc/]);
}

=head2 /pdb/*/jmol (e.g. /pdb/1a25/jmol, /pdb/1a25/jmol?hl=2:A,11:B&anno=ACT_SITE,BINDING)
	invoke Jmol template
=cut
sub jmol: PathPart('jmol') Chained(sanitize1) Args(0) {
	my ($self, $c) = @_;

	$c->stash->{hl}= $c->request->params->{hl} if $c->request->params->{hl};
	$c->stash->{label}= $c->request->params->{label} if $c->request->params->{label};
	$c->stash->{bgcolor}= $c->request->params->{bgcolor} if $c->request->params->{bgcolor};
	# frame.tt2 splits into two, each of which 
	# /show/pdb/$id and 
	# /show/load_jmol/$id
	$c->stash->{template} = 'Jmol/jmol_frame.tt2';
}

=head2 /pdb/*/*/resmap (e.g. /pdb/1a25/A/resmap)
	/pdb/xx/yy/resmap (Presenting an alignment between PDB and UniPort via ResMap)
	Presenting an alignment between PDB and UniPort via ResMap 
=cut
sub resmap: PathPart('resmap') Chained('sanitize2') Args(0){
    my ($self, $c) = @_;

	# get alignment
	$c->forward('get_resmap');
	# load css in JOY format 
	$c->forward('load_env_css');
	# let's display them
	$c->stash->{template} = 'PDB/resmap.tt2';
}

=head2 /pdb/*/*/resmap/download/[csv|plain] (e.g. /pdb/1a25/A/resmap/download/[csv|plain])
	Catalyst::View::Download
	[todo] moved to Download controller
=cut
sub download: PathPart('resmap/download') Chained('sanitize2') Args(1){
    my ($self, $c, $content_type) = @_;
	lc$content_type if $content_type;

	# get alignment
    # $c->stash->{resmaps} = # ref of arrary of hash 
	$c->forward('get_resmap');

	# 'plain', 'csv', 'html', or 'xml'
	# my $content_type = $c->request->params->{'content_type'} or 'plain';
	# Set the content type so Catalyst::View::Download can determine how 
    # to process it.
	#$c->header('Content-Type' => 'text/'.$content_type); 
    # Or set the content type in the stash variable 'download' 
    # to process it. (Note: this is configurable)
    $c->stash->{'download'} = 'text/'.$content_type; 

	# serialize the data from array reference
	my ($cnt,@data);
	foreach my $resmap (@{$c->stash->{resmaps}}){
		#pdb, res_num, pdb_res_1code, pdb_res_num, pdb_res_3code, uniprot, uniprot_res_num 
		my $env=$resmap->get_column('env');
		my $type=$resmap->get_column('type');
		# header
		unless($cnt){
			$data[$cnt]=
			['#PDB', 'PDB_CHAIN', 'RES_NUM', 'SEQ_RES', 'ATM_RES_NUM', 'ATM_RES', 'UNIPROT', 'UNIPROT_RES', 'ENV', 'ANNOTATIONS'];
		# data in contents
		}else{
			$data[$cnt]=
			[$c->stash->{id}, $c->stash->{chain}, $resmap->res_num, $resmap->res_1code, $resmap->pdb_res_num, $resmap->res_3code, $c->stash->{is_id}, $resmap->uniprot_res_code, $env, $type];
		}
		++$cnt;
	}

	# For plain text in this example we just dump the example array.
	# Catalyst::View::Download::Plain can use either the 'plain'
    # stash key or just pull from $c->response->body.
	my $file_name_base=$c->stash->{id}.$c->stash->{chain};

	if($content_type eq 'plain'){
		$c->view('Samul::Web::View::Download')->config(
			'content_type' => {
				'text/plain' => {
					'outfile' => "$file_name_base\_resmap.txt",
				},
			},
		);
		use Data::Dumper;
    	$c->stash->{$content_type} = {
			data => Dumper( \@data ),
	    };
	}elsif($content_type eq 'csv'){
=nok
		$c->view('Samul::Web::View::Download')->config->{'content_type'}{'text/csv'}={
			'outfile' => "$file_name_base.csv",
		};
=cut
		$c->view('Samul::Web::View::Download')->config(
			'content_type' => {
				'text/csv' => {
					'outfile' => "$file_name_base\_resmap.txt",
				},
			},
		);
    	$c->stash->{$content_type} = {
			data => \@data,
	    };
	}else{
		my @messenger;
		push @messenger,"[ERROR] $content_type not supported yet";	
		push @messenger,"choose either 'csv' or 'plain'";	
		$c->detach('/messenger/err_msg', \@messenger);
	}

	# Finally forward processing to the Download View
	$c->forward('Samul::Web::View::Download');
}# end of download

=head2 called by 'sub resmap'
=cut
sub load_env_css: Private{
    my ($self, $c) = @_;

	# [todo] env move to .conf
	my %ss=(
		H=>'helix ',
		E=>'beta_sheet ',
		P=>'positive_phi ',
		C=>'coil ',
	);
	my %acc=(
		A=>'surface ',
		a=>'buiried ',
	);
	my %hbond_sc=(
		S=>'hbond_sc ',
		s=>'',
	);
	my %hbond_co=(
		O=>'hbond_co ',
		o=>'',
	);
	my %hbond_nh=(
		N=>'hbond_nh ',
		n=>'',
	);

	my %css;
	foreach my $sec(keys %ss){
		foreach my $ac (keys %acc){
			foreach my $sc (keys %hbond_sc){
				foreach my $co(keys %hbond_co){
					foreach my $nh (keys %hbond_nh){
						$css{$sec.$ac.$sc.$co.$nh}=$ss{$sec}.$acc{$ac}.$hbond_sc{$sc}.$hbond_co{$co}.$hbond_nh{$nh};;
					}
				}
			}
		}
	}
	$c->stash->{css}=\%css;
}

=head1 /pdb/$pdb_id
=cut
sub check_id: Private{
    my ($self, $c) = @_;
	my $id=$c->stash->{id};
	if($id=~/^\d{1}\w{3}$/){
		$c->stash->{id_ok}=1;
	}else{
		$c->detach('/messenger/err_msg', ["[ERROR] Wrong pdb identifier ($id). It should be an one numeric followed by three alpha-numeric for pdb identifier"]);
	}
}

=head1 /pdb/$pdb_id/$pdb_chain
=cut
sub check_chain: Private{
    my ($self, $c) = @_;
	my $id=$c->stash->{id};
	my $chain=$c->stash->{chain};
	if($chain=~/^\w{1}$/){
		$c->stash->{chain_ok}=1;
	}else{
		$c->detach('/messenger/err_msg', ["[ERROR] Chain $chain should be an alpha-numeric for $id"]);
	}
}

=head2
	get pdb chain given id
=cut
sub get_uniprots: Private{
    my ($self, $c) = @_;

	my %cond; 
	my %dummy;
	$cond{pdb}=$c->req->args->[0] if defined $c->req->args->[0];
	$cond{pdb_chain_id}=$c->req->args->[1] if defined $c->req->args->[1];
    foreach my $rs ($c->model("GLORIA::Pdb2uniprot")->search(\%cond,{select=>[qw/pdb_chain_id uniprot/]})){
		#$c->stash->{pdb2uniprot}=($rs->pdb => $rs->uniprot)
    	$dummy{$rs->pdb_chain_id}=$rs->uniprot;
	}

	# $c->stash->{pdb2uniprot} is a hash ref (not a list ref)
	$c->stash->{pdb2uniprot}=\%dummy;
}

=head2 get_meta_pdbs
=cut
sub get_meta_pdbs: Private{
    my ($self,$c) = @_;

	my @dummy;
	foreach my $pdb (@{$c->req->args}){
	    push @dummy, $c->model("SAMUL::Metapdb")->find({pdb=>$pdb});
	}
	$c->stash->{metapdbs}=\@dummy;
}

=head2 get_www_pdbs
	extremly slow for more than 3 pdb ids
=cut
sub get_www_pdbs: Private{
    my ($self,$c) = @_;
    my $ref_ids= $c->req->args; #arrayref

	my @pdbs; #arrayref (of hash)
	my $soap_api=$c->model('PDBWS')->soap_api;	# an accessor for WWW::PDB (return 'WWW::PDB')
	my $cnt=-1;
	foreach my $id(@{$ref_ids}){
		++$cnt;
		#pdb web service using WWW::PDB
		$pdbs[$cnt]={
			id=>$id,
			title=>$soap_api->get_primary_citation_title($id),
			status=>$soap_api->get_status($id),
			pubmed=>$soap_api->get_pubmed_id($id),
			release=>$soap_api->get_release_dates($id),
		};
	}
	$c->stash->{wwwpdbs}=\@pdbs;
}

=head2 get_polymers
	Calls SAMUL::WSC::PDB
	A wrapper for XML::Twig which processes PDB REST service directly
	http://www.rcsb.org/pdb/rest/describeMol?structureId=';
=cut
sub get_polymers: Private{
    my ($self,$c) = @_;

	# consuming pdb rest api from Samul::WSC::PDB via Samul::Model::PDBWS
	$c->stash->{polymers}=$c->model('PDBWS')->get_polymer($c->req->args->[0]);
	$c->stash->{num_polymers}=@{$c->stash->{polymers}};
}

=head2 get_ligands
	Calls SAMUL::WSC::PDB
	but a wrapper for XML::Twig which processes PDB REST service directly
	http://www.rcsb.org/pdb/rest/ligandInfo?structureId=';
=cut
sub get_ligands: Private{
    my ($self,$c) = @_;

	# consuming pdb rest api from Samul::WSC::PDB via Samul::Model::PDBWS
	$c->stash->{ligands}=$c->model('PDBWS')->get_ligand($c->req->args->[0]);
	$c->stash->{num_ligands}=@{$c->stash->{ligands}};
}

=head2 get_go_terms
	Calls SAMUL::WSC::PDB
	A wrapper for XML::Twig which processes PDB REST service directly
	http://www.pdb.org/pdb/rest/goTerms?structureId=
=cut
sub get_go_terms: Private{
    my ($self, $c) = @_;
	# consuming pdb rest api from Samul::WSC::PDB via Samul::Model::PDBWS
	$c->stash->{go_terms}=$c->model('PDBWS')->get_go_terms($c->req->args->[0], $c->req->args->[1]);
}

sub get_funcres: Private{
    my ($self, $c) = @_;

	my %cond;
	$cond{'me.pdb'}=$c->req->args->[0] if defined $c->req->args->[0];
	$cond{'me.pdb_chain_id'}=$c->req->args->[1] if defined $c->req->args->[1];
    $c->stash->{funcres} = [$c->model("GLORIA::Resmap")->search(
		\%cond,
        {
			select=>[qw/me.pdb_chain_id me.res_3code concat_ws('',me.pdb_res_num,me.ins_code) FuncRes.type FuncRes.des/],
			as=>[qw/chain res_3code res_num type des/],
			join=>[qw/FuncRes/],
        }
    )];
}

sub get_resmap: Private{
    my ($self, $c) = @_;

	# 'has_many' produces a LEFT JOIN by default
	my $c_ResMap=$c->config->{c_resmap};
    $c->stash->{resmaps} = [$c->model("GLORIA::$c_ResMap")->search(
        {
            'me.pdb'=>$c->stash->{id},
            'me.pdb_chain_id'=>$c->stash->{chain},
        },
        {
			select=>[qw/res_num ifnull(me.res_1code,'-') ifnull(me.res_3code,'-') ifnull(me.uniprot_res_num,'-') ifnull(me.uniprot_res_code,'-') if(concat_ws('',me.pdb_res_num,me.ins_code)='','-',concat_ws('',me.pdb_res_num,me.ins_code)) ResAnno.env/, \'group_concat(distinct FuncRes.type separator \', \')'],
			as=>[qw/res_num res_1code res_3code uniprot_res_num uniprot_res_code pdb_res_num env type/],
			join=>[qw/ResAnno FuncRes/],
			group_by=>[qw/me.res_id/],
			order_by=>[qw/me.res_id/],
        }
    )];
}


=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
