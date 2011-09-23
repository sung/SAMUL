package Samul::Schema::Loader::SAMUL::Snp2pdb;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("SNP2PDB");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "rs_id",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "res_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "allele",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "type",
  { data_type => "SET", default_value => undef, is_nullable => 0, size => 239 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ELKVmMtp+yUIgDetlkPrPA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
