--UNNESTAR OS IDS DO CAR
CREATE TABLE variaveis_explicativas.proc22_uso_agrup AS 
SELECT id_car_break , unnest(original_gid) id_car_original, uso id_uso,
area_ano_2000,
area_ano_2005,
area_ano_2010,
area_ano_2015,
area_ano_2021 FROM variaveis_explicativas.proc21_uso_agrup a 
LEFT JOIN car.proc2_array_agg b ON a.id_car_break  = b.gid 


CREATE INDEX proc22_uso_agrup_cid_car_break_idx ON variaveis_explicativas.proc22_uso_agrup  USING btree (id_car_break);
CREATE INDEX proc22_uso_agrup_id_car_original_idx ON variaveis_explicativas.proc22_uso_agrup  USING btree (id_car_original);
CREATE INDEX proc22_uso_agrup_id_uso_idx ON variaveis_explicativas.proc22_uso_agrup  USING btree (id_uso);


