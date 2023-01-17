
-- Layer anterior e quilombolas
\echo + Quilombolas
INSERT INTO outputs.step2_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, geom)
SELECT-- Feições de todo o resto subtraído de feicoes quilombolas
	a.cd_mun, 
	a.cd_bioma,
	a.am_legal,
	a.original_gid,
	a.original_layer,
	is_ti, 
	FALSE is_qui,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step1_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_quilombolas_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti
UNION ALL 
SELECT -- Feições de quilombolas
	b.cd_mun,
	b.cd_bioma,
	b.am_legal,
	array_cat(a.original_gid, b.original_gid),
	array_cat(array_fill(a.cd_layer, array[ array_length(a.original_gid, 1) ]) , b.original_layer) original_layer,
	is_ti,
	TRUE is_qui,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_quilombolas_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step1_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;