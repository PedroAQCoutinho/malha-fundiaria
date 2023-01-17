

-- Base municipal e TIs
\echo + TIs

INSERT INTO outputs.step1_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti,  geom)
SELECT
	cd_mun, 
	cd_bioma,
	am_legal,
	ARRAY[0] original_gid,
	ARRAY[0] original_layer,
	FALSE is_ti,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.adm2_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_terrasindigenas_funai_2022 ) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	cd_mun, a.geom, a.cd_bioma, a.am_legal
UNION ALL
SELECT 
	b.cd_mun,
	b.cd_bioma, 
	b.am_legal,
	original_gid,
	ARRAY_FILL(a.cd_layer, array[ array_length(a.original_gid, a.cd_layer) ]) original_layer,
	TRUE is_ti,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_terrasindigenas_funai_2022) a	
LEFT JOIN 
	(SELECT cd_mun, cd_bioma, am_legal, geom FROM outputs.adm2_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;