
\echo RUN :var_proc
INSERT INTO irregularidades.proc7_step14_categorizacao (car,  area_imovel, am_legal, cd_mun, cd_bioma, nm_agrup, nm_cat_fund, is_grande, is_recente, desmatamento, is_local_restrito, tipo_irregularidade, geom )
SELECT 
a.gid car, 
a.area area_imovel, 
am_legal, 
cd_mun, 
cd_bioma, 
d.nm_agrup, 
d.nm_cat_fund , 
is_grande, 
is_recente , 
desmatamento,  
is_local_restrito, 
CASE 
	WHEN tipo_imove = 'IRU' AND ( d.nm_agrup IN ('publica_afetada', 'glebas_publicas', 'vazio', 'publica afetada_coletiva_privada'))
 AND is_recente AND NOT is_grande AND NOT is_local_restrito AND am_legal  THEN 'A'
	WHEN tipo_imove = 'IRU' AND (  d.nm_agrup IN ('publica_afetada', 'glebas_publicas', 'vazio', 'publica afetada_coletiva_privada') )
 AND NOT is_recente AND NOT is_grande AND is_local_restrito AND am_legal  THEN 'B'
	WHEN tipo_imove = 'IRU' AND (  d.nm_agrup IN ('publica_afetada', 'glebas_publicas', 'vazio', 'publica afetada_coletiva_privada') )
 AND is_recente AND NOT is_grande AND is_local_restrito AND am_legal  THEN 'C'
	WHEN tipo_imove = 'IRU' AND (  d.nm_agrup IN ('publica_afetada', 'glebas_publicas', 'vazio', 'publica afetada_coletiva_privada') )
 AND NOT is_recente AND is_grande AND NOT is_local_restrito AND am_legal  THEN 'D'
	WHEN tipo_imove = 'IRU' AND (  d.nm_agrup IN ('publica_afetada', 'glebas_publicas', 'vazio', 'publica afetada_coletiva_privada'))
 AND NOT is_recente AND is_grande AND is_local_restrito AND am_legal  THEN 'E'
	WHEN tipo_imove = 'IRU' AND (  d.nm_agrup IN ('publica_afetada', 'glebas_publicas', 'vazio', 'publica afetada_coletiva_privada') )
 AND is_recente AND is_grande AND NOT is_local_restrito AND am_legal  THEN 'F'
	WHEN tipo_imove = 'IRU' AND (  d.nm_agrup IN ('publica_afetada', 'glebas_publicas', 'vazio', 'publica afetada_coletiva_privada'))
 AND is_recente AND is_grande AND is_local_restrito AND am_legal  THEN 'G'
	ELSE 'OSII'
END tipo_irregularidade, valid_geom geom
FROM dados_brutos.valid_sicar_imovel a
LEFT JOIN irregularidades.proc3_step14_ano_ocupacao b ON a.gid = b.gid
LEFT JOIN irregularidades.proc4_step14_tamanho_ocupacao c ON a.gid = c.car
LEFT JOIN irregularidades.proc5_step14_categoria_fundiaria d ON a.gid = d.car
LEFT JOIN irregularidades.proc6_step14_local_restrito e ON a.gid = e.car
LEFT JOIN LATERAL (SELECT * FROM irregularidades.proc23_step14_desmatamento_anual h 
WHERE h.car = a.gid ORDER BY h.area_count DESC LIMIT 1 ) foo
ON TRUE WHERE (a.gid % :var_num_proc) = :var_proc













