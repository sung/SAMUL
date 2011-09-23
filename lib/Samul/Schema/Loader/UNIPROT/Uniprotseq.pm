package Samul::Schema::Loader::UNIPROT::Uniprotseq;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("UniProtSeq");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "acc",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 12 },
  "display_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 12 },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 500,
  },
  "gene",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 20 },
  "length",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 5 },
  "mw",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 10 },
  "sequence",
  {
    data_type => "LONGTEXT",
    default_value => undef,
    is_nullable => 1,
    size => 4294967295,
  },
  "is_sp",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 1 },
  "tax_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11, is_foreign_key=>1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("display_id", ["display_id"]);
__PACKAGE__->add_unique_constraint("acc", ["acc"]);

__PACKAGE__->belongs_to('Taxanomy', 'Samul::Schema::Loader::UNIPROT::Taxanomy', {'foreign.id'=>'self.tax_id'});

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JGVwy4TnxHdVf3T4ucJMxA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
