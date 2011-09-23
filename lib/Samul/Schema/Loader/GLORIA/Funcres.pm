package Samul::Schema::Loader::GLORIA::Funcres;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("FuncRes");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11, is_auto_increment => 1  },
  "type",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 9 },
  "res_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11, is_foreign_key=>1 },
  "ext_id",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "des",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 256,
  },
);
__PACKAGE__->set_primary_key("id");

__PACKAGE__->belongs_to('ResMap', 'Samul::Schema::Loader::GLORIA::Resmap', {'foreign.res_id'=>'self.res_id'});

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:06:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ktey0B4E5l1Wuf0lhkL47A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
