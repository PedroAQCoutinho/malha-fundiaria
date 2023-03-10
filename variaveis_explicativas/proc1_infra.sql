DROP TABLE IF EXISTS variaveis_explicativas.proc1_infraestutura;
CREATE TABLE variaveis_explicativas.proc1_infraestutura (
	id_car_break int4 NULL,
	id_car_original int4 NULL,
	cd_mun int4 NULL,
	am_legal bool NULL,
	cd_bioma int4 NULL,
	area_poligono_car_break numeric NULL,
	rodovias numeric NULL,
	ferrovias numeric NULL,
	silos numeric NULL,
	frigorificos numeric NULL
);



CREATE INDEX proc1_infraestutura_cd_bioma_idx ON variaveis_explicativas.proc1_infraestutura USING btree (cd_bioma);
CREATE INDEX proc1_infraestutura_cd_mun_idx ON variaveis_explicativas.proc1_infraestutura USING btree (cd_mun);
CREATE INDEX proc1_infraestutura_id_car_break_idx ON variaveis_explicativas.proc1_infraestutura USING btree (id_car_break);
CREATE INDEX proc1_infraestutura_id_car_original_idx ON variaveis_explicativas.proc1_infraestutura USING btree (id_car_original);

INSERT INTO variaveis_explicativas.proc1_infraestutura
WITH foo AS (SELECT a.car id_car_break, UNNEST(b.original_gid) id_car_original ,  area area_poligono,
rodovias*0.087 rodovias, ferrovias*0.087 ferrovias, 
silos*0.087 silos, frigorificos*0.087 frigorificos FROM public.proc1_contagem_infra a
LEFT JOIN car.proc2_array_agg b ON a.car = b.gid)
SELECT id_car_break, id_car_original, c.cd_mun, c.am_legal, c.cd_bioma, area_poligono area_poligono_car_break, 
rodovias, ferrovias, silos, frigorificos FROM foo
LEFT JOIN irregularidades.proc7_step14_categorizacao c ON foo.id_car_original = c.car WHERE id_car_original IS NOT NULL 


