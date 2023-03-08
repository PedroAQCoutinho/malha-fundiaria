-- Para a car é preciso saber se ele está em local restritivo ou nao à regularizacao fundiaria
-- Para isso verificamos que pelo menos 10% da propriedade está em área restrita
-- Area restrita: nm_agrup = 'publica_afetada' OR nm_agrup = 'publica_afetada__imovel_rural_privado' OR nm_agrup = 'publica afetada_coletiva_privada' OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada'
\echo RUN :var_proc
INSERT INTO irregularidades.proc6_step14_local_restrito
SELECT  a.gid car , 
CASE
	WHEN m_fiscal <= 4 AND area_count/area > 0.1 THEN TRUE
	WHEN m_fiscal > 4 AND m_fiscal <= 15 AND area_count/area > 0.03 THEN TRUE
	WHEN m_fiscal > 15 AND area_count/area > 0.01 THEN TRUE
	ELSE FALSE 
END is_local_restrito, area area_imovel, m_fiscal, cat_fund cat_fund_irregular, orilabel original_layer_label_irregular, 
nm_cat_fund nm_cat_fund_irregular, nm_agrup nm_agrup_irregular
FROM dados_brutos.valid_sicar_imovel a LEFT JOIN LATERAL
(SELECT *
FROM irregularidades.proc23_step14_desmatamento_anual b
WHERE a.gid = b.car AND 
(nm_agrup = 'publica_afetada' OR nm_agrup = 'publica afetada_coletiva_privada')
ORDER BY area_count DESC
LIMIT 1) foo ON TRUE WHERE (a.gid % :var_num_proc) = :var_proc


