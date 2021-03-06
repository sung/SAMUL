package Samul::Schema::Loader::UNIPROT::Idalias;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("IdAlias");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "display_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 12 },
  "alias",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 12 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("display_id", ["display_id", "alias"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ekSv81L7ARMnxkKfQRO/SQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
