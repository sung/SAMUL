package Samul::Schema::Loader::GLORIA::Pdb2uniprot;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("PDB2UniProt");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "pdb",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 4 },
  "pdb_chain_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 1 },
  "uniprot",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 6 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:06:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oiGYc772zb1Y702cr7wZzA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
