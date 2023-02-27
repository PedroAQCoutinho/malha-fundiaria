DROP TABLE IF EXISTS car.proc2_array_agg;
CREATE TABLE car.proc2_array_agg (

gid int[] null,
area decimal null,
geom geometry null


);

CREATE INDEX proc2_array_agg_bin_idx ON car.proc2_array_agg USING btree (gid);
CREATE INDEX proc2_array_agg_geom_idx ON car.proc2_array_agg USING GIST (geom);


CREATE SEQUENCE IF NOT EXISTS car.car_break_seq INCREMENT BY 1 MINVALUE 36200 MAXVALUE 1600144 START WITH 36200;

CREATE OR REPLACE FUNCTION car_dump(t_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('CREATE TABLE car_dump_%s AS
      SELECT a.gid, st_collectionextract((ST_Dump(ST_Intersection(a.geom, b.geom))).geom, 3) geom 
      FROM dados_brutos.sicar_imoveis_al a , temporario.adm2_overlay b
      WHERE ST_Intersects(a.geom, b.geom) AND b.cd_grid = cast(%s as integer);
      CREATE INDEX car_dump_%s_gid_idx ON car_dump_%s USING btree (gid);
      CREATE INDEX car_dump_%s_geom_idx ON car_dump_%s USING GIST (geom);', t_name, t_name, t_name, t_name, t_name, t_name);
END
$func$;





CREATE OR REPLACE FUNCTION split_polygons(t_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('
      CREATE TABLE proc1_split_polygons_%s AS 
      SELECT st_asbinary((ST_Dump(ST_Split(ST_Union(geom), ST_Union(st_exteriorring(geom))))).geom) bin, 
      (ST_Dump(ST_Split(ST_Union(geom), ST_Union(st_exteriorring(geom))))).geom 
      FROM car_dump_%s;
      CREATE INDEX proc1_split_polygons_%s_bin_idx ON proc1_split_polygons_%s USING hash (bin);
      CREATE INDEX proc1_split_polygons_%s_geom_idx ON proc1_split_polygons_%s USING GIST (geom);', t_name,t_name,t_name,t_name,t_name,t_name);
END
$func$;





CREATE OR REPLACE FUNCTION inserto_array_agg(t_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('
      INSERT INTO car.proc2_array_agg (geom, gid, area) 
      SELECT ST_Union(ST_Force2d(a.geom)) geom,
      array_agg(b.gid) gid,
      ST_Area(ST_Union(ST_Force2d(a.geom))::geography) area  FROM proc1_split_polygons_%s a 
      LEFT JOIN car_dump_%s b ON ST_Intersects(ST_Buffer(a.geom::geography, -5), b.geom) 
      GROUP BY bin;', t_name, t_name);
END
$func$;















