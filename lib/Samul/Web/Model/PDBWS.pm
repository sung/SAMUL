package Samul::Web::Model::PDBWS;

use strict;
use base 'Catalyst::Model::Adaptor';

# Optionally set a base or any other WebService::CRUST options
# e.g. http://developer.yahooapis.com/TimeService/V1/getTime?appid=YahooDemo
# http://www.rcsb.org/pdb/rest/describeMol?structureId=4hhb
# Access the descriptions of the entities that are contained in a PDB file.
__PACKAGE__->config(
	class=>'Samul::WSC::PDB',
	args=>{},
);

=head1 NAME

Samul::Web::Model::PDBWS - Catalyst WebService::CRUST Model

=head1 SYNOPSIS

See L<Samul::Web>

=head1 DESCRIPTION

L<Catalyst::Model::PDBWS> Model for making REST queries

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
