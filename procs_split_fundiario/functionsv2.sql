-- Essa funcao filtra todas as camadas listadas na tabela input para uma dada quadricula do grid 
CREATE OR REPLACE FUNCTION get_table_data(grid integer)
RETURNS TABLE (gid int, original_layer text, original_gid int, geom geometry) AS
$$
DECLARE
   tabela public.mytable%ROWTYPE;
   tab TEXT;
BEGIN
	FOR tab IN (SELECT nm_dado_original_valid_geom FROM auxiliares.inputs a WHERE a.nm_dado_original_valid_geom IS NOT NULL) LOOP	
    RETURN QUERY EXECUTE format('SELECT cd_grid, ''%s'' original_layer, 
	b.gid original_gid, ST_CollectionExtract(ST_Intersection(ST_SETSRID(ST_Force2d(ST_CollectionExtract(b.valid_geom,3)), 4326), ST_SETSRID(ST_Force2d(ST_CollectionExtract(ST_Makevalid(a.geom),3)), 4326)), 3) geom FROM grid.adm2_overlay a
	LEFT JOIN dados_brutos.%I b ON ST_Intersects(ST_SETSRID(ST_Force2d(ST_CollectionExtract(ST_Makevalid(a.geom),3)), 4326), ST_SETSRID(ST_Force2d(ST_CollectionExtract(b.valid_geom,3)), 4326)) WHERE cd_grid = %s AND am_legal %s', 
	(SELECT a.label FROM auxiliares.inputs a WHERE a.nm_dado_original_valid_geom = tab), 
	tab, 
	grid,1
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
   EXECUTE format('CREATE TEMPORARY TABLE griddata_%s AS 
				SELECT * FROM (SELECT * FROM get_table_data(%s) WHERE geom IS NOT NULL
				UNION ALL 
				SELECT cd_grid, ''GRID'' original_layer, ao.gid original_gid, geom 
				FROM grid.adm2_overlay ao WHERE cd_grid = %s and am_legal) foo;', 
     grid, grid, grid);
END
$func$;


-- Dump dasfeicoes
CREATE OR REPLACE FUNCTION f_dump(grid int)
  RETURNS VOID
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('CREATE TEMPORARY TABLE fdump_%s AS
      SELECT a.gid, cd_grid, am_legal, original_layer, original_gid,
      st_collectionextract((ST_Dump(ST_Intersection(ST_SETSRID(a.geom, 4326), ST_SETSRID(b.geom, 4326)))).geom, 3) geom 
      FROM griddata_%s a LEFT JOIN grid.adm2_overlay b
      ON ST_Intersects(ST_SETSRID(a.geom, 4326), ST_SETSRID(b.geom, 4326)) WHERE  b.cd_grid = cast(%s as integer);
      CREATE INDEX fdump_%s_gid_idx ON fdump_%s USING btree (gid);
      CREATE INDEX fdump_%s_geom_idx ON fdump_%s USING GIST (geom);', 
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
      CREATE TEMPORARY TABLE split_polygons_%s AS 
      SELECT st_asbinary((ST_Dump(ST_Split(ST_Union(ST_Force2d(geom)), ST_Union(st_exteriorring(ST_Force2d(geom)))))).geom) bin, 
      (ST_Dump(ST_Split(ST_Union(ST_Force2d(geom)), ST_Union(st_exteriorring(ST_Force2d(geom)))))).geom 
      FROM fdump_%s;
      CREATE INDEX split_polygons_%s_bin_idx ON split_polygons_%s USING hash (bin);
      CREATE INDEX split_polygons_%s_geom_idx ON split_polygons_%s USING GIST (geom);', 
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
        INSERT INTO malhav2.proc2_malhav2 (original_gid, original_layer, cd_grid, area, geom) 
        SELECT
        array_agg(b.original_gid) original_gid,
        array_agg(original_layer) original_layer,
        cd_grid,
        ST_Area(ST_Union(ST_Force2d(st_collectionextract(st_makevalid(a.geom),3)))::geography)/10000 area,
        ST_Union(ST_Force2d(a.geom)) geom
        FROM split_polygons_%s a 
        LEFT JOIN fdump_%s b ON ST_Intersects(ST_Buffer(ST_Force2d(a.geom)::geography, -5), ST_Force2d(b.geom)) 
        GROUP BY bin, cd_grid;', grid, grid);
END
$func$;










