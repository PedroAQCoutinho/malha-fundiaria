CREATE TABLE irregularidades.proc5_ocupacao_irregular AS 
WITH foo AS (SELECT car, nm_agrup, CASE 
	WHEN nm_agrup = 'publica_afetada' OR nm_agrup = 'publica_afetada__imovel_rural_privado' OR nm_agrup = 'publica afetada_coletiva_privada' OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada' THEN 2
	ELSE 1
END is_ocupacao_irregular, sum(area_desmatamento) area_desmatamento, avg(area) area , sum(area_desmatamento)/avg(area) p
FROM irregularidades.proc61_step14_cat_fund a 
GROUP BY car, nm_agrup HAVING avg(area) > 0 AND sum(area_desmatamento)/avg(area) > 0.01)
SELECT car, CASE 
	WHEN max(is_ocupacao_irregular) = 1 THEN FALSE
	WHEN max(is_ocupacao_irregular) = 2 THEN TRUE
	ELSE NULL
END is_ocupacao_irregular
FROM foo GROUP BY car


CREATE INDEX proc5_ocupacao_irregular_car_idx ON irregularidades.proc5_ocupacao_irregular USING btree (car);


