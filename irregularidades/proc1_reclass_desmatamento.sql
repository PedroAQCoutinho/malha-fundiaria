DROP TABLE IF EXISTS irregularidades.step14_reclass_desmatamento;
CREATE TABLE irregularidades.step14_reclass_desmatamento AS 
SELECT original_layer_label, cat_agrupada, sae.car , am_legal, cd_bioma, cd_mun, CASE 
	WHEN desmatamento = 7 THEN 5
	WHEN desmatamento = 40 THEN 7
	WHEN desmatamento = 30 THEN 6
	WHEN desmatamento = -1 THEN 999
	ELSE desmatamento
END desmatamento
FROM layer_fundiario.step14_area_export sae 
WHERE car != -1;


CREATE INDEX step14_reclass_desmatamento_original_layer_label_idx ON irregularidades.step14_reclass_desmatamento USING btree (original_layer_label);
CREATE INDEX step14_reclass_desmatamento_cat_agrupada_idx ON irregularidades.step14_reclass_desmatamento USING btree (cat_agrupada);
CREATE INDEX step14_reclass_desmatamento_car_idx ON irregularidades.step14_reclass_desmatamento USING btree (car);
CREATE INDEX step14_reclass_desmatamento_cd_bioma_idx ON irregularidades.step14_reclass_desmatamento USING btree (cd_bioma);
CREATE INDEX step14_reclass_desmatamento_cd_mun_idx ON irregularidades.step14_reclass_desmatamento USING btree (cd_mun);
CREATE INDEX step14_reclass_desmatamento_desmatamento_idx ON irregularidades.step14_reclass_desmatamento USING btree (desmatamento);