-- this sql script updates 'ResAnno' by setting res_id from ResMap
UPDATE GLORIA.ResAnno r
JOIN GLORIA.ResMap m
on r.pdb=m.pdb
and r.pdb_chain_id=m.pdb_chain_id
and r.pdb_local_rescued_res_num=m.pdb_local_rescued_res_num
set r.res_id=m.res_id;

-- create index here
ALTER TABLE GLORIA.ResAnno ADD INDEX (res_id);

