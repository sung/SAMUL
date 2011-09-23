package Samul::Schema::Loader::SAMUL::Source;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("source");
__PACKAGE__->add_columns(
  "source_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "version",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("source_id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XN5XgzGqh88yfResvzu/FA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
