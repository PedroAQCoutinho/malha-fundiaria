-- + am legal
\echo + AM legal

INSERT INTO outputs.adm2_overlay (cd_mun, cd_bioma, am_legal, geom)
SELECT * FROM (SELECT
	cast(cd_mun AS integer),
	a.cd_bioma,
	TRUE am_legal,
	CASE 
		WHEN ST_Within(a.geom, b.geom) THEN ST_CollectionExtract(a.geom, 3)
		WHEN ST_Intersects(a.geom, b.geom) AND NOT ST_Within(a.geom, b.geom) THEN ST_CollectionExtract(ST_Intersection(a.geom,  b.geom), 3) 
	END geom
FROM 
	outputs.adm1_overlay a , geo_adm.pa_br_amazonia_legal_ibge_250_4674 b
WHERE 
	(a.gid % :var_num_proc) = :var_proc	
UNION ALL 
SELECT
	cast(cd_mun AS integer),
	a.cd_bioma,
	FALSE am_legal,
	CASE 
		WHEN NOT ST_Intersects(a.geom, b.geom) THEN ST_CollectionExtract(a.geom, 3)
		WHEN ST_Intersects(a.geom, b.geom) AND NOT ST_Within(a.geom, b.geom) THEN ST_CollectionExtract(ST_Difference(a.geom,  b.geom), 3) 
	END geom
FROM 
	outputs.adm1_overlay a , geo_adm.pa_br_amazonia_legal_ibge_250_4674 b
WHERE 
	(a.gid % :var_num_proc) = :var_proc) foo
WHERE geom IS NOT NULL ;