
DROP TABLE IF EXISTS temporarios.gridbr;
CREATE TABLE temporarios.gridbr as
SELECT ROW_NUMBER() OVER () id,*
FROM  ST_CreateFishnet(4100, 4000, 0.01, 0.01, -74.3904499689998971, -34.7511779939999457) AS cells;




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