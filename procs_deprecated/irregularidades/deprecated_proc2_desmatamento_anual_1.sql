
DROP TABLE IF EXISTS irregularidades.proc2_step14_desmatamento_anual ;
CREATE TABLE irregularidades.proc2_step14_desmatamento_anual
(
cat_fund integer null, 
car_gid integer null , 
car integer NULL,   
desmatamento integer null, 
area_desmatamento decimal null, 
original_layer_label TEXT[] NULL , 
am_legal boolean null, 
cd_bioma integer null, 
cd_mun integer null, 
area_categoria_fundiaria decimal null, 
nm_cat_fund TEXT NULL , 
nm_agrup TEXT NULL  
);


CREATE INDEX proc2_step14_desmatamento_anual_car_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (car);
CREATE INDEX proc2_step14_desmatamento_anual_cat_fund_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (cat_fund);
CREATE INDEX proc2_step14_desmatamento_anual_original_layer_label_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (original_layer_label);
CREATE INDEX proc2_step14_desmatamento_anual_nm_cat_fund_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (nm_cat_fund);
CREATE INDEX proc2_step14_desmatamento_anual_nm_agrup_idx ON irregularidades.proc2_step14_desmatamento_anual USING btree (nm_agrup);

