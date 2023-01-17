
-- + UCUS
\echo + UCUS
INSERT INTO outputs.step5_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, is_ucus, geom)
SELECT-- Feições de todo o resto subtraído de feicoes quilombolas
	a.cd_mun, 
	a.cd_bioma,
	a.am_legal,
	a.original_gid,
	a.original_layer,
	a.is_ti,
	a.is_qui,
	a.is_assenfed,
	a.is_assenrec,
	FALSE is_ucus,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step4_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_ucus_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed, a.is_assenrec
UNION ALL 
SELECT -- Feições de assentamentos reco
	b.cd_mun,
	b.cd_bioma,
	b.am_legal,
	array_cat(a.original_gid, b.original_gid),
	array_cat(array_fill(a.cd_layer, array[ array_length(a.original_gid, 1) ]) , b.original_layer) original_layer,
	b.is_ti,
	b.is_qui,
	b.is_assenfed,
	b.is_assenrec,
	TRUE is_ucus,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_ucus_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step4_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;