DROP TABLE IF EXISTS irregularidades.proc311_step14_car_area_interesse; 
CREATE TABLE irregularidades.proc311_step14_car_area_interesse as
SELECT car, sum(area_desmatamento) area_agrup , am_legal, nm_cat_fund, nm_agrup, avg(area) area 
FROM irregularidades.proc2_step14_desmatamento_anual psda 
LEFT JOIN dados_brutos.valid_sicar_imovel vsi 
ON psda.car = vsi.gid 
WHERE nm_agrup IN ('vazio', 'glebas_publicas', 'publica_afetada__imovel_rural_privado', 'publica_afetada', 'imovel_privado_coletivo_publica_destinada',
'publica_afetada_coletiva_privada') AND car IS NOT NULL 
GROUP BY nm_agrup, car, am_legal, nm_cat_fund , nm_agrup;

CREATE INDEX proc311_step14_car_area_interesse_car_idx ON irregularidades.proc311_step14_car_area_interesse USING btree (car);
CREATE INDEX proc311_step14_car_area_interesse_nm_cat_fund_idx ON irregularidades.proc311_step14_car_area_interesse USING btree (nm_cat_fund);
CREATE INDEX proc311_step14_car_area_interesse_area_idx ON irregularidades.proc311_step14_car_area_interesse USING btree (area);


DROP TABLE IF EXISTS irregularidades.proc312_step14_car_area_interesse; 
CREATE TABLE irregularidades.proc312_step14_car_area_interesse AS
SELECT *, (area_agrup+0.0001)/(area+0.0001) a, (area_agrup+0.0001)/(area+0.0001) > 0.01 is_relevante
FROM irregularidades.proc311_step14_car_area_interesse WHERE (area_agrup+0.0001)/(area+0.0001) > 0.01

CREATE INDEX proc312_step14_car_area_interesse_car_idx ON irregularidades.proc312_step14_car_area_interesse USING btree (car);
CREATE INDEX proc312_step14_car_area_interesse_nm_agrup_idx ON irregularidades.proc312_step14_car_area_interesse USING btree (nm_agrup);


DROP TABLE IF EXISTS irregularidades.proc313_step14_car_area_interesse; 
CREATE TABLE irregularidades.proc313_step14_car_area_interesse AS 
SELECT car, array_agg(nm_agrup) agrup , ARRAY_agg(a) area,
CASE 
	WHEN 'publica_afetada__imovel_rural_privado' = ANY(array_agg(nm_agrup)) OR 'publica_afetada' = ANY(array_agg(nm_agrup)) OR 'imovel_privado_coletivo_publica_destinada' = ANY(array_agg(nm_agrup))  OR 'publica_afetada_coletiva_privada' = ANY(array_agg(nm_agrup)) THEN 'PUBLICA_DESTINADA'
	WHEN 'vazio' = ANY(array_agg(nm_agrup)) AND NOT 'glebas_publicas' = ANY(array_agg(nm_agrup)) THEN 'VAZIO'
	WHEN 'glebas_publicas' = ANY(array_agg(nm_agrup)) AND NOT 'vazio' = ANY(array_agg(nm_agrup)) THEN 'GLEBA'
	WHEN 'glebas_publicas' = ANY(array_agg(nm_agrup)) AND 'vazio' = ANY(array_agg(nm_agrup)) THEN 'VG'
END a
FROM proc312_step14_car_area_interesse GROUP BY car ORDER BY a