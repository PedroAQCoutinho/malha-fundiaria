-- É preciso saber, para cada agrupamento: cat_fund, car, ano-desmatamento a área total desmatada. 
-- Além disso, trazer junto informações sobre a categoria fundiária, area e MF do CAR
DROP TABLE IF EXISTS irregularidades.proc21_malha_desmatamento_anual;
CREATE TABLE irregularidades.proc21_malha_desmatamento_anual (
cat_fund int NULL,
car int NULL, 
desmatamento int NULL,
area decimal NULL
);

CREATE INDEX proc21_malha_desmatamento_anual_car_idx ON irregularidades.proc21_malha_desmatamento_anual USING btree (car);
CREATE INDEX proc21_malha_desmatamento_anual_cat_fund_idx ON irregularidades.proc21_malha_desmatamento_anual USING btree (cat_fund);
CREATE INDEX proc21_malha_desmatamento_anual_desmatamento_idx ON irregularidades.proc21_malha_desmatamento_anual USING btree (desmatamento);

INSERT INTO irregularidades.proc21_malha_desmatamento_anual (cat_fund, car, desmatamento, area)
SELECT cat_fund, car, desmatamento, sum(count)*0.087 area FROM irregularidades.proc1_malhav2 psar 
WHERE cat_fund IS NOT null
GROUP BY cat_fund, car, desmatamento;