-- É preciso saber, para cada agrupamento: cat_fund, car, ano-desmatamento a área total desmatada. 
-- Além disso, trazer junto informações sobre a categoria fundiária, area e MF do CAR
DROP TABLE IF EXISTS irregularidades.proc21_step14_desmatamento_anual;
CREATE TABLE irregularidades.proc21_step14_desmatamento_anual (
cat_fund int NULL,
car int NULL, 
desmatamento int NULL,
area decimal NULL
)


INSERT INTO irregularidades.proc21_step14_desmatamento_anual (cat_fund, car, desmatamento, area)
SELECT cat_fund, car, desmatamento, sum(count)*0.087 area FROM irregularidades.proc1_step14_area_raw psar 
WHERE cat_fund IS NOT null