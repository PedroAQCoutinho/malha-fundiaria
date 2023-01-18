-- VAZIOS

DROP TABLE outputs.vazios;
CREATE TABLE outputs.vazios AS
SELECT 'VAZIOS' cat_fund, cd_mun, cd_bioma, ST_Area(geom::geography)/10000 area, geom  FROM outputs.step12_overlay so 
WHERE original_gid = '{0}' AND am_legal



CREATE INDEX vazios_original_cd_bioma_idx ON outputs.vazios USING btree (cd_bioma);
CREATE INDEX vazios_cd_mun_idx ON outputs.vazios USING btree (cd_mun);
CREATE INDEX vazios_geom_idx ON outputs.vazios USING gist (geom);
CREATE INDEX vazios_area_idx ON outputs.vazios USING btree (area);



-- TODAS AS TERRAS PUBLICAS
-- GLEBA OU SIGEF/SNCI
-- APENAS GLEBA
-- APENAS SIGEFSNCI

DROP TABLE outputs.publicas;
CREATE TABLE outputs.publicas AS 
SELECT 'GLEBA/SIGEFSNCI' cat_fund ,cd_mun, cd_bioma, ST_Area(geom::geography)/10000 area, geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_glebaest OR is_glebafed)
AND (is_sncipub OR is_sigefpub)
UNION ALL
SELECT 'GLEBA' cat_fund ,cd_mun, cd_bioma, ST_Area(geom::geography)/10000 area, geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_glebaest OR is_glebafed)
AND NOT (is_sncipub OR is_sigefpub)
UNION ALL
SELECT 'SIGEFSNCI' cat_fund ,cd_mun, cd_bioma, ST_Area(geom::geography)/10000 area, geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_sncipub OR is_sigefpub)
AND NOT (is_glebaest OR is_glebafed)


CREATE INDEX publicas_clean_original_cd_bioma_idx ON outputs.publicas_clean USING btree (cd_bioma);
CREATE INDEX publicas_clean_cd_mun_idx ON outputs.publicas_clean USING btree (cd_mun);
CREATE INDEX publicas_clean_geom_idx ON outputs.publicas_clean USING gist (geom);
CREATE INDEX publicas_clean_area_idx ON outputs.publicas_clean USING btree (area);



-- TODAS AS TERRAS PUBLICAS
-- GLEBA OU SIGEF/SNCI
-- APENAS GLEBA
-- APENAS SIGEFSNCI
-- EXCETO SOBREPOSICOES COM OUTRAS CATEGORIAS



DROP TABLE outputs.publicas_clean;

CREATE TABLE outputs.publicas_clean AS 
SELECT 'GLEBA/SIGEFSNCI' cat_fund ,cd_mun, cd_bioma, ST_Area(geom::geography)/10000 area, geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_glebaest OR is_glebafed)
AND (is_sncipub OR is_sigefpub)
AND NOT is_ti AND NOT is_qui AND NOT is_assenfed AND NOT is_assenrec AND NOT is_ucus AND NOT is_ucpi AND NOT is_sigefpriv AND NOT is_sncipriv 
UNION ALL
SELECT 'GLEBA' cat_fund ,cd_mun, cd_bioma, ST_Area(geom::geography)/10000 area, geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_glebaest OR is_glebafed)
AND NOT (is_sncipub OR is_sigefpub)
AND NOT is_ti AND NOT is_qui AND NOT is_assenfed AND NOT is_assenrec AND NOT is_ucus AND NOT is_ucpi AND NOT is_sigefpriv AND NOT is_sncipriv 
UNION ALL
SELECT 'SIGEFSNCI' cat_fund ,cd_mun, cd_bioma, ST_Area(geom::geography)/10000 area, geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_sncipub OR is_sigefpub)
AND NOT (is_glebaest OR is_glebafed)
AND NOT is_ti AND NOT is_qui AND NOT is_assenfed AND NOT is_assenrec AND NOT is_ucus AND NOT is_ucpi AND NOT is_sigefpriv AND NOT is_sncipriv 


CREATE INDEX publicas_clean_original_cd_bioma_idx ON outputs.publicas_clean USING btree (cd_bioma);
CREATE INDEX publicas_clean_cd_mun_idx ON outputs.publicas_clean USING btree (cd_mun);
CREATE INDEX publicas_clean_geom_idx ON outputs.publicas_clean USING gist (geom);
CREATE INDEX publicas_clean_area_idx ON outputs.publicas_clean USING btree (area);


