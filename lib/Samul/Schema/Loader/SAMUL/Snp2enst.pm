package Samul::Schema::Loader::SAMUL::Snp2enst;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("SNP2ENST");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "rs_id",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 100 },
  "enst",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "strand",
  { data_type => "TINYINT", default_value => undef, is_nullable => 1, size => 4 },
  "start",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "end",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "allele",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 200,
  },
  "type",
  { data_type => "SET", default_value => undef, is_nullable => 0, size => 239 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:T/xTHGrjHHNVv2rU2fgV4A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
