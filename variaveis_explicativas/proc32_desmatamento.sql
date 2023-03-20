DROP TABLE IF EXISTS variaveis_explicativas.proc32_desmatamento;
CREATE TABLE variaveis_explicativas.proc32_desmatamento (
	id_car_break int4 NULL,
	id_car_original int4 NULL,
	desmatamento int8 NULL,
	tipo_irregularidade text NULL,
	am_legal BOOLEAN NULL,
	cd_mun integer NULL,
	cd_bioma integer null
);
CREATE INDEX proc32_desmatamento_desmatamento_idx ON variaveis_explicativas.proc32_desmatamento USING btree (desmatamento);
CREATE INDEX proc32_desmatamento_id_car_break_idx ON variaveis_explicativas.proc32_desmatamento USING btree (id_car_break);
CREATE INDEX proc32_desmatamento_tipo_irregularidade_idx ON variaveis_explicativas.proc32_desmatamento USING btree (tipo_irregularidade);

INSERT INTO variaveis_explicativas.proc32_desmatamento
SELECT id_car_break, id_car_original , a.desmatamento , b.tipo_irregularidade , am_legal, cd_mun, cd_bioma 
FROM variaveis_explicativas.proc31_desmatamento a
LEFT JOIN irregularidades.proc7_step14_categorizacao b ON a.id_car_original = b.car 