-- AREAS DE INTERESSE


DROP TABLE outputs.export_areas_de_interesse;
CREATE TABLE outputs.export_areas_de_interesse AS 
SELECT cat_fund, bioma, nm_uf, area FROM (WITH vazios AS (SELECT cd_mun/100000 cd_uf , * FROM outputs.vazios),
publicas AS (SELECT cd_mun/100000 cd_uf , * FROM outputs.publicas)
SELECT cat_fund, cd_bioma, cd_uf, sum(area) area FROM vazios
GROUP BY cat_fund, cd_bioma, cd_uf
UNION ALL
SELECT cat_fund, cd_bioma, cd_uf, sum(area) area FROM publicas
GROUP BY cat_fund, cd_bioma, cd_uf) foo
LEFT JOIN geo_adm.pa_br_limitebiomas_250_2006_ibge_4674 pbli ON foo.cd_bioma = cast(pbli.cd_bioma AS integer)
LEFT JOIN geo_adm.pa_br_limiteestadual_250_2015_ibge_4674 pbee ON foo.cd_uf = cast(pbee.cd_uf AS integer)
ORDER BY foo.cd_uf, bioma, cat_fund



CREATE INDEX perc_public_mun_cd_mun_idx ON outputs.perc_public_mun USING btree (cd_mun);
CREATE INDEX perc_public_mun_geom_idx ON outputs.perc_public_mun USING gist (geom);


-- AREAS DE INTERESSE CLEAN


DROP TABLE outputs.export_areas_de_interesse_clean;
CREATE TABLE outputs.export_areas_de_interesse AS 
SELECT cat_fund, bioma, nm_uf, area FROM (WITH vazios AS (SELECT cd_mun/100000 cd_uf , * FROM outputs.vazios),
publicas AS (SELECT cd_mun/100000 cd_uf , * FROM outputs.publicas_clean)
SELECT cat_fund, cd_bioma, cd_uf, sum(area) area FROM vazios
GROUP BY cat_fund, cd_bioma, cd_uf
UNION ALL
SELECT cat_fund, cd_bioma, cd_uf, sum(area) area FROM publicas_clean
GROUP BY cat_fund, cd_bioma, cd_uf) foo
LEFT JOIN geo_adm.pa_br_limitebiomas_250_2006_ibge_4674 pbli ON foo.cd_bioma = cast(pbli.cd_bioma AS integer)
LEFT JOIN geo_adm.pa_br_limiteestadual_250_2015_ibge_4674 pbee ON foo.cd_uf = cast(pbee.cd_uf AS integer)
ORDER BY foo.cd_uf, bioma, cat_fund



CREATE INDEX perc_public_mun_cd_mun_idx ON outputs.perc_public_mun USING btree (cd_mun);
CREATE INDEX perc_public_mun_geom_idx ON outputs.perc_public_mun USING gist (geom);



























DROP TABLE outputs.perc_public_mun;

CREATE TABLE outputs.perc_public_mun AS
WITH foo AS (SELECT cd_mun, st_area(geom::geography)/10000 area, geom FROM outputs.vazios
UNION ALL SELECT cd_mun, st_area(geom::geography)/10000 area, geom FROM outputs.publicas p ),
total AS (SELECT  cd_mun, sum(area) area FROM foo GROUP BY  cd_mun)
SELECT  total.cd_mun, nm_mun, area, st_area(pbli.geom::geography)/10000 area_mun, 
CASE 
	WHEN area/(st_area(pbli.geom::geography)/10000)  > 1 THEN 1
	ELSE area/(st_area(pbli.geom::geography)/10000)
END perc_mun,
ST_Intersection(pbli.geom, pbali.geom) geom FROM total
LEFT JOIN geo_adm.pa_br_limitemunicipal_250_2015_ibge_4674 pbli ON total.cd_mun = cast(pbli.cd_mun AS integer)
LEFT JOIN geo_adm.pa_br_amazonia_legal_ibge_250_4674 pbali ON st_intersects(pbli.geom, pbali.geom)
ORDER BY area DESC




