
DROP TABLE IF EXISTS car.proc2_array_agg;
CREATE TABLE car.proc2_array_agg (

gid int[] null,
cd_grid integer null, 
cd_mun integer null, 
am_legal boolean null ,
cd_bioma int null, 
area decimal null,
geom geometry null


);

CREATE INDEX proc2_array_agg_bin_idx ON car.proc2_array_agg USING btree (gid);
CREATE INDEX proc2_array_agg_geom_idx ON car.proc2_array_agg USING GIST (geom);


CREATE OR REPLACE FUNCTION car_dump(t_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('CREATE TEMPORARY TABLE car_dump_%s AS
      SELECT a.gid, cd_grid, cd_mun, am_legal, cd_bioma
      st_collectionextract((ST_Dump(ST_Intersection(a.valid_geom, b.geom))).geom, 3) geom 
      FROM dados_brutos.valid_sicar_imovel a LEFT JOIN temporario.adm2_overlay b
      ON ST_Intersects(a.valid_geom, b.geom) WHERE  b.cd_grid = cast(%s as integer);
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
      CREATE TEMPORARY TABLE proc1_split_polygons_%s AS 
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
      INSERT INTO car.proc2_array_agg (geom, gid, cd_grid, cd_mun, am_legal, cd_bioma, area) 
      SELECT ST_Union(ST_Force2d(a.geom)) geom,
      array_agg(b.gid) gid, cd_grid, cd_mun, am_legal, cd_bioma
      ST_Area(ST_Union(ST_Force2d(a.geom))::geography) area  FROM proc1_split_polygons_%s a 
      LEFT JOIN car_dump_%s b ON ST_Intersects(ST_Buffer(a.geom::geography, -5), b.geom) 
      GROUP BY bin, cd_grid, cd_mun, am_legal;', t_name, t_name);
END
$func$;















