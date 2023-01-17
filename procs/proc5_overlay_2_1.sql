-- Municipios x biomas
\echo Municipios + Biomas

INSERT INTO outputs.adm1_overlay (cd_mun, cd_bioma, geom)
SELECT
	cast(cd_mun AS integer),
	cd_bioma,
	CASE 
		WHEN b.geom IS NULL OR a.geom IS NULL THEN NULL
		ELSE ST_CollectionExtract(ST_Intersection(a.geom,  b.geom), 3) 
	END geom	
FROM 
	geo_adm.pa_br_limitemunicipal_250_2015_ibge_4674 a 
LEFT JOIN 
	geo_adm.pa_br_limitebiomas_250_2006_ibge_4674 b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;