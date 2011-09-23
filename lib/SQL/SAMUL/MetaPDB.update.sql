UPDATE MetaPDB m  
JOIN GLORIA.PDB2UniProt p 
on m.pdb=p.pdb
set m.is_resmap=1;
