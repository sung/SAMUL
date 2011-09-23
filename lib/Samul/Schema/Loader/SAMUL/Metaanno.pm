package Samul::Schema::Loader::SAMUL::Metaanno;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("MetaAnno");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 5 },
  "source",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 7 },
  "anno",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 20,
  },
  "version",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 20,
  },
  "url",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "des",
  {
    data_type => "TINYTEXT",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "res_cnt_pdb",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "res_cnt_uniprot",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "id_cnt_pdb",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "id_cnt_uniprot",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "total",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("anno", ["anno"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-03-12 11:49:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yNr17onKUb1s5Pxx1cLNAg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
