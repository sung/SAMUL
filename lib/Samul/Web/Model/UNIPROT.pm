package Samul::Web::Model::UNIPROT;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
	# moved to config
    #schema_class => 'Samul::Schema::Loader::UNIPROT',
    
);

=head1 NAME

Samul::Web::Model::UNIPROT - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<Samul::Web>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<Samul::Schema::Loader::UNIPROT>

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
