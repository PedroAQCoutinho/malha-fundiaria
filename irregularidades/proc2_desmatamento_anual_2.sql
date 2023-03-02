\echo proc2_step14_desmatamento_anual

INSERT INTO irregularidades.proc2_step14_desmatamento_anual (cat_fund, car,  car_gid, desmatamento, area_desmatamento, original_layer_label, 
am_legal, cd_bioma, cd_mun, area_categoria_fundiaria, nm_cat_fund, nm_agrup ) 
SELECT cat_fund::int, c.gid car, c.original_gid car_gid,
desmatamento , count*0.0875 area_desmatamento , original_layer_label , sil.am_legal, sil.cd_bioma, sil.cd_mun, sil.area area_categoria_fundiaria,
nm_cat_fund, nm_agrup 
FROM  layer_fundiario.step14_id_label sil
LEFT JOIN irregularidades.proc1_step14_area_raw psar  ON gid = cat_fund::int
LEFT JOIN car.proc2_array_agg c ON psar.car = c.gid 
WHERE cat_fund IS NOT NULL and (sil.gid % :var_num_proc) = :var_proc