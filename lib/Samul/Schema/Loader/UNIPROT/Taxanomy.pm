package Samul::Schema::Loader::UNIPROT::Taxanomy;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("Taxanomy");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "sn",
  {
    data_type => "TINYBLOB",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "cn",
  {
    data_type => "TINYBLOB",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to('UniProtSeq', 'Samul::Schema::Loader::UNIPROT::Uniprotseq', {'foreign.tax_id'=>'self.id'});


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:10:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YTB+KOF6/OBE+zrIhtWiGg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
