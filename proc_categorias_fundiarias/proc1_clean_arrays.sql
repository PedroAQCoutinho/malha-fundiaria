DROP TABLE temporarios.step1_clean_arrays;
CREATE TABLE temporarios.step1_clean_arrays as 
WITH foo AS (SELECT gid, cd_mun, cd_bioma, anyarray_sort(anyarray_uniq(original_layer)) original_layer, ST_Area(geom::geography) area, geom 
FROM outputs.step13_overlay so 
WHERE am_legal AND geom IS NOT NULL AND NOT ST_IsEmpty(geom))
SELECT gid, 
cd_mun, 
cd_bioma,
CASE 
	WHEN original_layer != '{0}' THEN array_to_string(
array_remove(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(original_layer::text[]
, '1', 'TI')
, '2', 'Qui')
, '4', 'ASSFED')
,'5','ASSREC')
, '7' ,'SIGEFPUB')
, '8', 'SNCIPUB')
,'9', 'SIGEFPRIV')
,'10', 'SNCIPRIV')
, '12', 'UCUS')
, '13', 'UCPI')
, '14', 'GPEST')
,'15','GPFED')
, '16', 'TERRALEGAL')
, '0'), ',')
ELSE 'VAZIO'
END original_layer, area, geom
FROM foo


