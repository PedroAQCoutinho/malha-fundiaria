CREATE TABLE irregularidades.step14_car_flag AS 
SELECT car, min(desmatamento) flag FROM irregularidades.step14_reclass_desmatamento srd 
GROUP BY car; 

CREATE INDEX step14_car_flag_cd_mun_idx ON irregularidades.step14_car_flag USING btree (flag);
CREATE INDEX step14_car_flag_desmatamento_idx ON irregularidades.step14_car_flag USING btree (car);