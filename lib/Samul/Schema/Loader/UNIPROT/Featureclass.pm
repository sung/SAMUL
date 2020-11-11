package Samul::Schema::Loader::UNIPROT::Featureclass;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("featureClass");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "val",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:d62dYtZ65wOE+N2xsRY48A


# You can replace this text with custom content, and it will be preserved on regeneration
1;