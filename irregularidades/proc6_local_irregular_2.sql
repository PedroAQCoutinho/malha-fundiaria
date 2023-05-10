-- Para a car é preciso saber se ele está em local restritivo ou nao à regularizacao fundiaria
-- Para isso verificamos que pelo menos 10% da propriedade está em área restrita
-- Area restrita: nm_agrup = 'publica_afetada' OR nm_agrup = 'publica_afetada__imovel_rural_privado' OR nm_agrup = 'publica afetada_coletiva_privada' OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada'

INSERT INTO irregularidades.proc6_malha_local_restrito
SELECT  a.gid car, CASE
	WHEN m_fiscal <= 4 AND foo.area/a.area > 0.1 AND nm_agrup IS NOT NULL THEN TRUE
	WHEN m_fiscal > 4 AND m_fiscal <= 15 AND foo.area/a.area > 0.03 AND nm_agrup IS NOT NULL THEN TRUE
	WHEN m_fiscal > 15 AND foo.area/a.area > 0.01 AND nm_agrup IS NOT NULL THEN TRUE
	ELSE FALSE 
END is_local_restrito
FROM dados_brutos.valid_sicar_imovel a 
LEFT JOIN LATERAL
(SELECT * FROM irregularidades.temp_area_restrita tar WHERE tar.original_gid = a.gid) foo ON TRUE
WHERE (a.gid % :var_num_proc) = :var_proc;






