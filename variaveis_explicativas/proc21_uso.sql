-- AGRUPA DADO BRUTO
CREATE TABLE variaveis_explicativas.proc21_uso_agrup 
SELECT car id_car_break, uso, 
sum(uso2000) area_ano_2000,  
sum(uso2000) area_ano_2005, 
sum(uso2000) area_ano_2010, 
sum(uso2000) area_ano_2015, 
sum(uso2000) area_ano_2021 
FROM public.proc1_contagem_uso a
GROUP BY car, uso


CREATE INDEX proc21_uso_agrup_id_car_break_idx ON variaveis_explicativas.proc21_uso_agrup  USING btree (id_car_break);
CREATE INDEX proc21_uso_agrup_uso_idx ON variaveis_explicativas.proc21_uso_agrup  USING btree (uso);
