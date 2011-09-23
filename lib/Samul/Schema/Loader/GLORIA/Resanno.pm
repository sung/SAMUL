package Samul::Schema::Loader::GLORIA::Resanno;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("ResAnno");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11, is_auto_increment => 1  },
  "res_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11, is_foreign_key=>1 },
  "pdb",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 4 },
  "pdb_chain_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 2 },
  "pdb_local_rescued_res_num",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 5 },
  "res_1code",
  { data_type => "CHAR", default_value => "", is_nullable => 0, size => 1 },
  "ss_phi",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "solv_acc",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "hbond_co",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "hbond_nh",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "hbond_sc",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "cispep",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "hbond_het",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "covbond_het",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "disulph",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "mcmc_amide",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "mcmc_carb",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "dssp",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "pos_phi",
  { data_type => "ENUM", default_value => undef, is_nullable => 0, size => 1 },
  "pc_acc",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 1 },
  "ooi",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 1 },
  "env",
  { data_type => "CHAR", default_value => undef, is_nullable => 0, size => 5 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint(
  "pdb",
  ["pdb", "pdb_chain_id", "pdb_local_rescued_res_num", "res_1code"],
);

# join type is 'left outer' as res_id is nullable
__PACKAGE__->might_have('ResMap', 'Samul::Schema::Loader::GLORIA::Resmap', {'foreign.res_id'=>'self.res_id'}, { join_type => 'LEFT OUTER' });

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-12-09 14:06:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TAvdV26EN6CTGpCMxYiBOA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
