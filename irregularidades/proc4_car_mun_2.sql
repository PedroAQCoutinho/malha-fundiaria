INSERT INTO irregularidades.step14_car_mun (gid, cd_mun)  
SELECT gid, bar.cd_mun FROM dados_brutos.valid_sicar_imovel vsi , LATERAL (
SELECT car, cd_mun, area 
FROM layer_fundiario.step14_area_export sae 
WHERE sae.car = vsi.gid
ORDER BY area DESC LIMIT 1
) bar 
WHERE (vsi.gid % :var_num_proc) = :var_proc ;


