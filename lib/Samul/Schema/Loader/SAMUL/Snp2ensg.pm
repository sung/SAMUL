package Samul::Schema::Loader::SAMUL::Snp2ensg;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("SNP2ENSG");
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
  "ensg",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "coord_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 40,
  },
  "source_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 2 },
  "strand",
  { data_type => "TINYINT", default_value => undef, is_nullable => 1, size => 4 },
  "start",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "end",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "allele",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "genotyped",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 1 },
  "validation",
  { data_type => "SET", default_value => undef, is_nullable => 1, size => 39 },
  "type",
  {
    data_type => "SET",
    default_value => "INTERGENIC",
    is_nullable => 0,
    size => 265,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/yrkNtgT5X9yhQnQ6Z0t8Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
