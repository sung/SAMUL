package Samul::Schema::Loader::UNIPROT::Feature;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("feature");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "acc",
  { data_type => "CHAR", default_value => "", is_nullable => 0, size => 12 },
  "start",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "end",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "featurevariant",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "featureclass",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "featuretype",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "featureid",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LHSLKGqZUGVILQrVzdG7ig


# You can replace this text with custom content, and it will be preserved on regeneration
1;
