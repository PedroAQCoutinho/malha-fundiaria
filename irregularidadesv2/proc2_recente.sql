DROP TABLE irregularidadesv2.proc2_recente;
CREATE TABLE irregularidadesv2.proc2_recente AS 
SELECT id_car_original, sum(CASE WHEN desmatamento >= 9 THEN area WHEN desmatamento IS NULL THEN 0 ELSE 0 END) area_desmatamento_recente,  
CASE WHEN sum(CASE WHEN desmatamento >= 9 THEN area WHEN desmatamento IS NULL THEN 0 ELSE 0 END) = 0 THEN FALSE ELSE TRUE END is_recente FROM (
SELECT pc.cat_fund , pc.desmatamento , pc.uso, UNNEST(pm.original_layer) original_layer , UNNEST(pm.original_gid) id_car_original , 
pc.area
FROM irregularidadesv2.proc1_count pc 
LEFT JOIN malhav2.proc6_malha pm ON pc.cat_fund = pm.gid  
WHERE cat_fund IS NOT NULL AND pm.is_car
) foo WHERE original_layer = 'CAR' 
GROUP BY id_car_original




CREATE INDEX proc2_recente_id_car_original_idx ON irregularidadesv2.proc2_recente USING btree (id_car_original);