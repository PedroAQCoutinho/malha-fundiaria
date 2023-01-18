

-- Layer anterior e assentamentos federais
\echo + Assentamentos federais
INSERT INTO outputs.step3_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, geom)
SELECT-- Feições de todo o resto subtraído de feicoes quilombolas
	a.cd_mun, 
	a.cd_bioma,
	a.am_legal,
	a.original_gid,
	a.original_layer,
	a.is_ti,
	a.is_qui,
	FALSE is_assenfed,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step2_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_assentamento_federal_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui
UNION ALL 
SELECT -- Feições de assent fed
	b.cd_mun,
	b.cd_bioma,
	b.am_legal,
	array_cat(a.original_gid, b.original_gid),
	array_cat(array_fill(a.cd_layer, array[ array_length(a.original_gid, 1) ]) , b.original_layer) original_layer,
	b.is_ti,
	b.is_qui,
	TRUE is_assenfed,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_assentamento_federal_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step2_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;
