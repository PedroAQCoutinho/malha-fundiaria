DROP TABLE IF EXISTS irregularidades.proc2_step14_desmatamento_anual;
CREATE TABLE irregularidades.proc2_step14_desmatamento_anual (
cat_fund int NULL,
car int NULL,
desmatamento int NULL,
area_desmatamento decimal NULL,
original_layer_label TEXT[] null,
am_legal boolean NULL,
cd_bioma int NULL,
cd_mun int NULL,
area_categoria_fundiaria decimal NULL,
nm_cat_fund TEXT NULL, 
nm_agrup TEXT NULL,
geom geometry null
)


CREATE INDEX proc2_step14_desmatamento_anual_original_layer_label_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (original_layer_label);
CREATE INDEX proc2_step14_desmatamento_anual_cat_agrupada_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (cat_agrupada);
CREATE INDEX proc2_step14_desmatamento_anual_car_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (car);
CREATE INDEX proc2_step14_desmatamento_anual_cd_bioma_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (cd_bioma);
CREATE INDEX proc2_step14_desmatamento_anual_cd_mun_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (cd_mun);
CREATE INDEX proc2_step14_desmatamento_anual_desmatamento_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (desmatamento);

DROP TABLE IF EXISTS irregularidades.proc2_step14_desmatamento_anual;
CREATE TABLE irregularidades.proc2_step14_desmatamento_anual AS 
SELECT cat_fund, car, CASE 
	WHEN desmatamento = 7 THEN 5
	WHEN desmatamento = 40 THEN 7
	WHEN desmatamento = 30 THEN 6
	WHEN desmatamento = -1 THEN 999
	ELSE desmatamento
END desmatamento , count*0.0875 area_desmatamento , original_layer_label , am_legal, cd_bioma, cd_mun, area area_categoria_fundiaria, nm_cat_fund, nm_agrup , geom
FROM  layer_fundiario.step14_id_label sil
LEFT JOIN irregularidades.proc1_step14_area_raw psar  ON gid = cat_fund::int
WHERE cat_fund IS NOT NULL 
