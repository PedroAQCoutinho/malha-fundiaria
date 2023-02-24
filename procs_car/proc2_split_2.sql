DROP TABLE IF EXISTS car.proc2_split_polygons;
CREATE TABLE car.proc1_split_polygons AS 
SELECT st_asbinary((ST_Dump(ST_Split(ST_Union(geom), ST_Union(st_exteriorring(geom))))).geom) bin, 
(ST_Dump(ST_Split(ST_Union(geom), ST_Union(st_exteriorring(geom))))).geom geom
FROM car.car_dump

CREATE INDEX proc2_split_polygons_bin_idx ON car.proc2_split_polygons USING hash (bin);
CREATE INDEX proc2_split_polygons_geom_idx ON car.proc2_split_polygons USING GIST (geom);