-- Para a tabela proc2_step14_desmatamento_anual, temos varios registros com o mesmo car.
-- Caada registro tem um área de sobreposição. Esses registros podem ser agrupados por cat_fund, ou seja, a area total de cada cat_fund no car, agrupado pela nm_cat_fund
-- Com uma tbaela de tres colunas (car, cat_fund e area) é possivel resgatar a coluna area_car, fazer a proporcao area/area_car e filtrar para > 0.1
-- Onde as cat_fund forem maiores do que 10%, pegar a maior que indica a area predominante e classifica a propriedade.
\echo cat fund :var_proc

INSERT INTO irregularidadesv2.proc5_car_categoria_fundiaria
SELECT a.gid , foo.nm_agrup FROM dados_brutos.valid_sicar_imovel a 
LEFT JOIN LATERAL
(SELECT * FROM irregularidadesv2.temp_cat_fund tcf WHERE tcf.original_gid = a.gid ORDER BY original_gid, area DESC LIMIT 1) foo ON TRUE 
WHERE nm_agrup IS NOT NULL AND (a.gid % :var_num_proc) = :var_proc;

