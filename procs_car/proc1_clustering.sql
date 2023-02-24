DROP TABLE IF EXISTS car.proc1_clustering ; 
CREATE TABLE car.proc1_clustering AS 
SELECT st_asbinary((ST_Dump(ST_Split(ST_Union(g) , ST_Union(g2)))).geom) bin,  --pega o binário de cada feição para group by posterior
(ST_Dump(ST_Split(ST_Union(g), ST_Union(g2)))).geom geom --feições
FROM car.valid_sicar_imovel_dump, 
LATERAL ( --lateral join que retorna as feições clusterizadas. O gid se perde porém será resgatado no proc2 
SELECT  unnest(ST_ClusterIntersecting(geom)) g , --retorna geometria
ST_ExteriorRing((ST_Dump(unnest(ST_ClusterIntersecting(geom)))).geom) g2 -- retorna lines para split   
FROM car.valid_sicar_imovel_dump) bar; 

CREATE INDEX proc1_clustering_bn_idx ON car.proc1_clustering USING btree (bin);
CREATE INDEX proc1_clustering_geom_idx ON car.proc1_clustering USING GIST (geom);


