package Samul::Web::Controller::Search;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Samul::Web::Controller::Search - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    #$c->response->body('Matched Samul::Web::Controller::Search in Search.');
    $c->stash->{template} = 'Search/form.tt2';
}

=head2 hgnc 
	Fetch PDB/Gene/UniProt/ENSP/RefSeq/RSID
=cut

sub hgnc: Local {
    # Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
    # 'Context' that's used to 'glue together' the various components
    # that make up the application
    my ($self, $c) = @_;

    # stash where they can be accessed by the TT template
    $c->stash->{Hgncs} = [$c->model('SAMUL::Hgnc')->slice(0,15)];
    
    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash->{template} = 'Search/hgnc.tt2';
}

=head2 by_keywords
	deprecated
=cut
sub _by_keywords_for_hgnc: Private{
    my ($self, $c) = @_;
	# get parameters
	my $keyword= $c->request->params->{keyword} or $c->detach('/messenger/err_msg', ['Please type your key words']);

    $c->stash->{keyword} = $keyword; 
    $c->stash->{keywords} = [$c->model('SAMUL::Hgnc')->search(
		{
			name=>{-like=>"%$keyword%"},
		},
	)];
    $c->stash->{template} = 'Search/by_keywords.tt2';

}


=head2 smiles  (/search/smiles/xxx)
	Search a smiles string using pdb webservice 
	xxx might contain '/' (e.g. Cc1c2/cc/3\nc(/cc\4/c(c(/c(/[nH]4)c/c5n/c(c\c(c1CCC(=O)O)[nH]2)/C(=C5C)CCC(=O)O)C=C)C)C(=C3C)C=C)
	source from: http://www.pdb.org/pdb/rest/smilesQuery?smiles=CN(C)c1cccc2c1cccc2S(=O)(=O)O&dissimilarity=0.3&search_type=3
=cut
sub smiles :Local {
    my ($self, $c, @string) = @_;

	my $smiles=join('/', @string) if @string;

	#[todo] SMILES QC
	# localhost/search/smiles/xx
	if($smiles){
		$c->stash->{smiles}=$smiles;
	# localhost/search/smiles?id=xx (from a Boxy modal)
	}else{
		$c->stash->{smiles}=$c->request->params->{id} or $c->detach('/messenger/err_msg', ["Please type SMILES string"]); 
	}
	$c->detach('/messenger/err_msg', ["Please type SMILES string"]) unless $c->stash->{smiles}; 

	#consuming pdb rest api from Samul::WSC::PDB via Samul::Model::PDBWS
	$c->stash->{results}=$c->model('PDBWS')->search_smiles($c->stash->{smiles});
	my @dummy=@{$c->stash->{results}};
	$c->stash->{total}=$#dummy+ 1;

	$c->detach('/messenger/err_msg', ["Sorry, we cannot find any results with your SMILES string"]) if $c->stash->{total}<1; 

	# alwasy set $c->stash-{total} before forwarding
	# set paging values (page, limit, pager)
	$c->forward('/pager/set_page',[5]);

	my $from= ($c->stash->{page} - 1 )*($c->stash->{limit});
	my $to;
	if($from+$c->stash->{limit} > $c->stash->{total}){
		$to= $c->stash->{total} - 1;
	}else{
		$to= $from+ ($c->stash->{limit} - 1);
	}

	$c->stash->{from}=$from;
	$c->stash->{to}=$to;

    $c->stash->{template} = 'Search/smiles.tt2';
}

=head2 gene 
	/search/gene?id=xx (from a Boxy modal)
	/search/gene/xx (direct input from the URL)
	/search/by_ids?id_type='gene'&id='xx' (redirected from a form field)
