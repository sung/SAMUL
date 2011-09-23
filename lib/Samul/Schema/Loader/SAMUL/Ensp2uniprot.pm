package Samul::Schema::Loader::SAMUL::Ensp2uniprot;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("Ensp2UniProt");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "ensp",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 50,
  },
  "ensp_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 5 },
  "ensp_res",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 1 },
  "uniprot",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 6 },
  "uniprot_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "uniprot_res",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
  "is_same_seq",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("ensp", ["ensp", "ensp_res_num", "uniprot"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YBIHNgagYeXAlu8zGnwWHw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
