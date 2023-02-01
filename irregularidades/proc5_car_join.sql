DROP TABLE IF EXISTS irregularidades.step14_car_join; 
CREATE TABLE irregularidades.step14_car_join AS 
SELECT gid, flag, original_layer_label, cat_agrupada , area, tipo_imove,
CASE
	WHEN flag > 8 AND flag != 999 THEN TRUE
	ELSE FALSE 
END is_data_irregular,
CASE
	WHEN cat_agrupada IS NOT NULL THEN TRUE
	ELSE FALSE 
END is_ocupa_irregular,
CASE
	WHEN area > 2500 THEN TRUE
	ELSE FALSE 
END is_area_irregular, ST_Force2D(ST_CollectionExtract(valid_geom)) geom
FROM dados_brutos.valid_sicar_imovel vsi 
LEFT JOIN irregularidades.step14_car_flag scf ON gid = scf.car
LEFT JOIN irregularidades.step14_car_ocupacao sco  ON gid = sco.car;


CREATE INDEX step14_car_join_gid_idx ON irregularidades.step14_car_join USING btree (gid);
CREATE INDEX step14_car_join_geom_idx ON irregularidades.step14_car_join USING gist (geom);
CREATE INDEX step14_car_join_flag_idx ON irregularidades.step14_car_join USING btree (flag);
CREATE INDEX step14_car_join_original_layer_label_idx ON irregularidades.step14_car_join USING btree (original_layer_label);
CREATE INDEX step14_car_join_cat_agrupada_idx ON irregularidades.step14_car_join USING btree (cat_agrupada);
