
DROP TABLE IF EXISTS irregularidades.proc7_step14_categorizacao_1404;
CREATE TABLE irregularidades.proc7_step14_categorizacao_1404
(
car int null, 
tipo_imove text null, 
area_imovel decimal NULL , 
am_legal boolean NULL , 
cd_mun int null, 
cd_bioma int null, 
original_layer_label TEXT[] null, 
nm_agrup TEXT NULL , 
nm_cat_fund TEXT NULL , 
m_fiscal int null, 
is_grande boolean NULL , 
is_recente boolean NULL , 
is_desm_recente boolean NULL,
desmatamento int NULL ,
is_local_restrito boolean NULL , 
tipo_irregularidade TEXT NULL , 
geom  geometry null

);

CREATE INDEX proc7_step14_categorizacao_1404_car_idx ON irregularidades.proc7_step14_categorizacao_1404 USING btree (car);
CREATE INDEX proc7_step14_categorizacao_1404_cd_mun_idx ON irregularidades.proc7_step14_categorizacao_1404 USING btree (cd_mun);
CREATE INDEX proc7_step14_categorizacao_1404_cd_bioma_idx ON irregularidades.proc7_step14_categorizacao_1404 USING btree (cd_bioma);
CREATE INDEX proc7_step14_categorizacao_1404_original_layer_label_idx ON irregularidades.proc7_step14_categorizacao_1404 USING btree (original_layer_label);
CREATE INDEX proc7_step14_categorizacao_1404_nm_agrup_idx ON irregularidades.proc7_step14_categorizacao_1404 USING btree (nm_agrup);
CREATE INDEX proc7_step14_categorizacao_1404_nm_cat_fund_idx ON irregularidades.proc7_step14_categorizacao_1404 USING btree (nm_cat_fund);
CREATE INDEX proc7_step14_categorizacao_1404_geom_idx ON irregularidades.proc7_step14_categorizacao_1404 USING GIST (geom);
