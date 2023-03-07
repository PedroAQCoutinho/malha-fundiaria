INSERT INTO irregularidades.proc3_step14_ano_ocupacao (gid, desmatamento, is_recente)
SELECT gid, desmatamento, is_recente
FROM dados_brutos.valid_sicar_imovel a, LATERAL 
(SELECT *, CASE 
	WHEN desmatamento > 9 THEN TRUE 
	ELSE FALSE 
END is_recente FROM irregularidades.proc2_step14_desmatamento_anual b 
WHERE a.gid = b.car  ORDER BY desmatamento LIMIT 1) foo
WHERE (a.gid % :var_num_proc) = :var_proc