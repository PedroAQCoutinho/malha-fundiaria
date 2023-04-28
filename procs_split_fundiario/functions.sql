
CREATE OR REPLACE FUNCTION car_dump(t_name varchar(30))
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('CREATE TEMPORARY TABLE car_dump_%s AS
      SELECT a.gid, cd_grid, cd_mun, am_legal, cd_bioma,
      st_collectionextract((ST_Dump(ST_Intersection(a.valid_geom, b.geom))).geom, 3) geom 
      FROM dados_brutos.valid_sicar_imovel a LEFT JOIN grid.adm3_overlay b
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
      INSERT INTO car.proc2_array_agg (geom, original_gid, cd_grid, cd_mun, am_legal, cd_bioma, area) 
      SELECT ST_Union(ST_Force2d(a.geom)) geom,
      array_agg(b.gid) original_gid, cd_grid, cd_mun, am_legal, cd_bioma,
      ST_Area(ST_Union(ST_Force2d(a.geom))::geography) area  FROM proc1_split_polygons_%s a 
      LEFT JOIN car_dump_%s b ON ST_Intersects(ST_Buffer(a.geom::geography, -5), b.geom) 
      GROUP BY bin, cd_grid, cd_mun, am_legal,cd_bioma;', t_name, t_name);
END
$func$;





---SELECION
CREATE OR REPLACE FUNCTION get_table_data(grid integer)
RETURNS TABLE (gid int, original_layer text, original_gid int, geom geometry) AS
$$
DECLARE
   tabela public.mytable%ROWTYPE;
   tab TEXT;
BEGIN
	FOR tab IN (SELECT nm_dado_original_valid_geom FROM auxiliares.inputs a WHERE a.nm_dado_original_valid_geom IS NOT NULL) LOOP	
	raise notice 'Run';	
	raise notice 'Tabela: %', tab;	
    RETURN QUERY EXECUTE format('
	
	SELECT cd_grid, ''%s'' original_layer, 
	b.gid original_gid, ST_Intersection(ST_SETSRID(b.valid_geom, 4326), ST_SETSRID(a.geom, 4326)) geom FROM grid.adm3_overlay a
	LEFT JOIN dados_brutos.%I b ON ST_Intersects(ST_SETSRID(a.geom, 4326), ST_SETSRID(b.valid_geom, 4326)) WHERE cd_grid = %s %s
	UNION ALL
	SELECT cd_grid, ''GRID'' original_layer, ao.gid original_gid, geom FROM grid.adm3_overlay ao WHERE cd_grid = %s', 
	(SELECT a.label FROM auxiliares.inputs a WHERE a.nm_dado_original_valid_geom = tab), 
	tab, 
	grid,
	(SELECT a.where_clause FROM auxiliares.inputs a WHERE a.nm_dado_original_valid_geom = tab),
	grid);

RETURN NEXT;
END LOOP;
RETURN;
END;
$$ 
LANGUAGE plpgsql VOLATILE;
