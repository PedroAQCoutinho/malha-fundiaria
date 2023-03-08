\echo RUN :var_proc

INSERT INTO irregularidades.proc6_step14_local_restrito
SELECT  a.gid, 
CASE
	WHEN area_desmatamento/area > 0.1 THEN TRUE
	ELSE FALSE 
END is_local_restrito
FROM dados_brutos.valid_sicar_imovel a LEFT JOIN LATERAL
(SELECT *
FROM irregularidades.proc23_step14_desmatamento_anual b
WHERE a.gid = b.car AND 
(nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado')
ORDER BY area_desmatamento DESC
LIMIT 1) foo ON TRUE