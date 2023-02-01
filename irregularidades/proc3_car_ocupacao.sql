DROP TABLE IF EXISTS irregularidades.step14_car_ocupacao;
CREATE TABLE irregularidades.step14_car_ocupacao AS
WITH foo AS (SELECT car, UNNEST(original_layer_label) original_layer_label, cat_agrupada
FROM irregularidades.step14_reclass_desmatamento srd 
WHERE cat_agrupada = 'imovel_em_pub_afetada' OR cat_agrupada = 'publica_afetada')
SELECT car, anyarray_sort(anyarray_uniq(array_agg(original_layer_label))) original_layer_label, anyarray_sort(anyarray_uniq(array_agg(cat_agrupada))) cat_agrupada 
FROM foo
GROUP BY foo.car;


CREATE INDEX step14_car_ocupacao_car_idx ON irregularidades.step14_car_ocupacao USING btree (car);
CREATE INDEX step14_car_ocupacao_original_layer_label_idx ON irregularidades.step14_car_ocupacao USING btree (original_layer_label);
CREATE INDEX step14_car_ocupacao_cat_agrupada_idx ON irregularidades.step14_car_ocupacao USING btree (cat_agrupada);
