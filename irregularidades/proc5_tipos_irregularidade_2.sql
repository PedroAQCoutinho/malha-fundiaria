
\echo TIPOS OII
INSERT INTO irregularidades.proc5_step14_tipo_oii
SELECT a.gid, area area_imovel, tipo_imove , uf, cod_munici::int , cd_bioma, flag, nm_cat_fund , nm_agrup,  is_recente , is_ocupa_irregular , is_grande ,  
CASE 
	WHEN tipo_imove = 'IRU' AND is_recente AND NOT is_grande AND NOT is_ocupa_irregular THEN 'A'
	WHEN tipo_imove = 'IRU' AND NOT is_recente AND NOT is_grande AND is_ocupa_irregular THEN 'B'
	WHEN tipo_imove = 'IRU' AND is_recente AND NOT is_grande AND is_ocupa_irregular THEN 'C'
	WHEN tipo_imove = 'IRU' AND NOT is_recente AND is_grande AND NOT is_ocupa_irregular THEN 'D'
	WHEN tipo_imove = 'IRU' AND NOT is_recente AND is_grande AND is_ocupa_irregular THEN 'E'
	WHEN tipo_imove = 'IRU' AND is_recente AND is_grande AND NOT is_ocupa_irregular THEN 'F'
	WHEN tipo_imove = 'IRU' AND is_recente AND is_grande AND is_ocupa_irregular THEN 'G'
	ELSE 'OSII'
END tipo, ST_Intersection(ST_Force2D(ST_CollectionExtract(a.geom,3)), b.geom) geom
FROM irregularidades.proc4_step14_car_join a LEFT JOIN geo_adm.pa_br_amazonia_legal_ibge_250_4674 b 
ON ST_Intersects(ST_Force2D(ST_CollectionExtract(a.geom,3)), b.geom)
WHERE (a.gid % :var_num_proc) = :var_proc AND b.gid IS NOT NULL;
