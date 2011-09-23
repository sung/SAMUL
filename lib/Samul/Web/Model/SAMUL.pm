package Samul::Web::Model::SAMUL;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
	# move to config
    #schema_class => 'Samul::Schema::Loader::SAMUL',
    
);

=head1 NAME

Samul::Web::Model::SAMUL - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<Samul::Web>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<Samul::Schema::Loader::SAMUL>

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
