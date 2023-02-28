\echo adm3overlay

INSERT INTO grid.adm3_overlay ( cd_mun , cd_grid, am_legal, cd_bioma,  geom)
SELECT * FROM (SELECT
	cd_mun::int,
	a.cd_grid::int,
	am_legal,
	cd_bioma::int, 
	CASE 
		WHEN ST_Within(a.geom, b.geom) THEN ST_CollectionExtract(a.geom, 3)
		WHEN ST_Intersects(a.geom, b.geom) AND NOT ST_Within(a.geom, b.geom) THEN ST_CollectionExtract(ST_Intersection(a.geom,  b.geom), 3) 
	END geom
FROM 
	grid.adm2_overlay a 
LEFT JOIN 
	geo_adm.pa_br_limitebiomas_250_2006_ibge_4674 b ON ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc) as foo WHERE geom IS NOT NULL ;
	









