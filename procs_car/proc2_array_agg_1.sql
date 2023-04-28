
DROP TABLE IF EXISTS car.proc2_array_agg;
CREATE TABLE car.proc2_array_agg (

gid serial NOT null,
original_gid int[] null,
cd_grid integer null, 
cd_mun integer null, 
am_legal boolean null ,
cd_bioma int null, 
area decimal null,
geom geometry null


);

CREATE INDEX proc2_array_agg_bin_idx ON car.proc2_array_agg USING btree (gid);
CREATE INDEX proc2_array_agg_geom_idx ON car.proc2_array_agg USING GIST (geom);













