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
nm_agrup TEXT NULL
);


CREATE INDEX proc2_step14_desmatamento_anual_original_layer_label_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (original_layer_label);
CREATE INDEX proc2_step14_desmatamento_anual_cat_agrupada_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (cat_agrupada);
CREATE INDEX proc2_step14_desmatamento_anual_car_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (car);
CREATE INDEX proc2_step14_desmatamento_anual_cd_bioma_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (cd_bioma);
CREATE INDEX proc2_step14_desmatamento_anual_cd_mun_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (cd_mun);
CREATE INDEX proc2_step14_desmatamento_anual_desmatamento_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (desmatamento);


