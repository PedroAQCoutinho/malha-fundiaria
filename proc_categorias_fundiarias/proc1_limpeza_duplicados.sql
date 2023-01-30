DROP TABLE IF EXISTS layer_fundiario.step14_id_label;
CREATE TABLE layer_fundiario.step14_id_label AS 
WITH foo AS (SELECT gid, anyarray_sort(anyarray_uniq(original_layer)) original_layer, am_legal, cd_bioma, cd_mun, ST_Area(geom::geography) area
FROM outputs.step14_overlay so ),
bar AS (SELECT gid, CASE 
	WHEN original_layer != '{0}' THEN anyarray_uniq(array_remove(
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
array_replace(	
array_replace(
array_replace(original_layer
, '2', 3)
, '1', 2)
, '20', 9)
, '4', 4)
,'5',4)
, '7' ,5)
, '8', 5)
,'9', 1)
,'10', 1)
, '12', 6)
, '13', 8)
, '14', 5)
,'15',5)
,'17',7)
, '16', 1), 0))
	ELSE original_layer
END original_layer ,am_legal, cd_bioma, cd_mun, area FROM foo),
nee AS (SELECT gid, array_sort(original_layer) original_layer_label, original_layer, am_legal, cd_bioma, cd_mun, area FROM bar)
SELECT gid, CASE 
	WHEN original_layer_label != '{0}' THEN 
	array_replace(
	array_replace(
	array_replace(
	array_replace(
	array_replace(
	array_replace(
	array_replace(
	array_replace(
	array_replace(
	original_layer_label::TEXT[]
	, '1', 'IMOVEL_PRIVADO')
	, '2', 'TI')
	, '3', 'Qui')
	, '4', 'ASSENTAMENTO')
	, '5', 'GLEBAPUB')
	, '7', 'MILITAR')
	, '6', 'UCUS')
	, '9', 'MASSA_DAGUA')
	, '8', 'UCPI')
	ELSE '{VAZIO}'
END original_layer_label, am_legal, cd_bioma, cd_mun, area
FROM nee;



CREATE INDEX step14_id_label_gid_idx ON layer_fundiario.step14_id_label USING btree (gid);
CREATE INDEX step14_id_label_original_layer_label_idx ON layer_fundiario.step14_id_label USING btree (original_layer_label);




