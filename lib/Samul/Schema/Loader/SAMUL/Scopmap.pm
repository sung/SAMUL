package Samul::Schema::Loader::SAMUL::Scopmap;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("SCOPMap");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 4 },
  "sid",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 10 },
  "px",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "sccs",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 50,
  },
  "sunid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "pdb",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 4 },
  "chain",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 2 },
  "pdb_res_start",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "ins_code_start",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
  "pdb_res_end",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "ins_code_end",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
  "pdb_local_res_start",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "pdb_local_res_end",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "pdb_local_rescued_res_start",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "pdb_local_rescued_res_end",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8EdIzwLFLL2ZOUeeyHeUFA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
