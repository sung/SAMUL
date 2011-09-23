package Samul::Schema::Loader::SAMUL::Metasnp;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("MetaSNP");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 5 },
  "source",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "version",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "des",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "cnt",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "total",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RLWxdxPfD08V0vDBGyEezA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