CREATE INDEX perc_public_mun_cd_mun_idx ON outputs.perc_public_mun USING btree (cd_mun);
CREATE INDEX perc_public_mun_geom_idx ON outputs.perc_public_mun USING gist (geom);





--- checar
-- TODAS AS TERRAS PUBLICAS
-- GLEBA OU SIGEF/SNCI
-- APENAS GLEBA
-- APENAS SIGEFSNCI
-- EXCETO SOBREPOSICOES COM OUTRAS CATEGORIAS



DROP TABLE outputs.publicas_destinadas;

CREATE TABLE outputs.publicas_destinadas  AS 
SELECT gid, cat_fund, is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv cd_categ, 
CASE
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 22221222 THEN 'Pública + Assentamento rec'
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 21222222 THEN 'Pública + SIGEF privado'
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 22122222 THEN 'Pública + UCPI'
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 22212222 THEN 'Pública + UCUS'
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 22222221 THEN 'Pública + TI'
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 12222222 THEN 'Pública + SNCI privado'
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 22212122 THEN 'Pública + Assentamento fed + UCUS'
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 22222122 THEN 'Pública + Assentamento fed'
	WHEN is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv = 22211222 THEN 'Pública + UCUS + Assentamento rec'
END nm_categ,
geom
FROM (SELECT gid, cat_fund, 
CASE 
	WHEN is_ti THEN 1
	ELSE 2
END is_ti,
CASE 
	WHEN is_qui THEN 10
	ELSE 20
END is_qui,
CASE 
	WHEN is_assenfed THEN 100
	ELSE 200
END is_assenfed,
CASE 
	WHEN is_assenrec THEN 1000
	ELSE 2000
END is_assenrec,
CASE 
	WHEN is_ucus THEN 10000
	ELSE 20000
END is_ucus,
CASE 
	WHEN is_ucpi THEN 100000
	ELSE 200000
END is_ucpi,
CASE 
	WHEN is_sigefpriv THEN 1000000
	ELSE 2000000
END is_sigefpriv,
CASE 
	WHEN is_sncipriv THEN 10000000
	ELSE 20000000
END is_sncipriv,
foo.geom
FROM (SELECT gid, 'GLEBA/SIGEFSNCI' cat_fund , geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_glebaest OR is_glebafed)
AND (is_sncipub OR is_sigefpub)
AND (is_ti OR is_qui OR is_assenfed OR is_assenrec OR is_ucus OR is_ucpi OR is_sigefpriv OR is_sncipriv)
UNION ALL
SELECT gid, 'GLEBA' cat_fund , geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_glebaest OR is_glebafed)
AND NOT (is_sncipub OR is_sigefpub)
AND (is_ti OR is_qui OR is_assenfed OR is_assenrec OR is_ucus OR is_ucpi OR is_sigefpriv OR is_sncipriv)
UNION ALL
SELECT gid,  'SIGEFSNCI' cat_fund , geom FROM outputs.step12_overlay
WHERE am_legal 
AND (is_sncipub OR is_sigefpub)
AND NOT (is_glebaest OR is_glebafed)
AND (is_ti OR is_qui OR is_assenfed OR is_assenrec OR is_ucus OR is_ucpi OR is_sigefpriv OR is_sncipriv)) foo
LEFT JOIN outputs.step12_overlay so using(gid)) bar WHERE 
is_ti+is_qui+is_assenfed+is_assenrec+is_ucus+is_ucpi+is_sigefpriv+is_sncipriv IN (SELECT cat FROM outputs.classes_predominantes cp)



DROP TABLE outputs.export_areas_publicas_destinadas ;
CREATE TABLE outputs.export_areas_publicas_destinadas AS 
SELECT nm_categ, sum(ST_Area(geom::geography))/10000 area FROM outputs.publicas_destinadas pd 
GROUP BY nm_categ







CREATE INDEX publicas_clean_original_cd_bioma_idx ON outputs.publicas_destinadas USING btree (cd_bioma);
CREATE INDEX publicas_clean_cd_mun_idx ON outputs.publicas_destinadas USING btree (cd_mun);
CREATE INDEX publicas_clean_geom_idx ON outputs.publicas_destinadas USING gist (geom);
CREATE INDEX publicas_clean_area_idx ON outputs.publicas_destinadas USING btree (area);




