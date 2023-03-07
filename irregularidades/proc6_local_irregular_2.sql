-- Para a car é preciso saber se ele está em local restritivo ou nao à regularizacao fundiaria
-- Para isso verificamos que pelo menos 10% da propriedade está em área restrita
-- Area restrita: nm_agrup = 'publica_afetada' OR nm_agrup = 'publica_afetada__imovel_rural_privado' OR nm_agrup = 'publica afetada_coletiva_privada' OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada'

INSERT INTO irregularidades.proc6_step14_local_restrito
SELECT  a.gid car , 
CASE
	WHEN m_fiscal <= 4 AND area_desmatamento/area > 0.1 THEN TRUE
	WHEN m_fiscal > 4 AND m_fiscal <= 15 AND area_desmatamento/area > 0.03 THEN TRUE
	WHEN m_fiscal > 15 AND area_desmatamento/area > 0.01 THEN TRUE
	ELSE FALSE 
END is_local_restrito, area area_imovel, m_fiscal, cat_fund cat_fund_irregular, original_layer_label original_layer_label_irregular, nm_cat_fund nm_cat_fund_irregular, nm_agrup nm_agrup_irregular
FROM dados_brutos.valid_sicar_imovel a LEFT JOIN LATERAL
(SELECT *
FROM irregularidades.proc2_step14_desmatamento_anual b
WHERE a.gid = b.car AND 
(nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado')
ORDER BY area_desmatamento DESC
LIMIT 1) foo ON TRUE WHERE and (a.gid % :var_num_proc) = :var_proc

