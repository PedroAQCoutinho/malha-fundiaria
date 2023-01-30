

	-- Massas dagua
\echo Massas dagua
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.inputs_massas_dagua (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	20 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_input_massas_dagua a
LEFT JOIN 
	autointersection.autointersection_input_massas_dagua b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	20 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_massas_dagua d
WHERE 
	(d.gid % :var_num_proc) = :var_proc;



/*
	-- Fronteira
\echo Faixa fronteira
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.inputs_faixa_fronteira (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	19 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_input_faixa_fronteira a
LEFT JOIN 
	autointersection.autointersection_input_faixa_fronteira b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	19 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_faixa_fronteira d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;





	-- SICAR
\echo SICAR
\echo  
\echo 

-- Popular a tabela maior

INSERT INTO inputs.inputs_sicar_imovel (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	18 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_sicar_imovel a
LEFT JOIN 
	autointersection.autointersection_input_sicar_imovel b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	18 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_sicar_imovel d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;
	

*/