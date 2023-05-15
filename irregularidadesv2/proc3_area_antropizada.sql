CREATE TABLE irregularidadesv2.proc3_car_area_antropizada AS 
SELECT id_car_original, sum(CASE WHEN uso IN (9,15,20,21,24,30,31,39,40,41,46,47,48,62) THEN area ELSE 0 END) area_antropizada FROM (
SELECT pc.cat_fund , pc.desmatamento , pc.uso, UNNEST(pm.original_layer) original_layer , UNNEST(pm.original_gid) id_car_original , 
pc.area
FROM irregularidadesv2.proc1_count pc 
LEFT JOIN malhav2.proc6_malha pm ON pc.cat_fund = pm.gid  
WHERE cat_fund IS NOT NULL) foo 
WHERE original_layer = 'CAR'  
GROUP BY id_car_original, uso 


CREATE INDEX proc3_car_area_antropizada_id_car_original_idx ON irregularidadesv2.proc3_car_area_antropizada USING btree (id_car_original);