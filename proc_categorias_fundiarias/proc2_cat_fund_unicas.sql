DROP TABLE layer_fundiario.categorias_fundiarias_unicas;
CREATE TABLE layer_fundiario.categorias_fundiarias_unicas AS 
WITH foo AS (SELECT gid, cd_mun, cd_bioma, am_legal, unnest(original_gid) origid, UNNEST(original_layer) orilayer  FROM outputs.step14_overlay a ),
bar AS (SELECT gid,
CASE 
	WHEN orilayer = 12 AND origid IN (SELECT * FROM auxiliares.input_gid_ucus_apa) THEN 'UCUSAPA'
	ELSE label_agrupado
END label_agrupado , orilayer FROM foo
LEFT JOIN auxiliares.inputs b ON  orilayer = id_input  
ORDER BY gid, orilayer)
SELECT DISTINCT anyarray_sort(anyarray_uniq(array_agg(label_agrupado))) FROM bar
GROUP BY gid