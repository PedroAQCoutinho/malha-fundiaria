DROP TABLE IF EXISTS variaveis_explicativas.proc1_infraestutura;
CREATE TABLE variaveis_explicativas.proc1_infraestutura (
	id_car_break int4 NULL,
	id_car_original int4 NULL,
	tipo_irregularidade text null, 
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
CREATE INDEX proc1_infraestutura_id_tipo_irregularidade_original_idx ON variaveis_explicativas.proc1_infraestutura USING btree (tipo_irregularidade);




INSERT INTO variaveis_explicativas.proc1_infraestutura
WITH foo AS (SELECT a.car id_car_break, UNNEST(b.original_gid) id_car_original ,  a.area area_contagem_pixels,
rodovias*0.03 rodovias, ferrovias*0.03 ferrovias, --QUILOMETROS
silos*0.03 silos, frigorificos*0.03 frigorificos FROM public.proc1_contagem_infra a --QUILOMETROS
LEFT JOIN car.proc2_array_agg b ON a.car = b.gid LIMIT 10)
SELECT id_car_break, id_car_original, c.tipo_irregularidade,  c.cd_mun, c.am_legal, c.cd_bioma, area_contagem_pixels, 
rodovias, ferrovias, silos, frigorificos FROM foo
LEFT JOIN irregularidades.proc7_step14_categorizacao c ON foo.id_car_original = c.car WHERE id_car_original IS NOT NULL 

