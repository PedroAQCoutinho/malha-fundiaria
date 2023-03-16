DROP TABLE IF EXISTS variaveis_explicativas.proc23_uso_agrup;

CREATE TABLE variaveis_explicativas.proc23_uso_agrup (
	id_car_break int4 NULL,
	id_car_original int4 NULL,
	id_uso int4 NULL,
	tipo_irregularidade text NULL,
	am_legal boolean NULL,
	cd_mun integer NULL,
	cd_bioma integer NULL,
	area_ano_2000 int8 NULL,
	area_ano_2005 int8 NULL,
	area_ano_2010 int8 NULL,
	area_ano_2015 int8 NULL,
	area_ano_2021 int8 NULL
);
CREATE INDEX proc23_uso_agrup_cid_car_break_idx ON variaveis_explicativas.proc23_uso_agrup USING btree (id_car_break);
CREATE INDEX proc23_uso_agrup_id_car_original_idx ON variaveis_explicativas.proc23_uso_agrup USING btree (id_car_original);
CREATE INDEX proc23_uso_agrup_id_uso_idx ON variaveis_explicativas.proc23_uso_agrup USING btree (id_uso);
CREATE INDEX proc23_uso_agrup_tipo_irregularidade_idx ON variaveis_explicativas.proc23_uso_agrup USING btree (tipo_irregularidade);



INSERT INTO variaveis_explicativas.proc23_uso_agrup
SELECT id_car_break , id_car_original , id_uso , tipo_irregularidade , am_legal, cd_mun, cd_bioma,
area_ano_2000 , area_ano_2005 , area_ano_2010 , area_ano_2015 , area_ano_2021 
FROM variaveis_explicativas.proc22_uso_agrup a 
LEFT JOIN irregularidades.proc7_step14_categorizacao b ON a.id_car_original = b.car 

