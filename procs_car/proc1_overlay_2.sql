\echo adm1overlay

INSERT INTO temporario.adm1_overlay (cd_grid, cd_mun , geom)
SELECT
	id::int cd_grid,
	cd_mun::int,
	CASE 
		WHEN b.geom IS NULL OR a.geom IS NULL THEN NULL
		ELSE ST_CollectionExtract(ST_Intersection(a.geom,  b.geom), 3) 
	END geom
FROM 
	temporario.gridbr_filtrado  a 
LEFT JOIN 
	geo_adm.pa_br_limitemunicipal_250_2015_ibge_4674  b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	((a.id % :var_num_proc) = :var_proc) ;


