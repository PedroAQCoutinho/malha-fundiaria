CREATE TABLE queries.categorias_fundiarias_label AS 
SELECT ROW_NUMBER() OVER () id, original_layer , 
CASE 
	WHEN sum(area) OVER (ORDER BY area desc)/sum(area) OVER () < 0.99 THEN original_layer 
	ELSE 'OUTROS'
END label_layer,
area/10000 area,
sum(area)/sum(area) OVER () parea_individual,
sum(area) OVER (ORDER BY area desc)/sum(area) OVER () parea_total,
sum(area) OVER (ORDER BY AREA DESC)/10000 cumsum, geom
FROM queries.categorias_fundiarias_sumarise cfs GROUP BY original_layer, area , geom ORDER BY area DESC