package Samul::Schema::Loader::UNIPROT::Swissvariants;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("SwissVariants");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 15 },
  "variant_id",
  { data_type => "CHAR", default_value => "", is_nullable => 0, size => 10 },
  "gene",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 20,
  },
  "sp_acc",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 12 },
  "uniprot_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "aa_original",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
  "aa_variation",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
  "type",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 12 },
  "disease_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "mim",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 6 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ryQy1LVHmJUP4Duds4Byig


# You can replace this text with custom content, and it will be preserved on regeneration
1;
