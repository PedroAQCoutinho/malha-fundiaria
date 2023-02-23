DROP TABLE IF EXISTS irregularidades.proc5_step14_tipo_oii;
CREATE TABLE irregularidades.proc5_step14_tipo_oii
(
gid INT NULL , 
area_imovel DECIMAL NULL,
tipo_imove TEXT NULL, 
uf TEXT NULL,
cod_munici INT NULL,
cd_bioma INT NULL, 
flag int NULL, 
nm_cat_fund TEXT NULL, 
nm_agrup TEXT NULL, 
is_recente BOOLEAN NULL, 
is_ocupa_irregular BOOLEAN NULL, 
is_grande BOOLEAN NULL, 
tipo TEXT NULL,
geom geometry NULL 
);


CREATE INDEX proc5_step14_tipo_oii_gid_idx ON irregularidades.proc5_step14_tipo_oii USING btree (gid);
CREATE INDEX proc5_step14_tipo_oii_geom_idx ON irregularidades.proc5_step14_tipo_oii USING gist (geom);