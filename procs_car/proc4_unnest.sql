DROP TABLE IF EXISTS car.proc4_unnest;
CREATE TABLE car.proc4_unnest (
id_car_break integer NULL,
id_car_original integer NULL,
array_length integer NULL,
area decimal null
);

CREATE INDEX proc4_unnest_id_car_break_idx ON car.proc4_unnest USING btree (id_car_original);
CREATE INDEX proc4_unnest_id_car_original_idx ON car.proc4_unnest USING btree (id_car_original);
CREATE INDEX proc4_unnest_id_array_length_idx ON car.proc4_unnest USING btree (array_length);

INSERT INTO  car.proc4_unnest
SELECT gid id_car_break, unnest(original_gid) id_car_original, array_length(original_gid, 1) , area 
FROM car.proc2_array_agg paa 