DROP TABLE IF EXISTS car.proc1_clustering ; 
CREATE TABLE car.proc1_clustering AS 
SELECT st_asbinary((ST_Dump(ST_Split(ST_Union(g) , ST_Union(g2)))).geom) bn,  (ST_Dump(ST_Split(ST_Union(g), ST_Union(g2)))).geom geom 
FROM car.valid_sicar_imovel_dump, 
LATERAL (
SELECT  unnest(ST_ClusterIntersecting(geom)) g , ST_ExteriorRing((ST_Dump(unnest(ST_ClusterIntersecting(geom)))).geom) g2 
FROM car.valid_sicar_imovel_dump) bar;

CREATE INDEX proc1_clustering_bn_idx ON car.proc1_clustering USING btree (bn);
CREATE INDEX proc1_clustering_geom_idx ON car.proc1_clustering USING GIST (geom);


