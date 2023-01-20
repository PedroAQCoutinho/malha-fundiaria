
-- Terras indigenas
\echo TerrasIndigenas
\echo  
\echo  

-- Popular a tabela maior

INSERT INTO inputs.input_terrasindigenas_funai_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	1 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_geoft_terra_indigena a
LEFT JOIN 
	autointersection.autointersection_input_terrasindigenas_funai_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	1 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_terrasindigenas_funai_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc ;




-- Quilombolas
\echo Quilombolas
\echo  
\echo  


-- Popular a tabela maior
INSERT INTO inputs.input_quilombolas_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	2 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_areas_de_quilombolas a
LEFT JOIN 
	autointersection.autointersection_input_quilombolas_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	2 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_quilombolas_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;






-- Assentamentos federais
\echo Assentamentos federais
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.input_assentamento_federal_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	4 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_assentamento_federal a
LEFT JOIN 
	autointersection.autointersection_input_assentamento_federal_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	4 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_assentamento_federal_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;








-- Assentamentos reconhecimento
\echo Assentamentos reconhecimento
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.input_assentamento_reconhecimento_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	5 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_assentamento_reconhecimento a
LEFT JOIN 
	autointersection.autointersection_input_assentamento_reconhecimento_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	5 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_assentamento_reconhecimento_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;





-- UCUSs
\echo UCs
\echo  
\echo 


-- Popular a tabela maior
INSERT INTO inputs.input_ucus_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	12 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_geoft_unidade_conservacao_ucus a
LEFT JOIN 
	autointersection.autointersection_input_ucus_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	12 cd_layer,
	ST_CollectionExtract(geom, 3) 
FROM 
	autointersection.autointersection_input_ucus_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;

    
-- UCPIs
\echo UCs
\echo  
\echo 


-- Popular a tabela maior
INSERT INTO inputs.input_ucpi_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	13 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_geoft_unidade_conservacao_ucpi a
LEFT JOIN 
	autointersection.autointersection_input_ucpi_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	13 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM 
	autointersection.autointersection_input_ucpi_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;



-- Glebas Publicas est
\echo GlebasPublicas est
\echo  
\echo 

-- Popular a tabela maior 
INSERT INTO inputs.input_glebaspublicas_est_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	14 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_cnfp_2020_br_est a
LEFT JOIN 
	autointersection.autointersection_input_glebaspublicas_est_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	14 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_glebaspublicas_est_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;





-- Glebas Publicas fed
\echo GlebasPublicas fed
\echo  
\echo 

-- Popular a tabela maior 
INSERT INTO inputs.input_glebaspublicas_fed_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	15 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_cnfp_2020_br_fed a
LEFT JOIN 
	autointersection.autointersection_input_glebaspublicas_fed_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	15 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_glebaspublicas_fed_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;




-- Sigef publico
\echo SIGEFpublico
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.input_sigefpublico_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	7 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_sigef_publico a
LEFT JOIN 
	autointersection.autointersection_input_sigefpublico_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	7 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_sigefpublico_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;




	-- snci publico
\echo sncipublico
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.input_sncipublico_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	8 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_imovel_certificado_snci_publico a
LEFT JOIN 
	autointersection.autointersection_input_sncipublico_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	8 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_sncipublico_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;




-- Sigef privado
\echo SIGEFprivado
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.input_sigefprivado_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	9 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_sigef_privado a
LEFT JOIN 
	autointersection.autointersection_input_sigefprivado_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	9 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_sigefprivado_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;




	-- snci privado
\echo snciprivado
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.input_snciprivado_2022 (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	10 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_imovel_certificado_snci_privado a
LEFT JOIN 
	autointersection.autointersection_input_snciprivado_2022 b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	10 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_snciprivado_2022 d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;






	-- terra legal
\echo terra legal
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.input_terralegal_privado (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	16 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_terralegal_privado a
LEFT JOIN 
	autointersection.autointersection_input_terralegal_privado b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	16 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_terralegal_privado d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;




	-- interesse da uniao
\echo interesse da uniao
\echo  
\echo 

-- Popular a tabela maior
INSERT INTO inputs.inputs_interesse_uniao (original_gid, cd_layer, geom)
SELECT 
	ARRAY[a.gid] original_gid,
	17 cd_layer,
	CASE 
		WHEN ST_Collect(b.geom) IS NULL THEN ST_CollectionExtract(a.valid_geom, 3)
		ELSE ST_CollectionExtract(ST_Difference(a.valid_geom, ST_Union(b.geom)), 3)
	END geom
FROM
	dados_brutos.valid_areas_interesse_uniao a
LEFT JOIN 
	autointersection.autointersection_input_areas_interesse_uniao b
ON 
	ST_Intersects(a.valid_geom, b.geom)
WHERE 
    (a.gid % :var_num_proc) = :var_proc 
GROUP BY 
	a.gid, a.valid_geom
UNION ALL 
SELECT 
	ARRAY[agid,bgid] original_gid,
	17 cd_layer,
	ST_CollectionExtract(geom, 3)  
FROM
	autointersection.autointersection_input_areas_interesse_uniao d
WHERE 
	(d.gid % :var_num_proc) = :var_proc  ;






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
	(d.gid % :var_num_proc) = :var_proc  ;

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