-- Municipio x Biomas
DROP TABLE IF EXISTS temporario.adm1_overlay;
CREATE TABLE temporario.adm1_overlay
(
  gid serial NOT null,
  cd_grid integer NULL, 
  cd_mun integer NULL,
  geom geometry NULL
);



CREATE INDEX adm1_overlay_gid_idx ON temporario.adm1_overlay USING btree (gid);
CREATE INDEX adm1_overlay_cd_grid_idx ON temporario.adm1_overlay USING btree (cd_grid);
CREATE INDEX adm1_overlay_cd_mun_idx ON temporario.adm1_overlay USING btree (cd_mun);
CREATE INDEX adm1_overlay_geom_idx ON temporario.adm1_overlay USING gist (geom);


    -- + am legal
DROP TABLE IF EXISTS temporario.adm2_overlay;
CREATE TABLE temporario.adm2_overlay
(
  gid serial NOT null,
  cd_grid integer NULL, 
  cd_mun integer NULL,
  am_legal boolean NULL,
  geom geometry NULL
);



CREATE INDEX adm2_overlay_gid_idx ON temporario.adm2_overlay USING btree (gid);
CREATE INDEX adm2_overlay_cd_grid_idx ON temporario.adm2_overlay USING btree (cd_grid);
CREATE INDEX adm2_overlay_cd_mun_idx ON temporario.adm2_overlay USING btree (cd_mun);
CREATE INDEX adm2_overlay_geom_idx ON temporario.adm2_overlay USING gist (geom);



    -- + bioma
DROP TABLE IF EXISTS temporario.adm3_overlay;
CREATE TABLE temporario.adm3_overlay
(
  gid serial NOT null,
  cd_grid integer NULL, 
  cd_mun integer NULL,
  cd_bioma integer NULL,
  am_legal boolean NULL,
  geom geometry NULL
);



CREATE INDEX adm3_overlay_gid_idx ON temporario.adm3_overlay USING btree (gid);
CREATE INDEX adm3_overlay_cd_grid_idx ON temporario.adm3_overlay USING btree (cd_grid);
CREATE INDEX adm3_overlay_cd_mun_idx ON temporario.adm3_overlay USING btree (cd_mun);
CREATE INDEX adm3_overlay_geom_idx ON temporario.adm3_overlay USING gist (geom);


/*
DROP TABLE IF EXISTS temporario.gridbr;
CREATE TABLE temporario.gridbr as
SELECT ROW_NUMBER() OVER () id,*
FROM  ST_CreateFishnet(4100, 4000, 0.1, 0.1, -74.3904499689998971, -34.7511779939999457) AS cells;

CREATE INDEX gridbr_idx_geom ON temporario.gridbr USING GIST (geom);



CREATE TABLE temporario.gridbr_filtrado AS 
SELECT id, ROW, col, a.geom FROM temporario.gridbr a 
LEFT JOIN geo_adm.pa_br_limitenacional_250_2015_ibge_4674 b ON ST_Intersects(a.geom, b.geom)
WHERE b.gid IS NOT NULL 


CREATE INDEX gridbr_filtrado_idx_geom ON temporario.gridbr_filtrado USING GIST (geom);
*/