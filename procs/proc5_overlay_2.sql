
-- Municipios x biomas
\echo Adm Rodada1

INSERT INTO outputs.adm1_overlay (cd_mun, cd_bioma, geom)
SELECT
	cast(cd_mun AS integer),
	cd_bioma,
	CASE 
		WHEN b.geom IS NULL OR a.geom IS NULL THEN NULL
		ELSE ST_Intersection(a.geom,  b.geom) 
	END geom	
FROM 
	geo_adm.pa_br_limitemunicipal_250_2015_ibge_4674 a 
LEFT JOIN 
	geo_adm.pa_br_limitebiomas_250_2006_ibge_4674 b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;




-- + am legal
\echo Adm Rodada2

INSERT INTO outputs.adm2_overlay (cd_mun, cd_bioma, am_legal, geom)
SELECT * FROM (SELECT
	cast(cd_mun AS integer),
	a.cd_bioma,
	TRUE am_legal,
	CASE 
		WHEN ST_Within(a.geom, b.geom) THEN a.geom
		WHEN ST_Intersects(a.geom, b.geom) AND NOT ST_Within(a.geom, b.geom) THEN ST_Intersection(a.geom,  b.geom) 
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
		WHEN NOT ST_Intersects(a.geom, b.geom) THEN a.geom
		WHEN ST_Intersects(a.geom, b.geom) AND NOT ST_Within(a.geom, b.geom) THEN ST_Difference(a.geom,  b.geom) 
	END geom
FROM 
	outputs.adm1_overlay a , geo_adm.pa_br_amazonia_legal_ibge_250_4674 b
WHERE 
	(a.gid % :var_num_proc) = :var_proc) foo
WHERE geom IS NOT NULL ;



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





-- Layer anterior e assentamentos federais
\echo Rodada3
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




-- Layer anterior e assentamentos reconhecimento
\echo Rodada4
INSERT INTO outputs.step4_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, geom)
SELECT-- Feições de todo o resto subtraído de feicoes quilombolas
	a.cd_mun, 
	a.cd_bioma,
	a.am_legal,
	a.original_gid,
	a.original_layer,
	a.is_ti,
	a.is_qui,
	a.is_assenfed,
	FALSE is_assenrec,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step3_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_assentamento_reconhecimento_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed
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
	TRUE is_assenrec,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_assentamento_reconhecimento_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step3_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;



-- + UCUS
\echo Rodada5
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




-- + UCPI
\echo Rodada6
INSERT INTO outputs.step6_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, is_ucus, is_ucpi ,geom)
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
	a.is_ucus,
	FALSE is_ucpi,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step5_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_ucpi_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed, a.is_assenrec, a.is_ucus
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
	b.is_ucus,
	TRUE is_ucpi,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_ucpi_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step5_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;




-- + Gleba est
\echo Rodada7
INSERT INTO outputs.step7_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, is_ucus, is_ucpi, is_glebaest, geom)
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
	a.is_ucus,
	a.is_ucpi,
	FALSE is_glebaest,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step6_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_glebaspublicas_est_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed, a.is_assenrec, a.is_ucus, a.is_ucpi
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
	b.is_ucus,
	b.is_ucpi,
	FALSE is_glebaest,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_glebaspublicas_est_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step6_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;



-- + Gleba fed
\echo Rodada8
INSERT INTO outputs.step8_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, is_ucus, is_ucpi, is_glebaest, is_glebafed, geom)
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
	a.is_ucus,
	a.is_ucpi,
	a.is_glebaest,
	FALSE is_glebafed,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step7_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_glebaspublicas_fed_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed, a.is_assenrec, a.is_ucus, a.is_ucpi, a.is_glebaest
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
	b.is_ucus,
	b.is_ucpi,
	b.is_glebaest,
	TRUE is_glebafed,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_glebaspublicas_fed_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step7_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;




