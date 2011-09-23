package Samul::Web::Controller::SNP;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Samul::Web::Controller::SNP - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index
	Number of SNP by chromosome and snp type
	Tabs by coda-slide
=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	$c->forward('meta');
}


=head2 meta
	localhost:/snp 
	Number of SNP by chromosome and snp type
	Google Visualization API
=cut
sub meta :Args(0) {
    my ( $self, $c ) = @_;

	# get distinct chromosome region (1, 2, 3, ... X, Y, MT)
	$c->stash->{chromosomes} = [$c->model('SAMUL::Metasnp')->search(
		{
			source=>'chromosome',
			version=>'GRCh37',
			des=>{'-not like'=>'HSCH%'},
		}
	)];

	# get number of SNP by chromosome and snp types
	$c->stash->{snp2chr} = [$c->model('SAMUL::Metasnp')->search(
		{
			source=>'chromosome',
			version=>{'!=', 'GRCh37'},
		},
	)];
	# get number of SNP by snp types from all (MetaSNP.source='SNP2ENSG')
	$c->stash->{snpall} = [$c->model('SAMUL::Metasnp')->search(
		{
			source=>'SNP2ENSG',
		},
	)];

	#
	$c->stash->{template}='SNP/metasnp.tt2';
}

=head2 /snp/list?page=xx,limit=yy
	mainly forwared from 'sub type' (localhost/snp/type/xx)
	list all the SNPs from SNP2ENSG
=cut
sub list :Local :Args(0){
    my ( $self, $c ) = @_;

	$c->stash->{total}= $c->request->params->{total} if $c->request->params->{total};
 	my $type= $c->stash->{cond};

	# get total number of entries
	my %cond; #constraints depending on $type

	if($type eq 'all'){
		%cond=();
	}else{
		$cond{$c->stash->{cond}}=$c->stash->{list_this};
	}

	# get total number of entries
	unless($c->stash->{total}){
    	$c->stash->{total}=$c->model("SAMUL::Snp2ensg")->search(
			\%cond,
			{
				column=>[qw/id/],
			},
		)->count();
	}

	# alwasy set $c->stash-{total} before forwarding
	# set paging values (page, limit, pager)
	$c->forward('/pager/set_page',[20]);

	# [todo] implement metasnp (dbsnp + HUMSAVAR + COSMIC)??
	# [todo] get seq_region_id and source_id from ENSEMBLVARIATION 
	# get data
    $c->stash->{metasnps}=[$c->model("SAMUL::Snp2ensg")->search(
		\%cond,
		{
			page=>$c->stash->{page},
			rows=>$c->stash->{limit},
		},
	)];

    $c->stash->{template} = 'SNP/snp_list_all.tt2';
}

=head1 /snp/xxx
	either redirected from /search/by_ids/id=xx&id_type=yy 
	or direct access from the URL:/snp/xx
=cut
sub base: PathPart('snp') Chained('/') Args(1){
    my ($self, $c, $id) = @_;
	$c->stash->{id}=$id unless defined $c->stash->{id};

	# /snp/xx
	if($id){
		# /snp/all
		if($id eq 'all'){
			$c->res->redirect($c->uri_for('/snp/chr/all'));
		# /snp/rs12345
		}else{
			$c->forward('/search/sanitizer', [qw/snp/]);
		}
	# /snp
	}else{
		$c->res->redirect($c->uri_for("/snp"));
	}

	# rs_id is guranteed to be in the table
	if(defined $c->stash->{is_id}){
		# I. SNP2ENSG 
		$c->forward('get_snp2ensg', [$id]);

		# II. SNP2ENST 
		$c->forward('get_snp2enst', [$id]);

		# III. SNP2ENSP
		$c->forward('get_snp2ensp', [$id]);

		# IV. SNP2UNIPROT
		$c->forward('get_snp2uniprot', [$id]);

		# V. SNP2PDB
		$c->forward('get_snp2pdb', [$id]);

		#$c->res->output("Cominig Soon!");
		$c->stash->{template}='SNP/snp.tt2';
	}#end of if is_id

}#end of snp

