

-- Massas dagua
\echo Massas dagua
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_massas_dagua
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_input_massas_dagua a
JOIN dados_brutos.valid_input_massas_dagua b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;



-- SICAR
\echo SICAR
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_sicar_imovel
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_sicar_imovel a
JOIN dados_brutos.valid_sicar_imovel b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;