=cut
sub gene :Local{
    my ($self, $c, $gene) = @_;

	# from the URL (/gene/xx)
	my $id;
	if($gene){
		$id=$gene;
	# via a parameter (mainly from a Boxy modal)
	}else{
		# get parameters
		$id= $c->request->params->{id} or $c->detach('/messenger/err_msg', ["Please type a gene name to search:"]); 
		# or get argument if  
		$id=$c->req->args->[0] unless defined $id; # (e..g $c->forward('gene', [qw/gene_name/])
	}

	# should have a gene name by now
	$c->res->redirect($c->uri_for("/search")) unless defined $id;
	$c->res->redirect($c->uri_for("/uniprot/gene/$id"));


}

=head2 keyword
	/search/keyword/xx (from URL directly)
	/search/keyword?id=xx (from a Boxy modal)
	/search/by_ids?id_type='by_keywords'&id=xx (from a form field)
=cut
sub keyword :Local{
    my ($self, $c, $keyword) = @_;
	# get parameters

	my $id;
	# /search/keyword/xx
	if($keyword){
		$id=$keyword;
		$c->stash->{keyword} = $keyword; 
		$c->stash->{total}= $c->request->params->{total} if $c->request->params->{total};

		# get total number of entries
		unless($c->stash->{total}){
			$c->stash->{total} = $c->model('UNIPROT::Uniprotseq')->search(
				{
					name=>{-like=>"%$keyword%"},
				},
				{
					column=>[qw/id/],
				},
			)->count();
		}

		# alwasy set $c->stash-{total} before forwarding
		# set paging values (page, limit, pager)
		$c->forward('/pager/set_page', [20]);

		# get data
		$c->stash->{metauniprots} = [$c->model('UNIPROT::Uniprotseq')->search(
			{
				name=>{-like=>"%$keyword%"},
			},
			{
				join=>[qw/Taxanomy/],
				'+select'=>[qw/Taxanomy.sn/],
				'+as'=>[qw/sn/],
				order_by=>[qw/me.id/],
				page=>$c->stash->{page},
				rows=>$c->stash->{limit},
			},
		)];

	# /search/keyword?id=xx (maybe from Boxy modal?)
	}else{
		$id=$c->request->params->{id};
		$c->res->redirect($c->uri_for("/search/keyword/$id")) if $id;
	}

	# should have a id by now
	$c->detach('/messenger/err_msg', ["Please type your key words"]) unless $id;
    $c->stash->{template} = 'Search/by_uniprot_keywords.tt2';
}# end of 'sub keyword'


=head2 pdb 
	/search/pdb?id=xx (mainly from a Boxy input modal)
	/search/pdb/xx (from the URL directly)
=cut
sub pdb :Local {
    my ($self, $c, $pdb) = @_;

	my $id;
	# directly from the URL
	if($pdb){
		$id=$pdb;
	# from a pdbBoxy modal
	}else{
		# get parameters
		$id= $c->request->params->{id} or $c->detach('/messenger/err_msg', ["Please type PDB ID"]); 
		# or get argument if  
		$id=$c->req->args->[0] unless defined $id;
	}

	# should have a id by now
	$c->res->redirect($c->uri_for("/search")) unless defined $id;
    $c->stash->{id} = $id; 
	$c->res->redirect($c->uri_for("/pdb/$id"));
}

=head2 uniprot 
	/search/uniprot?id=xx (mainly from a Boxy input modal)
	/search/uniprot/xx (URL directly)
=cut
sub uniprot:Local {
    my ($self, $c, $uniprot) = @_;

	my $id;
	if($uniprot){
		$id=$uniprot;
	}else{
		# get parameters
		$id= $c->request->params->{id} or $c->detach('/messenger/err_msg', ["Please type UniProt ID"]); 
		# or get argument if  
		$id=$c->req->args->[0] unless defined $id;
	}

	$c->res->redirect($c->uri_for("/search")) unless defined $id;
    $c->stash->{id} = $id; 
	$c->res->redirect($c->uri_for("/uniprot/$id"));
}

=head2 uniprot 
	/search/snp?id=xx (mainly from a Boxy input modal)
	/search/snp/xx (from the URL directly)
