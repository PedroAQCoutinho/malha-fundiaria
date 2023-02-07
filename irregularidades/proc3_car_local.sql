DROP TABLE IF EXISTS irregularidades.proc32_step14_car_ocupacao_irregular;
CREATE TABLE irregularidades.proc32_step14_car_ocupacao_irregular as
SELECT a.gid, a.area, area_desmatamento, area_desmatamento/(a.area+0.01) parea, 
CASE 
	WHEN area_desmatamento/(a.area+0.01) > 1 THEN FALSE 
	WHEN area_desmatamento/(a.area+0.01) < 0.05 THEN FALSE 
	ELSE TRUE
END is_ocupa_irregular,
original_layer_label, am_legal, cd_bioma, cd_mun, nm_cat_fund, nm_agrup 
FROM dados_brutos.valid_sicar_imovel a , LATERAL (SELECT * 
FROM  irregularidades.proc2_step14_desmatamento_anual b 
WHERE b.car = a.gid AND (nm_agrup = 'publica_afetada' 
OR nm_agrup = 'publica_afetada__imovel_rural_privado' 
OR nm_agrup = 'publica afetada_coletiva_privada'
OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada')
ORDER BY desmatamento LIMIT 1) c 
UNION ALL 
SELECT a.gid, a.area, area_desmatamento, area_desmatamento/(a.area+0.01)  parea, 
FALSE is_ocupa_irregular,
original_layer_label, am_legal, cd_bioma, cd_mun, nm_cat_fund, nm_agrup 
FROM dados_brutos.valid_sicar_imovel a , LATERAL (SELECT * 
FROM  irregularidades.proc2_step14_desmatamento_anual b 
WHERE b.car = a.gid AND (nm_agrup != 'publica_afetada' 
OR nm_agrup != 'publica_afetada__imovel_rural_privado' 
OR nm_agrup != 'publica afetada_coletiva_privada'
OR nm_agrup != 'publica imovel_privado_coletivo_publica_destinada')
ORDER BY desmatamento LIMIT 1) c 




CREATE INDEX proc32_step14_car_ocupacao_irregular_car_idx ON irregularidades.proc32_step14_car_ocupacao_irregular USING btree (car);
CREATE INDEX proc32_step14_car_ocupacao_irregular_original_layer_label_idx ON irregularidades.proc32_step14_car_ocupacao_irregular USING btree (original_layer_label);
CREATE INDEX proc32_step14_car_ocupacao_irregular_cat_agrupada_idx ON irregularidades.proc32_step14_car_ocupacao_irregular USING btree (cat_agrupada);
