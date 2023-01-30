CREATE TABLE layer_fundiario.step14_area_cat_fund AS 
SELECT cd_bioma, am_legal, cd_mun, original_layer_label, car, desmatamento, sum(count)*0.0941 area 
FROM layer_fundiario.step14_areabkp2 sa LEFT JOIN layer_fundiario.step14_id_label sil ON cat_fund = gid
WHERE cat_fund != 0 
GROUP BY cd_bioma, am_legal, cd_mun, original_layer_label, car, desmatamento