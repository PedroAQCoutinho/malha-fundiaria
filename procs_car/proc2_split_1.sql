DROP TABLE IF EXISTS car.proc2_split_polygons;
CREATE TABLE car.proc2_split_polygons (

bin blob null,
geom geometry null

);


CREATE INDEX proc2_split_polygons_geom_idx ON car.proc2_split_polygons USING GIST (geom);
CREATE INDEX proc2_split_polygons_gid_idx ON car.proc2_split_polygons USING btree (gid);
CREATE INDEX proc2_split_polygons_area_idx ON car.proc2_split_polygons USING btree (area);