WITH foo AS (SELECT car, sum(area_desmatamento) area_contada, avg(area) area_imovel,
CASE 
	WHEN sum(area_desmatamento)/avg(area) < 0.05 THEN '0 - 5'
	WHEN sum(area_desmatamento)/avg(area) >= 0.05 AND sum(area_desmatamento)/avg(area) < 0.2 THEN '5 - 20'
	WHEN sum(area_desmatamento)/avg(area) >= 0.2 AND sum(area_desmatamento)/avg(area) < 0.5 THEN '20 - 50'
	WHEN sum(area_desmatamento)/avg(area) >= 0.5 AND sum(area_desmatamento)/avg(area) < 0.7 THEN '50 - 70'
	WHEN sum(area_desmatamento)/avg(area) >= 0.7 THEN '70 - 100'
END nivel_descarac
FROM irregularidades.proc2_step14_desmatamento_anual psda 
LEFT JOIN dados_brutos.valid_sicar_imovel b ON gid = car 
WHERE area > 0
GROUP BY car)
SELECT nivel_descarac, count(*) contagem, sum(area_imovel), sum(area_contada) FROM foo GROUP BY nivel_descarac