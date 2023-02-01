
\echo TIPOS OII
INSERT INTO irregularidades.step14_tipo_oii (gid, flag, original_layer_label , cat_agrupada , area, tipo_imove , is_data_irregular , is_ocupa_irregular , is_area_irregular, tipo, geom)
SELECT a.gid, flag, original_layer_label , cat_agrupada , area, tipo_imove , is_data_irregular , is_ocupa_irregular , is_area_irregular ,  
CASE 
	WHEN tipo_imove = 'IRU' AND is_data_irregular AND NOT is_area_irregular AND NOT is_ocupa_irregular THEN 'A'
	WHEN tipo_imove = 'IRU' AND NOT is_data_irregular AND NOT is_area_irregular AND is_ocupa_irregular THEN 'B'
	WHEN tipo_imove = 'IRU' AND is_data_irregular AND NOT is_area_irregular AND is_ocupa_irregular THEN 'C'
	WHEN tipo_imove = 'IRU' AND NOT is_data_irregular AND is_area_irregular AND NOT is_ocupa_irregular THEN 'D'
	WHEN tipo_imove = 'IRU' AND NOT is_data_irregular AND is_area_irregular AND is_ocupa_irregular THEN 'E'
	WHEN tipo_imove = 'IRU' AND is_data_irregular AND is_area_irregular AND NOT is_ocupa_irregular THEN 'F'
	WHEN tipo_imove = 'IRU' AND is_data_irregular AND is_area_irregular AND is_ocupa_irregular THEN 'G'
	ELSE 'OSII'
END tipo, ST_Intersection(ST_Force2D(ST_CollectionExtract(a.geom,3)), b.geom) geom
FROM irregularidades.step14_car_join a LEFT JOIN geo_adm.pa_br_amazonia_legal_ibge_250_4674 b 
ON ST_Intersects(ST_Force2D(ST_CollectionExtract(a.geom,3)), b.geom)
WHERE (a.gid % :var_num_proc) = :var_proc AND b.gid IS NOT NULL;



