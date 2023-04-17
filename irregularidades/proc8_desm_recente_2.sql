\echo RUN :var_proc

INSERT INTO irregularidades.proc8_step14_desmatamento_recente (gid, desmatamento, is_desm_recente)
SELECT gid, ano, is_desm_recente
FROM dados_brutos.valid_sicar_imovel a, LATERAL 
(SELECT *, CASE 
	WHEN ano >= 8 THEN TRUE 
	ELSE FALSE 
END is_desm_recente FROM irregularidades.proc23_step14_desmatamento_anual b 
WHERE a.gid = b.car AND ano != 0  ORDER BY gid_car, ano DESC LIMIT 1) foo
WHERE (a.gid % :var_num_proc) = :var_proc