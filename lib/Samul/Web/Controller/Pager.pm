package Samul::Web::Controller::Pager;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Samul::Web::Controller::Pager - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Pager');
}

# $c->stash->{total} should be set by caller
sub set_page:Path :Args(0) {
    my ( $self, $c ) = @_;

	# get parameters
    my $page = $c->req->params->{'page'};	# form the URI (&page=xx)
    $page = $c->config->{page} if !defined $page or $page !~ m/^\d+$/;
    $c->stash->{page} = $page;

	my $limit = $c->req->params->{'limit'};	# from the URI (&limit=xx)
    if (!defined $limit or ($limit ne 'all' and $limit !~ m/^\d+$/)){
		if($c->req->args->[0]){
		    $limit = $c->req->args->[0];
		}else{
		    $limit = $c->config->{limit};
		}
	}
    $c->stash->{limit} = $limit;

    my $pager = Data::Page->new;
    $pager->total_entries($c->stash->{total});
    $pager->entries_per_page($c->stash->{limit} eq 'all' ? $c->stash->{total} : $c->stash->{limit});
    $pager->current_page($c->stash->{page});
    $c->stash->{pager} = $pager;
}

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
