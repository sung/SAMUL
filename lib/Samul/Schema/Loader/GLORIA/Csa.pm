package Samul::Schema::Loader::GLORIA::Csa;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("CSA");
__PACKAGE__->add_columns(
  "csa_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "pdb",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 4 },
  "site_number",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 5 },
  "res_3code",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 3 },
  "pdb_chain_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
  "pdb_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 5 },
  "chem_function",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
  "evidence",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 7 },
  "lit_entry",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 4 },
  "lit_chain",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
);
__PACKAGE__->set_primary_key("csa_id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:06:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:f7CuWN/q7alkDHhPfCI0tw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
