package Samul::Schema::Loader::UNIPROT::Dbref;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("DbRef");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11, is_auto_increment=>1 },
  "acc",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 12 },
  "RefDbLists",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 3, is_foreign_key=>1},
  "ref",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 100 },
);
__PACKAGE__->set_primary_key("id");

__PACKAGE__->belongs_to('RefDbLists', 'Samul::Schema::Loader::UNIPROT::Refdblists', {'foreign.id'=>'self.RefDbLists'});

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tT7uImloViKl2zt49UNr4A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
