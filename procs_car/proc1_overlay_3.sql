

\echo adm2overlay


INSERT INTO temporario.adm2_overlay (cd_mun , cd_grid,  am_legal,  geom)
SELECT * FROM (SELECT
	cd_mun::int,
	a.cd_grid::int,
	TRUE am_legal,
	CASE 
		WHEN ST_Within(a.geom, b.geom) THEN ST_CollectionExtract(a.geom, 3)
		WHEN ST_Intersects(a.geom, b.geom) AND NOT ST_Within(a.geom, b.geom) THEN ST_CollectionExtract(ST_Intersection(a.geom,  b.geom), 3) 
	END geom
FROM 
	temporario.adm1_overlay a, geo_adm.pa_br_amazonia_legal_ibge_250_4674 b
WHERE 
	(a.gid % :var_num_proc) = :var_proc	
UNION ALL 
SELECT
	cd_mun::int,
	a.cd_grid::int,
	FALSE am_legal,
	CASE 
		WHEN NOT ST_Intersects(a.geom, b.geom) THEN ST_CollectionExtract(a.geom, 3)
		WHEN ST_Intersects(a.geom, b.geom) AND NOT ST_Within(a.geom, b.geom) THEN ST_CollectionExtract(ST_Difference(a.geom,  b.geom), 3) 
	END geom
FROM 
	temporario.adm1_overlay a, geo_adm.pa_br_amazonia_legal_ibge_250_4674 b 
WHERE 
	(a.gid % :var_num_proc) = :var_proc) as foo WHERE geom IS NOT NULL ;

