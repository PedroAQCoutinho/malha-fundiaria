DROP TABLE IF EXISTS irregularidadesv2.proc4_car_tamanho_ocupacao;
CREATE TABLE irregularidades.proc4_car_tamanho_ocupacao AS 
SELECT origid car, 
CASE 
	WHEN sum(area) > 2500 THEN TRUE
	ELSE FALSE 
END is_grande
FROM (SELECT unnest(original_gid) origid, UNNEST(original_layer) orilay , area FROM malhav2.proc6_malha pm) foo
WHERE orilay = 'CAR'
GROUP BY origid

CREATE INDEX proc4_car_tamanho_ocupacao_car_idx ON irregularidadesv2.proc4_car_tamanho_ocupacao USING btree (car);