-- Terras indigenas
\echo TerrasIndigenas
\echo  
\echo  


INSERT INTO autointersection.autointersection_input_terrasindigenas_funai_2022
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_geoft_terra_indigena a
JOIN dados_brutos.valid_geoft_terra_indigena b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;














-- Quilombolas
\echo Quilombolas
\echo  
\echo  



INSERT INTO autointersection.autointersection_input_quilombolas_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_areas_de_quilombolas a
JOIN dados_brutos.valid_areas_de_quilombolas b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;


-- Assentamentos federais
\echo Assentamentos federais
\echo  
\echo 



INSERT INTO autointersection.autointersection_input_assentamento_federal_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_assentamento_federal a
JOIN dados_brutos.valid_assentamento_federal b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;



-- Assentamentos reconhecimento
\echo Assentamentos reconhecimento
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_assentamento_reconhecimento_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_assentamento_reconhecimento a
JOIN dados_brutos.valid_assentamento_reconhecimento b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;



-- UCUSs
\echo UCs 
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_ucus_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_geoft_unidade_conservacao_ucus a
JOIN dados_brutos.valid_geoft_unidade_conservacao_ucus b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;





-- UCPIs
\echo UCs 
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_ucpi_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_geoft_unidade_conservacao_ucpi a
JOIN dados_brutos.valid_geoft_unidade_conservacao_ucpi b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;







-- Glebas Publicas est
\echo GlebasPublicas est
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_glebaspublicas_est_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_cnfp_2020_br_est a
JOIN dados_brutos.valid_cnfp_2020_br_est b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;





-- Glebas Publicas fed
\echo GlebasPublicas fed
\echo   
\echo 


INSERT INTO autointersection.autointersection_input_glebaspublicas_fed_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_cnfp_2020_br_fed a
JOIN dados_brutos.valid_cnfp_2020_br_fed b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;












-- Sigef publico
\echo Sigefpublico 
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_sigefpublico_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_sigef_publico a
JOIN dados_brutos.valid_sigef_publico b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;

-- SNCI publico
\echo sncipublico 
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_sncipublico_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_imovel_certificado_snci_publico a
JOIN dados_brutos.valid_imovel_certificado_snci_publico b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;



-- Sigef privado
\echo Sigefprivado 
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_sigefprivado_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_sigef_privado a
JOIN dados_brutos.valid_sigef_privado b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;

-- SNCI privado
\echo snciprivado
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_snciprivado_2022 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_imovel_certificado_snci_privado a
JOIN dados_brutos.valid_imovel_certificado_snci_privado b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;




-- terra legal
\echo terra legal
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_terralegal_privado 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_terralegal_privado a
JOIN dados_brutos.valid_terralegal_privado b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;





-- Interesse da uniao
\echo Interesse da uniao
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_areas_interesse_uniao 
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_areas_interesse_uniao a
JOIN dados_brutos.valid_areas_interesse_uniao b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;  ;




-- Massas dagua
\echo Massas dagua
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_massas_dagua
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_input_massas_dagua a
JOIN dados_brutos.valid_input_massas_dagua b 
ON ST_Intersects(a.valid_geom, b.valid_geom) AND a.gid <> b.gid AND a.gid < b.gid WHERE (a.gid % :var_num_proc) = :var_proc;



-- Fronteira
\echo Faixa de fronteira
\echo  
\echo 


INSERT INTO autointersection.autointersection_input_faixa_fronteira
SELECT ROW_NUMBER() OVER () gid, a.gid agid, b.gid bgid, (ST_Dump(ST_CollectionExtract(ST_Intersection(a.valid_geom, b.valid_geom), 3))).geom geom
FROM dados_brutos.valid_input_faixa_fronteira a
JOIN dados_brutos.valid_input_faixa_fronteira b 
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

