package Samul::Web::Controller::UNIPROT;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Samul::Web::Controller::UNIPROT - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

  #$c->response->body('Matched Samul::Web::Controller::UNIPROT in UNIPROT.');
 	$c->stash->{type}='All';
	$c->forward('list');
}

=head2 /uniprot?page=xx,limit=yy
	list all
=cut
sub list :Args(0){
	my ( $self, $c ) = @_;

	my $type= $c->stash->{type};
	$c->stash->{total}= $c->request->params->{total} if $c->request->params->{total};

	my %cond; #constraints depending on $type
	if($type eq 'All'){
		%cond=();
	}elsif($type eq 'tax_id'){
		$cond{'me.tax_id'}=$c->stash->{list_this};
	}elsif($type eq 'gene'){
		$cond{'me.gene'}=$c->stash->{list_this};
	}

	# get total number of entries
	unless($c->stash->{total}){
		$c->stash->{total}=$c->model("UNIPROT::Uniprotseq")->search(
			\%cond,
			{
				column=>[qw/id/],
			},
		)->count();
	}#end of unless total

	# alwasy set $c->stash-{total} before forwarding
	# set paging values (page, limit, pager)
	$c->forward('/pager/set_page', [20]);

	# get data
  $c->stash->{metauniprots}=[$c->model("UNIPROT::Uniprotseq")->search(
		\%cond,
		{
			join=>[qw/Taxanomy/],
			'+select'=>[qw/Taxanomy.sn/],
			'+as'=>[qw/sn/],
			order_by=>[qw/me.id/],
			page=>$c->stash->{page},
			rows=>$c->stash->{limit},
		},
	)];

    $c->stash->{template} = 'UNIPROT/list.tt2';
}

=head1 /uniprot/xxx
	either redirected from /search/by_ids/id=xx&id_type=yy 
	or direct access from the URL:/uniprot/xx
=cut
sub base: PathPart('uniprot') Chained('/') Args(1){
    my ($self, $c, $id) = @_;
	uc$id if $id;

	# in case of calling from 'by_ids' which res->redirect 
	$c->stash->{id}=$id unless defined $c->stash->{id};

	# sanitize for a given id
	$c->forward('/search/sanitizer', [qw/uniprot/]);

	my @tabs;
	# I. sequence
	$c->forward('get_seq', [$id]);

	# II. xref (dbref )
	$c->forward('get_xref', [$id]);

	# III. SwissVariants
	$c->stash->{num_spvar}=0;
	$c->stash->{num_dbsnp}=0;
	$c->forward('get_variants', [$id]);
	$c->forward('get_snps', [$id]);
	$c->stash->{num_variants}= $c->stash->{num_spvar} + $c->stash->{num_dbsnp};

	# IV. Feature
	# Will get image from Gbrowse
	
	$c->stash->{template}='UNIPROT/uniprot.tt2';
}#end of base 


=head2 /uniprot/species
	[todo]
=cut
sub species_list: {
    my ($self, $c) = @_;

}

=head2 /uniprot/species/xxx
=cut
sub species: Local: Args(1){
    my ($self, $c, $tax_id) = @_;
	$c->stash->{type}='tax_id';
	$c->stash->{list_this}=$tax_id;
	$c->forward('list');

}

=head2 /uniprot/gene
	[todo]
=cut
sub gene_list: {
  my ($self, $c) = @_;
}


=head2 /uniprot/gene/xxx
=cut
sub gene: Local: Args(1){
    my ($self, $c, $gene) = @_;

	$c->stash->{type}='gene';
	$c->stash->{list_this}=$gene;
	$c->forward('list');
}

sub get_seq: Private{
    my ($self, $c) = @_;

	$c->stash->{uniprots}=[$c->model('UNIPROT::Uniprotseq')->search(
		{
			'me.acc'=>$c->req->args->[0],
		},
		{
			join=>[qw/Taxanomy/],
			'+select'=>[qw/Taxanomy.sn/],
			'+as'=>[qw/sn/],
		},
	)];
}

sub get_xref: Private{
    my ($self, $c) = @_;
    my $ref_ids= $c->req->args; #arryref

=rel_uniprot1
		my $rs=$c->model('UNIPROT');	# ResultSource ?
		my $schema=$rs->schema;
		$schema->class('Dbref')->belongs_to('RefDbLists', $schema->class('Refdblists'), {'foreign.id'=>'self.db_id'});
=cut
	foreach my $id(@{$ref_ids}){
	    $c->stash->{xrefs}=[$c->model('UNIPROT::Dbref')->search(
   		    {
       			'me.acc'=>$id,
	        },
			{
				select=>[qw/RefDbLists.db/, \'group_concat(me.ref separator \', \') as entries'],
				as=>[qw/db entries/],
				join=>[qw/RefDbLists/],
				group_by=>[qw/RefDbLists.db/],
			}
	    )];
	}
}

sub get_variants: Private {
	my ($self, $c) = @_;
	$c->stash->{variants}=[$c->model('UNIPROT::Swissvariants')->search(
		{
			'me.sp_acc'=>$c->req->args->[0],
		},
	)];

	$c->stash->{num_spvar}=$c->model('UNIPROT::Swissvariants')->search(
		{
			'me.sp_acc'=>$c->req->args->[0],
		},
	)->count;
}

sub get_snps: Private {
	my ($self, $c) = @_;
	$c->stash->{snps}=[$c->model('SAMUL::Snp2uniprot')->search(
		{
			'me.uniprot'=>$c->req->args->[0],
		},
	)];
	$c->stash->{num_dbsnp}=$c->model('SAMUL::Snp2uniprot')->search(
		{
			'me.uniprot'=>$c->req->args->[0],
		},
	)->count;
}

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
