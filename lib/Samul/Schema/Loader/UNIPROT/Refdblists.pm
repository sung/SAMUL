package Samul::Schema::Loader::UNIPROT::Refdblists;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("RefDbLists");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 3 },
  "db",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 12 },
);
__PACKAGE__->set_primary_key("id", "db");

__PACKAGE__->has_many('DbRef', 'Samul::Schema::Loader::UNIPROT::Dbref', {'foreign.db_id'=>'self.id'});

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+FX/to5SWMo3uJZqlgRgaw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
