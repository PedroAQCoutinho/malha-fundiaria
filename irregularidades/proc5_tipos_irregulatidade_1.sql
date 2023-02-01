DROP TABLE IF EXISTS irregularidades.step14_tipo_oii;
CREATE TABLE irregularidades.step14_tipo_oii
(
gid INT NULL , 
flag INT NULL, 
original_layer_label TEXT[] NULL , 
cat_agrupada TEXT[] NULL , 
area decimal null, 
tipo_imove TEXT null, 
is_data_irregular BOOLEAN NULL, 
is_ocupa_irregular BOOLEAN NULL , 
is_area_irregular boolean null, 
tipo TEXT nULL, 
geom geometry NULL 
);


CREATE INDEX step14_tipo_oii_gid_idx ON irregularidades.step14_tipo_oii USING btree (gid);
CREATE INDEX step14_tipo_oii_geom_idx ON irregularidades.step14_tipo_oii USING gist (geom);