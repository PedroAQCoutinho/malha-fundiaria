CREATE TABLE car.valid_sicar_imovel_dump AS 
SELECT gid, (st_dump(valid_geom)).geom geom FROM dados_brutos.valid_sicar_imovel vsi 


CREATE INDEX valid_sicar_imovel_dump_gid_idx ON car.valid_sicar_imovel_dump USING btree (gid);
CREATE INDEX valid_sicar_imovel_dump_geom_idx ON car.valid_sicar_imovel_dump USING GIST (geom);
