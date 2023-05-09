\echo desmatamento 3


DROP TABLE IF EXISTS irregularidades.proc23_malha_uso_anual ;
CREATE TABLE irregularidades.proc23_malha_uso_anual
(
cat_fund integer null, 
iscar int NULL,
gid_car integer null , 
car integer NULL,   
uso integer null, 
area_count decimal null, 
cd_grid INT NULL , 
cd_mun INT null, 
nm_agrup TEXT null, 
nm_cat_fund TEXT NULL 
);


CREATE INDEX proc23_malha_uso_anual_car_idx ON irregularidades.proc23_malha_uso_anual USING btree (car);
CREATE INDEX proc23_malha_uso_anual_cat_fund_idx ON irregularidades.proc23_malha_uso_anual USING btree (cat_fund);
CREATE INDEX proc23_malha_uso_anual_orilabel_idx ON irregularidades.proc23_malha_uso_anual USING btree (orilabel);
CREATE INDEX proc23_malha_uso_anual_nm_cat_fund_idx ON irregularidades.proc23_malha_uso_anual USING btree (nm_cat_fund);
CREATE INDEX proc23_malha_uso_anual_nm_agrup_idx ON irregularidades.proc23_malha_uso_anual USING btree (nm_agrup);
CREATE INDEX proc23_malha_uso_anual_uso_idx ON irregularidades.proc23_malha_uso_anual USING btree (uso);

