CREATE TABLE irregularidades.step14_car_mun AS  
SELECT gid, bar.cd_mun FROM dados_brutos.valid_sicar_imovel vsi , LATERAL (
SELECT car, cd_mun, area 
FROM layer_fundiario.step14_area_export sae 
WHERE sae.car = vsi.gid
ORDER BY area DESC LIMIT 1
) bar


CREATE INDEX step14_car_mun_gid_idx ON irregularidades.step14_car_mun USING btree (gid);
CREATE INDEX step14_car_mun_cd_mun_idx ON irregularidades.step14_car_mun USING btree (cd_mun);
