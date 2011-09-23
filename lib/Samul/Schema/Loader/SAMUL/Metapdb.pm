package Samul::Schema::Loader::SAMUL::Metapdb;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("MetaPDB");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "pdb",
  { data_type => "VARCHAR", default_value => undef, is_nullable => 0, size => 4 },
  "header",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "release",
  { data_type => "DATE", default_value => undef, is_nullable => 1, size => 10 },
  "title",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "source",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "author",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "resolution",
  { data_type => "FLOAT", default_value => undef, is_nullable => 1, size => 32 },
  "method",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "is_resmap",
  { data_type => "INT", default_value => 0, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("pdb", ["pdb"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:G/7dYWQjCOMHvmDR4dfx3A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
