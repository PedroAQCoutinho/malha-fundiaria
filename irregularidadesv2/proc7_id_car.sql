CREATE TABLE irregularidadesv2.proc7_id_car_original AS 
SELECT id_car_original, FROM (
SELECT pc.cat_fund , pc.desmatamento , pc.uso, UNNEST(pm.original_layer) original_layer , UNNEST(pm.original_gid) id_car_original , 
pc.area
FROM irregularidadesv2.proc1_count pc 
LEFT JOIN malhav2.proc6_malha pm ON pc.cat_fund = pm.gid  
WHERE cat_fund IS NOT NULL
) foo WHERE original_layer = 'CAR'

CREATE INDEX proc7_id_car_original_id_car_original_idx ON irregularidadesv2.proc7_id_car_original USING btree (id_car_original);


