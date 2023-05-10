-- É preciso saber, para cada agrupamento: cat_fund, car, ano-desmatamento a área total desmatada. 
-- Além disso, trazer junto informações sobre a categoria fundiária, area e MF do CAR
\echo desmatamento 1

DROP TABLE IF EXISTS irregularidades.proc21_malha_uso_anual;
CREATE TABLE irregularidades.proc21_malha_uso_anual (
cat_fund int NULL,
id_car_break int NULL, 
uso int NULL,
area decimal NULL
);

CREATE INDEX proc21_malha_uso_anual_car_idx ON irregularidades.proc21_malha_uso_anual USING btree (car);
CREATE INDEX proc21_malha_uso_anual_cat_fund_idx ON irregularidades.proc21_malha_uso_anual USING btree (cat_fund);
CREATE INDEX proc21_malha_uso_anual_uso_idx ON irregularidades.proc21_malha_uso_anual USING btree (uso);

INSERT INTO irregularidades.proc21_malha_uso_anual (cat_fund, id_car_break, uso, area)
SELECT cat_fund, id_car_break, uso, sum(count)*0.087 area FROM irregularidades.proc1_malhav2 psar 
WHERE cat_fund IS NOT null
GROUP BY cat_fund, car, uso;