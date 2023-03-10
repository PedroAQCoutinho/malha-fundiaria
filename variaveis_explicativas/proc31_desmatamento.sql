CREATE TABLE variaveis_explicativas.proc3_desmatamento AS 
SELECT  car id_car_break, id_car_original, sum(desmatamento) desmatamento FROM public.proc1_contagem_infra a ,
LATERAL (SELECT car id_car_break, UNNEST(original_gid) id_car_original FROM car.proc2_array_agg b WHERE a.car = b.gid) foo
GROUP BY car, id_car_original

CREATE INDEX proc3_desmatamento_id_car_break_idx ON variaveis_explicativas.proc3_desmatamento  USING btree (id_car_break);
CREATE INDEX proc3_desmatamento_id_car_original_idx ON variaveis_explicativas.proc3_desmatamento  USING btree (id_car_original);
CREATE INDEX proc3_desmatamento_desmatamento_idx ON variaveis_explicativas.proc3_desmatamento  USING btree (desmatamento);