-- + SIGEF pub
\echo Rodada9
INSERT INTO outputs.step9_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, is_ucus, is_ucpi, is_glebaest, is_glebafed, is_sigefpub, geom)
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
	a.is_ucus,
	a.is_ucpi,
	a.is_glebaest,
	a.is_glebafed,
	FALSE is_sigefpub,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step8_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_sigefpublico_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed, a.is_assenrec, a.is_ucus, a.is_ucpi, a.is_glebaest, a.is_glebafed
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
	b.is_ucus,
	b.is_ucpi,
	b.is_glebaest,
	b.is_glebafed,
	TRUE is_sigefpub,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_sigefpublico_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step8_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;




-- + SNCI pub
\echo Rodada10
INSERT INTO outputs.step10_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, is_ucus, is_ucpi, is_glebaest, is_glebafed, is_sigefpub, is_sigefpub, geom)
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
	a.is_ucus,
	a.is_ucpi,
	a.is_glebaest,
	a.is_glebafed,
	a.is_sigefpub,
	FALSE a.is_sncipub,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step9_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_sncipublico_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed, a.is_assenrec, a.is_ucus, a.is_ucpi, a.is_glebaest, a.is_glebafed, a.is_sigefpub
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
	b.is_ucus,
	b.is_ucpi,
	b.is_glebaest,
	b.is_glebafed,
	b.is_sigefpub,
	TRUE is_sncipub,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_sncipublico_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step9_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;


-- + SIGEF priv
\echo Rodada11
INSERT INTO outputs.step11_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, is_ucus, is_ucpi, is_glebaest, is_glebafed, is_sigefpriv, geom)
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
	a.is_ucus,
	a.is_ucpi,
	a.is_glebaest,
	a.is_glebafed,
	a.is_sigefpub,
	a.is_sncipub,
	FALSE is_sigefpriv,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step10_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_sigefprivado_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed, a.is_assenrec, a.is_ucus, a.is_ucpi, a.is_glebaest, a.is_glebafed, 	a.is_sigefpub, a.is_sncipub	
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
	b.is_ucus,
	b.is_ucpi,
	b.is_glebaest,
	b.is_glebafed,
	a.is_sigefpub,
	a.is_sncipub,
	FALSE is_sigefpriv,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_sigefprivado_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step10_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;



-- + SNCI priv
\echo Rodada12
INSERT INTO outputs.step12_overlay (cd_mun, cd_bioma, am_legal, original_gid, original_layer, is_ti, is_qui, is_assenfed, is_assenrec, is_ucus, is_ucpi, is_glebaest, is_glebafed, is_sigefpriv, geom)
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
	a.is_ucus,
	a.is_ucpi,
	a.is_glebaest,
	a.is_glebafed,
	a.is_sigefpub,
	a.is_sncipub,
	a.is_sigefpriv,
    FALSE is_sncipriv,
	CASE 
		WHEN ST_Union(b.geom) IS NULL THEN ST_CollectionExtract(a.geom,3)
		ELSE ST_CollectionExtract(ST_Difference(a.geom,  ST_Union(b.geom)) ,3)
	END geom
FROM 
	outputs.step11_overlay a 
LEFT JOIN 
	(SELECT gid, (st_dump(geom)).geom FROM inputs.input_snciprivado_2022) b
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc
GROUP BY 
	a.cd_mun, a.cd_bioma, am_legal, a.original_gid, a.original_layer, a.geom, a.is_ti, a.is_qui, a.is_assenfed, a.is_assenrec, a.is_ucus, a.is_ucpi, a.is_glebaest, a.is_glebafed, 	a.is_sigefpub, a.is_sncipub	
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
	b.is_ucus,
	b.is_ucpi,
	b.is_glebaest,
	b.is_glebafed,
	a.is_sigefpub,
	a.is_sncipub,
	b.is_sigefpriv,
    TRUE is_sncipriv,
	ST_CollectionExtract(ST_Intersection(a.geom, b.geom), 3)  geom
FROM 
	(SELECT * FROM inputs.input_snciprivado_2022) a	
LEFT JOIN 
	(SELECT * FROM outputs.step11_overlay) b 
ON
	ST_Intersects(a.geom, b.geom)
WHERE 
	(a.gid % :var_num_proc) = :var_proc;