=head2 /snp/type/xxx (e.g. /snp/type/NON_SYNONYMOUS_CODING)

=cut
sub type: Local: Args(1){
    my ($self, $c, $snp_type) = @_;
	$c->stash->{cond}='type';
	$c->stash->{list_this}=$snp_type;
	$c->forward('list');
}

=head2 to
	/snp/to/xxx (e.g. /snp/to/ensg)
=cut
sub to :Local :Args(1){
    my ($self, $c, $level) = @_;

	#[todo] QC (sanitize) (one of 'ensg' 'enst' 'ensp' 'uniprot' 'pdb')
	$c->stash->{level}=$level;

	# get the number of snp 
	$c->stash->{num} = $c->model('SAMUL::Metasnp')->find(
		{
			source=>'level',
			version=>'snp2'.$c->stash->{level},
		},
	);

	# get snp numbers by the level
	$c->stash->{snptypes} = [$c->model('SAMUL::Metasnp')->search(
		{source=>'snp2'.$c->stash->{level}},
	)];

	$c->stash->{template}='SNP/snp2level.tt2';
}

=head2 base_to
	/snp/to/*/type/* (e.g. /snp/to/ensg/type/NON_SYNONYMOUS_CODING)
=cut
sub base_level :PathPart('snp/to') :Chained('/') :CaptureArgs(1){
    my ($self, $c, $level) = @_;

	#[todo] QC (sanitize) (one of 'ensg' 'enst' 'ensp' 'uniprot' 'pdb')
	$c->stash->{level}=$level;
}

=head2 base_type
	/snp/to/*/type/* (e.g. /snp/to/ensg/type/NON_SYNONYMOUS_CODING)
=cut
sub base_type_after_level :PathPart('type') :Chained('base_level') :Args(1){
    my ($self, $c, $snp_type) = @_;

	my $table='Snp2'.$c->stash->{level};
	$c->stash->{snp_type}=$snp_type;

	$c->stash->{total}= $c->request->params->{total} if $c->request->params->{total};
	$c->stash->{total}=$c->model("SAMUL::Metasnp")->find({source=>$table,des=>$snp_type})->total unless $c->stash->{total};

	# alwasy set $c->stash-{total} before forwarding
	# set paging values (page, limit, pager)
	$c->forward('/pager/set_page',[20]);

	# get data except 
	if($c->stash->{level} eq 'pdb'){
		# set $c->stash->{snp2pdbs}
		$c->forward('get_snp2pdb', [$c->stash->{snp_type}]);
	}else{
	    $c->stash->{metasnps}=[$c->model("SAMUL::$table")->search(
			{type=>$c->stash->{snp_type}},
			{
				page=>$c->stash->{page},
				rows=>$c->stash->{limit},
			},
		)];
	}

	$c->stash->{template}='SNP/snp_level_type.tt2';
}

=head2 chr 
	/snp/chr/xxx (e.g. /snp/chr/7)
=cut
sub chr :Local :Args(1){
    my ($self, $c, $coord) = @_;

	#[todo] QC (sanitize)
	$c->stash->{coord}=$coord;

	my %cond=();
	if($coord eq 'all'){
		$cond{source}='SNP2ENSG';
	}else{
		$cond{source}='chromosome';
		$cond{version}=$coord;
	}

	# get distinct chromosome region (1, 2, 3, ... X, Y, MT)
	$c->stash->{snptypes} = [$c->model('SAMUL::Metasnp')->search(
		\%cond,
	)];

	# get distinct number of SNP for a given chromosome
	$c->stash->{num} = $c->model('SAMUL::Metasnp')->find(
		{
			source=>'chromosome',
			version=>'GRCh37',
			des=>$coord,
		},
	);

	$c->stash->{template}='SNP/snp2chr.tt2';
}

=head2 base_chr
	first part from '/snp/chr/*/type/*'
=cut
sub base_chr: PathPart('snp/chr'): Chained('/') CaptureArgs(1){
	my ($self, $c, $coord) = @_;

	#[todo] QC for the coordinate
	$c->stash->{coord}=$coord;
}

=head2 base_type
	second part from '/snp/chr/*/type/*'
=cut
sub base_type_after_chr :PathPart('type') :Chained('base_chr') :Args(1) {
	my ($self, $c, $snp_type) = @_;

	#[todo] QC for snp_type
	$c->stash->{snp_type}=$snp_type;

	$c->stash->{total}= $c->request->params->{total} if $c->request->params->{total};

	my %cond;
	if($c->stash->{coord} eq 'all'){
		$cond{type}=$c->stash->{snp_type};
	}else{
		$cond{coord_name}=$c->stash->{coord};
		$cond{type}=$c->stash->{snp_type};
	}

	# get total number of entries
	unless($c->stash->{total}){
		$c->stash->{total}=$c->model("SAMUL::Metasnp")->find(
			{
				source=>'chromosome',
				version=>$c->stash->{coord},
				des=>$c->stash->{snp_type}
			}
		)->total;
	}

=total
	unless($c->stash->{total}){
    	$c->stash->{total}=$c->model("SAMUL::Snp2ensg")->search(
			\%cond,
			{
				column=>[qw/id/],
			},
		)->count();
	}
=cut

	# alwasy set $c->stash-{total} before forwarding
	# set paging values (page, limit, pager)
	$c->forward('/pager/set_page',[20]);

	# [todo] implement metasnp (dbsnp + HUMSAVAR + COSMIC)??
	# [todo] get seq_region_id and source_id from ENSEMBLVARIATION 
	# get data
    $c->stash->{metasnps}=[$c->model("SAMUL::Snp2ensg")->search(
		\%cond,
		{
			page=>$c->stash->{page},
			rows=>$c->stash->{limit},
		},
	)];

    $c->stash->{template} = 'SNP/snp_chr_type.tt2';
}


=head2
=cut
sub get_snp2ensg: Private{
    my ($self, $c) = @_;
	   	$c->stash->{snp2ensgs} = [$c->model('SAMUL::Snp2ensg')->search(
    	   	{
       			rs_id=>$c->req->args->[0],
	        },
   		)];
}

sub get_snp2enst: Private{
    my ($self, $c) = @_;
		# II. SNP2ENST 
		# select * from SNP2ENST where rs_id=?
	   	$c->stash->{snp2ensts} = [$c->model('SAMUL::Snp2enst')->search(
    	   	{
       			rs_id=>$c->req->args->[0],
	        },
   		)];
}

sub get_snp2ensp: Private{
    my ($self, $c) = @_;
		# III. SNP2ENSP
		# select * from SNP2ENSP where rs_id=?
	   	$c->stash->{snp2ensps} = [$c->model('SAMUL::Snp2ensp')->search(
    	   	{
       			rs_id=>$c->req->args->[0],
	        },
   		)];
}

sub get_snp2uniprot: Private{
    my ($self, $c) = @_;
		# IV. SNP2UNIPROT
		# select * from SNP2UNIPROT where rs_id=?
		# [todo] get UniProt annotations from UNIPROT.feature
	   	$c->stash->{snp2uniprots} = [$c->model('SAMUL::Snp2uniprot')->search(
    	   	{
       			rs_id=>$c->req->args->[0],
	        },
   		)];
}

sub get_snp2pdb: Private{
    my ($self, $c) = @_;

	my %where;
	$where{type}='ENVAR';

	my %select;
	$select{select}=[qw/me.ext_id me.des ResMap.pdb ResMap.pdb_chain_id/, \"concat_ws(\'\', ResMap.pdb_res_num, ResMap.ins_code) as res_num"];
	$select{as}=[qw/ext_id des pdb chain res_num/];
	$select{join}=[qw/ResMap/];

	# called by 'sub base_type_after_level'
	if($c->stash->{level}){
		# where des like '%NON_SYNONYMOUS_CODING';
		$where{des}{-like}='%'.$c->req->args->[0];
		$select{page}=$c->stash->{page};
		$select{rows}=$c->stash->{limit};
	# called by 'sub base'
	}else{
		$where{ext_id}=$c->req->args->[0];
	}

	$c->stash->{snp2pdbs} = [$c->model('GLORIA::Funcres')->search(
		\%where,
		\%select,
	)];
}

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
