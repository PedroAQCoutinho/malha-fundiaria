
DROP TABLE IF EXISTS irregularidades.proc23_step14_desmatamento_anual ;
CREATE TABLE irregularidades.proc23_step14_desmatamento_anual
(
cat_fund integer null, 
iscar int NULL,
gid_car integer null , 
car integer NULL,   
ano integer null, 
area_count decimal null, 
cd_grid INT NULL , 
cd_mun INT null, 
am_legal BOOLEAN null, 
cd_bioma integer null, 
nm_agrup TEXT null, 
nm_cat_fund TEXT NULL , 
orilabel TEXT[] NULL  
);


CREATE INDEX proc23_step14_desmatamento_anual_car_idx ON irregularidades.proc23_step14_desmatamento_anual USING btree (car);
CREATE INDEX proc23_step14_desmatamento_anual_cat_fund_idx ON irregularidades.proc23_step14_desmatamento_anual USING btree (cat_fund);
CREATE INDEX proc23_step14_desmatamento_anual_orilabel_idx ON irregularidades.proc23_step14_desmatamento_anual USING btree (orilabel);
CREATE INDEX proc23_step14_desmatamento_anual_nm_cat_fund_idx ON irregularidades.proc23_step14_desmatamento_anual USING btree (nm_cat_fund);
CREATE INDEX proc23_step14_desmatamento_anual_nm_agrup_idx ON irregularidades.proc23_step14_desmatamento_anual USING btree (nm_agrup);
