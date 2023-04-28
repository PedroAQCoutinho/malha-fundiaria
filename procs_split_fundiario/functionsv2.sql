-- Essa funcao filtra todas as camadas listadas na tabela input para uma dada quadricula do grid 
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
    RETURN QUERY EXECUTE format('SELECT cd_grid, ''%s'' original_layer, 
	b.gid original_gid, ST_CollectionExtract(ST_Intersection(ST_SETSRID(b.valid_geom, 4326), ST_SETSRID(a.geom, 4326)), 3) geom FROM grid.adm2_overlay a
	LEFT JOIN dados_brutos.%I b ON ST_Intersects(ST_SETSRID(a.geom, 4326), ST_SETSRID(b.valid_geom, 4326)) WHERE cd_grid = %s %s', 
	(SELECT a.label FROM auxiliares.inputs a WHERE a.nm_dado_original_valid_geom = tab), 
	tab, 
	grid,
	(SELECT a.where_clause FROM auxiliares.inputs a WHERE a.nm_dado_original_valid_geom = tab));

RETURN NEXT;
END LOOP;
RETURN;
END;
$$ 
LANGUAGE plpgsql VOLATILE;



-- Essa funcao aplica a funcao anterior e cria um  tabela temporaria com o sample de dados filtrados pelo grid
CREATE OR REPLACE FUNCTION sample_data(grid int)
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('CREATE TABLE public.grid_%s_data AS 
				SELECT * FROM (SELECT * FROM get_table_data(%s) WHERE geom IS NOT NULL
				UNION ALL 
				SELECT cd_grid, ''GRID'' original_layer, ao.gid original_gid, geom 
				FROM grid.adm2_overlay ao WHERE cd_grid = %s) foo;', 
     grid, grid, grid);
END
$func$;


-- Dump dasfeicoes
CREATE OR REPLACE FUNCTION f_dump(grid int)
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('CREATE TABLE public.dump_%s AS
      SELECT a.gid, cd_grid, cd_mun, am_legal, 1 cd_bioma, original_layer, original_gid,
      st_collectionextract((ST_Dump(ST_Intersection(ST_SETSRID(a.geom, 4326), ST_SETSRID(b.geom, 4326)))).geom, 3) geom 
      FROM public.grid_%s_data a LEFT JOIN grid.adm2_overlay b
      ON ST_Intersects(ST_SETSRID(a.geom, 4326), ST_SETSRID(b.geom, 4326)) WHERE  b.cd_grid = cast(%s as integer);
      CREATE INDEX dump_%s_gid_idx ON dump_%s USING btree (gid);
      CREATE INDEX dump_%s_geom_idx ON dump_%s USING GIST (geom);', 
     grid, grid, grid, grid, grid, grid, grid);
END
$func$;



-- split e formação de binários
CREATE OR REPLACE FUNCTION split_polygons(grid int)
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('
      CREATE TABLE proc1_split_polygons_%s AS 
      SELECT st_asbinary((ST_Dump(ST_Split(ST_Union(ST_Force2d(geom)), ST_Union(st_exteriorring(ST_Force2d(geom)))))).geom) bin, 
      (ST_Dump(ST_Split(ST_Union(ST_Force2d(geom)), ST_Union(st_exteriorring(ST_Force2d(geom)))))).geom 
      FROM dump_%s;
      CREATE INDEX proc1_split_polygons_%s_bin_idx ON proc1_split_polygons_%s USING hash (bin);
      CREATE INDEX proc1_split_polygons_%s_geom_idx ON proc1_split_polygons_%s USING GIST (geom);', 
     grid,grid,grid,grid,grid,grid);
END
$func$; 


--resgate das informações
CREATE OR REPLACE FUNCTION inserto_array_agg(grid int)
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('
        INSERT INTO car.proc2_array_agg (original_gid, original_layer, cd_grid, cd_mun, am_legal, cd_bioma, area, geom) 
        SELECT
        array_agg(b.original_gid) original_gid,
        array_agg(original_layer) original_layer,
        cd_grid,
        cd_mun, 
        am_legal, 
        cd_bioma, 
        ST_Area(ST_Union(ST_Force2d(a.geom))::geography)/10000 area,
        ST_Union(ST_Force2d(a.geom)) geom
        FROM proc1_split_polygons_%s a 
        LEFT JOIN dump_%s b ON ST_Intersects(ST_Buffer(a.geom::geography, -5), b.geom) 
        GROUP BY bin, cd_grid;', grid, grid);
END
$func$;






SELECT sample_data(264063)
SELECT f_dump(264063)
SELECT split_polygons(264063)
select inserto_array_agg(264063)












