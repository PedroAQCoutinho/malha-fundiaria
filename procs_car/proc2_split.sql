DROP TABLE IF EXISTS car.proc2_split
CREATE TABLE car.proc2_split AS 
SELECT ST_Union(a.geom), --union em geometrias repetidas
array_agg(b.gid) gid, --agrega os ids que fazem safe intersect
ST_Area(ST_Union(a.geom)::geography) area  FROM car.proc1_clustering a 
LEFT JOIN car.car_dump b ON ST_Intersects(ST_Buffer(a.geom::geography, -5), b.geom) --reduz 5 metros das feições, funciona como safe differece
GROUP BY bin --agrupa por binário


CREATE INDEX proc2_split_geom_idx ON car.proc2_split USING GIST (geom);
CREATE INDEX proc2_split_gid_idx ON car.proc2_split USING btree (gid);