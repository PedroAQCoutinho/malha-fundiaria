DROP TABLE IF EXISTS irregularidades.proc3_step14_ano_ocupacao;
CREATE TABLE irregularidades.proc3_step14_ano_ocupacao AS 
SELECT gid, desmatamento, is_recente
FROM dados_brutos.valid_sicar_imovel a, LATERAL 
(SELECT *, CASE 
	WHEN desmatamento > 2009 THEN TRUE 
	ELSE FALSE 
END is_recente FROM irregularidades.proc2_step14_desmatamento_anual b 
WHERE a.gid = b.car AND gid = 379000 ORDER BY desmatamento LIMIT 1) foo
WHERE (a.gid % :var_num_proc) = :var_proc