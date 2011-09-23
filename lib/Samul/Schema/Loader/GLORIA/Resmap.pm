package Samul::Schema::Loader::GLORIA::Resmap;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("ResMap");
__PACKAGE__->add_columns(
  "res_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10, is_auto_increment => 1  },
  "pdb",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 4 },
  "pdb_chain_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 2 },
  "res_num",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 5 },
  "res_3code",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 3 },
  "res_1code",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 1 },
  "pdb_local_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "pdb_local_rescued_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "pdb_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "ins_code",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
  "uniprot",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 12 },
  "uniprot_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "uniprot_res_code",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 1 },
);
__PACKAGE__->set_primary_key("res_id");
__PACKAGE__->add_unique_constraint(
  "pdb_local_resnum",
  ["pdb", "pdb_chain_id", "pdb_local_res_num"],
);
__PACKAGE__->add_unique_constraint("resnum", ["pdb", "pdb_chain_id", "res_num"]);

__PACKAGE__->has_many('FuncRes', 'Samul::Schema::Loader::GLORIA::Funcres', {'foreign.res_id'=>'self.res_id'});
# 'might_have' to be honest, but here has_many for autocrud to avoid counting entries from joining ResMap with ResAnno
__PACKAGE__->has_many('ResAnno', 'Samul::Schema::Loader::GLORIA::Resanno', {'foreign.res_id'=>'self.res_id'});

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:06:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:d8Gku+tZLzMNW650iUGi5A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
