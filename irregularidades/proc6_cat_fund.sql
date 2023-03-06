-- Para a tabela proc2_step14_desmatamento_anual, temos varios registros com o mesmo car.
-- Caada registro tem um área de sobreposição. Esses registros podem ser agrupados por cat_fund, ou seja, a area total de cada cat_fund no car, agrupado pela nm_cat_fund
-- Com uma tbaela de tres colunas (car, cat_fund e area) é possivel resgatar a coluna area_car, fazer a proporcao area/area_car e filtrar para > 0.1
-- Onde as cat_fund forem maiores do que 10%, pegar a maior que indica a area predominante e classifica a propriedade.


SELECT a.gid, foo.car, original_layer_label  FROM dados_brutos.valid_sicar_imovel a , LATERAL
(SELECT car, original_layer_label, sum(area_desmatamento) area_desmatamento, avg(c.area) area
FROM irregularidades.proc2_step14_desmatamento_anual b
LEFT JOIN dados_brutos.valid_sicar_imovel c ON gid = car
WHERE a.gid = b.car
GROUP BY car, original_layer_label 
HAVING sum(area_desmatamento)/avg(c.area)  > 0.1
ORDER BY sum(area_desmatamento) DESC
LIMIT 1) foo


SELECT * FROM irregularidades.proc2_step14_desmatamento_anual psda WHERE car  = 22

SELECT * FROM layer_fundiario.step14_id_label sil 	WHERE gid = 91032 OR gid = 91068