-- Para a tabela proc2_step14_desmatamento_anual, temos varios registros com o mesmo car.
-- Caada registro tem um área de sobreposição. Esses registros podem ser agrupados por cat_fund, ou seja, a area total de cada cat_fund no car, agrupado pela nm_cat_fund
-- Com uma tbaela de tres colunas (car, cat_fund e area) é possivel resgatar a coluna area_car, fazer a proporcao area/area_car e filtrar para > 0.1
-- Onde as cat_fund forem maiores do que 10%, pegar a maior que indica a area predominante e classifica a propriedade.
\echo cat fund

DROP TABLE IF EXISTS irregularidades.proc5_malha_categoria_fundiaria;
CREATE TABLE irregularidades.proc5_malha_categoria_fundiaria (

car int null, 
nm_agrup text null,
am_legal boolean null

);


CREATE INDEX proc5_malha_categoria_fundiaria_car_idx ON irregularidades.proc5_malha_categoria_fundiaria USING btree (car);
CREATE INDEX proc5_malha_categoria_fundiaria_nm_agrup_idx ON irregularidades.proc5_malha_categoria_fundiaria USING btree (nm_agrup);


DROP TABLE irregularidades.temp_cat_fund;
CREATE TABLE irregularidades.temp_cat_fund AS 
SELECT original_gid, nm_agrup, am_legal, sum(area) area
FROM (SELECT gid, cd_grid, UNNEST(original_gid) original_gid, UNNEST(original_layer) original_layer, nm_agrup, am_legal , area 
FROM malhav2.proc6_malha d WHERE cd_grid IS NOT NULL AND am_legal) sub 
WHERE original_layer = 'CAR' 
GROUP BY original_gid , nm_agrup, am_legal;


CREATE INDEX temp_cat_fund_original_gid_idx ON irregularidades.temp_cat_fund USING btree (original_gid);
CREATE INDEX temp_cat_fund_nm_agrup_idx ON irregularidades.temp_cat_fund USING btree (nm_agrup);
CREATE INDEX temp_cat_fund_area_idx ON irregularidades.temp_cat_fund USING btree (area);



