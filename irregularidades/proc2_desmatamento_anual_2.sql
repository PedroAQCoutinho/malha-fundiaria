\echo proc2_step14_desmatamento_anual

INSERT INTO irregularidades.proc2_step14_desmatamento_anual (cat_fund, car, desmatamento, area_desmatamento, original_layer_label, 
am_legal, cd_bioma, cd_mun, area_categoria_fundiaria, nm_cat_fund, nm_agrup ) 
SELECT cat_fund::int, car, desmatamento , count*0.0875 area_desmatamento , original_layer_label , am_legal, cd_bioma, cd_mun, area area_categoria_fundiaria,
 nm_cat_fund, nm_agrup 
FROM  layer_fundiario.step14_id_label sil
LEFT JOIN irregularidades.proc1_step14_area_raw psar  ON gid = cat_fund::int
WHERE cat_fund IS NOT NULL and (sil.gid % :var_num_proc) = :var_proc