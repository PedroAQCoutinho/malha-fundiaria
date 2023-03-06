-- Para a car é preciso saber se ele está em local restritivo ou nao à regularizacao fundiaria
-- Para isso verificamos que pelo menos 10% da propriedade está em área restrita
-- Area restrita: nm_agrup = 'publica_afetada' OR nm_agrup = 'publica_afetada__imovel_rural_privado' OR nm_agrup = 'publica afetada_coletiva_privada' OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada'
DROP TABLE IF EXISTS irregularidades.proc6_step14_local_restrito;
CREATE TABLE irregularidades.proc6_step14_local_restrito (

car int null, 
is_local_restrito boolean null

);


CREATE INDEX proc6_step14_local_restrito_car_idx ON irregularidades.proc6_step14_local_restrito USING btree (car);


INSERT INTO irregularidades.proc6_step14_local_restrito
SELECT  a.gid, 
CASE
	WHEN area_desmatamento/area > 0.1 THEN TRUE
	ELSE FALSE 
END is_local_restrito
FROM dados_brutos.valid_sicar_imovel a LEFT JOIN LATERAL
(SELECT *
FROM irregularidades.proc2_step14_desmatamento_anual b
WHERE a.gid = b.car AND 
(nm_agrup = 'publica_afetada' OR nm_agrup = 'publica_afetada__imovel_rural_privado' OR nm_agrup = 'publica afetada_coletiva_privada' OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada')
ORDER BY area_desmatamento DESC
LIMIT 1) foo ON TRUE 


