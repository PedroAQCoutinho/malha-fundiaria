
DROP TABLE IF EXISTS irregularidades.proc4_step14_car_join; 
CREATE TABLE irregularidades.proc4_step14_car_join AS 
SELECT a.gid, a.area, tipo_imove, uf, cod_munici, cd_bioma,  am_legal, flag, original_layer_label, nm_cat_fund, nm_agrup, area_desmatamento,
CASE 
	WHEN flag > 8 THEN TRUE 
	ELSE FALSE
END is_recente, 
CASE 
	WHEN a.area > 2500 THEN TRUE 
	ELSE  FALSE
END is_grande, is_ocupa_irregular, ST_Force2D(ST_CollectionExtract(a.valid_geom,3)) geom 
FROM dados_brutos.valid_sicar_imovel a 
LEFT JOIN irregularidades.proc31_step14_car_flag_irregular b ON a.gid = b.car
LEFT JOIN irregularidades.proc32_step14_car_ocupacao_irregular c ON a.gid = c.gid
WHERE am_legal




CREATE INDEX proc4_step14_car_join_gid_idx ON irregularidades.proc4_step14_car_join USING btree (gid);
CREATE INDEX proc4_step14_car_join_flag_idx ON irregularidades.proc4_step14_car_join USING btree (flag);
CREATE INDEX proc4_step14_car_join_original_layer_label_idx ON irregularidades.proc4_step14_car_join USING btree (nm_cat_fund);
CREATE INDEX proc4_step14_car_join_cat_agrupada_idx ON irregularidades.proc4_step14_car_join USING btree (nm_agrup);
CREATE INDEX proc4_step14_car_join_geom_idx ON irregularidades.proc4_step14_car_join USING gist (geom);
