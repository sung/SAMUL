package Samul::Web::Controller::Annotation;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Samul::Web::Controller::Annotation - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	#$c->response->body('Matched Samul::Web::Controller::Annotation in Annotation.');
	$c->forward('meta');
}

=head2 intro
	statistic table of functional annotations
=cut
sub meta :Args(0){
    my ( $self, $c ) = @_;

	$c->stash->{metaannos} = [$c->model('SAMUL::Metaanno')->search(undef,{order_by=>[qw/source/]})];

	$c->stash->{template}='Anno/meta_anno.tt2'
}

=head2 base_anno
	/annotation/xx
	detailed list for a specified annotation
=cut
sub base_anno :PathPart('annotation') :Chained('/') :Args(1){
    my ( $self, $c, $anno ) = @_;

	#[todo] QC for $anno
	$c->detach('/messenger/err_msg', ["Annotation unspecified"]) unless $anno;
	$c->stash->{type}=$anno;

	# get source
	$c->stash->{source}=$c->model("SAMUL::Metaanno")->find({anno=>$c->stash->{type}})->source;

	# get total number of entries
	$c->stash->{total}= $c->request->params->{total} if $c->request->params->{total};
	$c->stash->{total}=$c->model("SAMUL::Metaanno")->find({anno=>$c->stash->{type}})->total unless $c->stash->{total};

	# always set $c->stash-{total} before forwarding
	# set paging values (page, limit, pager)
	$c->forward('/pager/set_page',[30]);

	# get data
    $c->stash->{annos} = [$c->model("GLORIA::Resmap")->search(
		{
			'FuncRes.type'=>$c->stash->{type},
			'me.pdb_res_num'=> { '!=' => undef },	# is not null
		},
        {
			select=>[qw/FuncRes.des me.pdb me.pdb_chain_id me.res_3code concat_ws('',me.pdb_res_num,me.ins_code) me.uniprot me.uniprot_res_num me.uniprot_res_code/],
			as=>[qw/des pdb pdb_chain_id res_3code res_num uniprot uniprot_res_num uniprot_res_code/],
			join=>[qw/FuncRes/],
			order_by=>[qw/FuncRes.res_id/],
			page=>$c->stash->{page},
			rows=>$c->stash->{limit},
        }
    )];

	$c->stash->{template}='Anno/anno_by_type.tt2';
}


=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
