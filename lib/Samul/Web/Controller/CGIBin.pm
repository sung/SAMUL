package Samul::Web::Controller::CGIBin;

use strict;
use warnings;
use parent 'Catalyst::Controller::CGIBin';

=head1 NAME

Samul::Web::Controller::CGIBin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Samul::Web::Controller::CGIBin in CGIBin.');
}

# moved to .conf
__PACKAGE__->config(
	cgi_root_path=>'cgi-bin',
	cgi_dir=>'cgi-bin',
	CGI=>{
		pass_env=>[qw/PERL5LIB PATH/],
	},
);
=cut

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