=cut
sub snp :Local {
    my ($self, $c, $snp) = @_;

	my $id;
	if($snp){
		$id=$snp;
	}else{
		# get parameters
		$id= $c->request->params->{id} or $c->detach('/messenger/err_msg', ["Please type dbSNP ID:"]); 
		# or get argument if  
		$id=$c->req->args->[0] unless defined $id;
	}

	$c->res->redirect($c->uri_for("/search")) unless defined $id;
    $c->stash->{id} = $id; 
	$c->res->redirect($c->uri_for("/snp/$id"));
}

=head2 by_ids
	Integrated search form (two parameters: 'id_type' and 'id')
	action from a form (/search/by_ids?id=xx&id_type=yy')
	Search 'id' from various table depending on in_type (/search/pdb, search/uniprot, search/snp, search/gene and search/by_keywords)
	forward to (/search/pdb/xx, /search/uniprot/xx, /search/snp/xx, /search/gene/xx, /search/keyword/xx)
=cut
sub by_ids :Local {
    my ($self, $c) = @_;

	# get parameters
	my $id= $c->req->params->{id};
	# or get argument if  
	$id=$c->req->args->[0] unless defined $id;

	$c->res->redirect($c->uri_for("/search")) unless defined $id;

	my $id_type= $c->req->params->{id_type};

    $c->stash->{id} = $id; 
    $c->stash->{id_type} = $id_type; 

	$c->res->redirect($c->uri_for("/search/$id_type/$id"));
}

=head2
	called from /pdb/xx, /uniprot/xx, /snp/xx
	check whether a ID is valid wthin a given database 
	if not print a error messenger
=cut
sub sanitizer: Private{
    my ($self, $c) = @_;

    my $type= $c->req->args->[0];
    my $id=$c->stash->{id};
    my $chain=$c->stash->{chain} if $type eq 'pdbc';

	$c->res->redirect($c->uri_for("/search")) unless defined $id;
	my $db={
		pdbc=>{
			name=>'GLORIA::Pdb2uniprot',
			get_this=>'uniprot',
			get_this1=>'pdb',
			get_this2=>'pdb_chain_id',
		},
		pdb=>{
			name=>'SAMUL::Metapdb',
			get_this=>'pdb',
		},
		uniprot=>{
			name=>'UNIPROT::Uniprotseq',
			get_this=>'acc',
		},
		snp=>{
			name=>'SAMUL::Snp2ensg',
			get_this=>'rs_id',
		},
		keyword=>{
			name=>'UNIPROT::Uniprotseq',
			get_this=>'name',
		},
	};

	my $get_this=$db->{$type}{get_this};
	my $ref;
	if($type eq 'pdbc'){
		# for pdbc called by /pdb/xx/yy/resmap
		$ref = [$c->model($db->{$type}{name})->search(
			{
				$db->{$type}{get_this1}=>$c->stash->{id},
				$db->{$type}{get_this2}=>$c->stash->{chain},
			},
			{
				select=>[$db->{$type}{get_this}],
			}
		)];

	}else{
		$ref = [$c->model($db->{$type}{name})->search(
			{
				$db->{$type}{get_this}=>$c->stash->{id}
			},
			{
					select=>[$get_this],
			}
		)];
	}

	unless (exists ${$ref}[0]){
		# CASE I. suggest pattern matching if not exists 
		unless($type eq 'pdbc'){
			$c->res->redirect($c->uri_for('/suggest', {id=>$id, id_type=>$type, call=>'search'}));
		}else{
		# CASE II. whether exists or not
			$c->detach('/messenger/err_msg', ["No matched entries for $id:$chain"]) unless exists ${$ref}[0];
		}
	}else{
		$c->stash->{is_id}=${$ref}[0]->$get_this;
	}

}#end of sanitizer which is forwarded by 'pdb' 'uniprot' 'snp'

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
