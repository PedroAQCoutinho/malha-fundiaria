
DROP TABLE irregularidadesv2.proc2_recente;
CREATE TABLE irregularidadesv2.proc2_recente AS 
SELECT id_car_original, sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN 0 WHEN desmatamento < 9 THEN area END) area_desmatamento_antigo,  
					    sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN area WHEN desmatamento < 9 THEN 0 END) area_desmatamento_recente,
CASE 
	WHEN sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN 0 WHEN desmatamento < 9 THEN area END) = 0 AND sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN area WHEN desmatamento < 9 THEN 0 END) = 0 THEN FALSE
	WHEN sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN 0 WHEN desmatamento < 9 THEN area END) = 0 AND sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN area WHEN desmatamento < 9 THEN 0 END) > 0 THEN TRUE
	WHEN sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN 0 WHEN desmatamento < 9 THEN area END) > 0 AND sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN area WHEN desmatamento < 9 THEN 0 END) > 0 THEN FALSE 
	WHEN sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN 0 WHEN desmatamento < 9 THEN area END) > 0 AND sum(CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento >= 9 THEN area WHEN desmatamento < 9 THEN 0 END) = 0 THEN FALSE
END is_recente 
FROM (
SELECT pc.cat_fund , pc.desmatamento , pc.uso, UNNEST(pm.original_layer) original_layer , UNNEST(pm.original_gid) id_car_original , 
pc.area
FROM irregularidadesv2.proc1_count pc 
LEFT JOIN malhav2.proc6_malha pm ON pc.cat_fund = pm.gid  
WHERE cat_fund IS NOT NULL AND pm.is_car
) foo WHERE original_layer = 'CAR' 
GROUP BY id_car_original


CREATE INDEX proc2_recente_id_car_original_idx ON irregularidadesv2.proc2_recente USING btree (id_car_original);
CREATE INDEX proc2_recente_area_desmatamento_recente_idx ON irregularidadesv2.proc2_recente USING btree (area_desmatamento_recente);
CREATE INDEX proc2_recente_area_desmatamento_antigo_idx ON irregularidadesv2.proc2_recente USING btree (area_desmatamento_antigo);
