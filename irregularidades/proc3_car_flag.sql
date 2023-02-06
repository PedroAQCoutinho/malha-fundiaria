DROP TABLE IF EXISTS irregularidades.proc31_step14_car_flag_irregular; 
CREATE TABLE irregularidades.proc31_step14_car_flag_irregular AS 
SELECT car, min(desmatamento) flag FROM irregularidades.step14_reclass_desmatamento srd 
GROUP BY car; 

CREATE INDEX proc31_step14_car_flag_irregular_cd_mun_idx ON irregularidades.proc31_step14_car_flag_irregular USING btree (flag);
CREATE INDEX proc31_step14_car_flag_irregular_desmatamento_idx ON irregularidades.proc31_step14_car_flag_irregular USING btree (car);