DROP TABLE IF EXISTS car.proc3_id_key;
CREATE TABLE car.proc3_id_key (
	id_car_break int4 NULL,
	id_car_original int4 NULL,
	array_length integer NULL,
	area numeric NULL
);
CREATE INDEX proc3_id_key_id_car_break_idx ON car.proc3_id_key USING btree (id_car_break);
CREATE INDEX proc3_id_key_id_car_original_idx ON car.proc3_id_key USING btree (id_car_original);
CREATE INDEX proc3_id_key_array_length_idx ON car.proc3_id_key USING btree (array_length);


INSERT INTO car.proc3_id_key 
SELECT gid id_car_break , UNNEST(original_gid) id_car_original, array_length(original_gid, 1) ,area  
FROM car.proc2_array_agg a