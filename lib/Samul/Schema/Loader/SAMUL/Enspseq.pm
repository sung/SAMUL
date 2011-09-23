package Samul::Schema::Loader::SAMUL::Enspseq;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("EnspSeq");
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
  "length",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 5 },
  "sequence",
  {
    data_type => "LONGTEXT",
    default_value => undef,
    is_nullable => 1,
    size => 4294967295,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uOVbhI/ClXWu/Dr4uRIP5A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
