package Samul::Schema::Loader::UNIPROT::Featurevariant;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("featureVariant");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "ori",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "vari",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/3vxBdxZiv0TyOOV28omiA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
