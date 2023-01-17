SELECT id, count(row) contagem FROM temporarios.gridbr g 
LEFT JOIN dados_brutos.valid_sicar_imovel so ON ST_Intersects(g.geom, so.valid_geom)
WHERE (g.id % :var_num_proc) = :var_proc GROUP BY id