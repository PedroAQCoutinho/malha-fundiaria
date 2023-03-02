DROP TABLE IF EXISTS irregularidades.proc3_step14_ano_ocupacao;
CREATE TABLE irregularidades.proc3_step14_ano_ocupacao AS 
DROP TABLE IF EXISTS irregularidades.proc3_step14_ano_ocupacao;
CREATE TABLE irregularidades.proc3_step14_ano_ocupacao AS 
SELECT gid, * FROM dados_brutos.valid_sicar_imovel vsi, LATERAL (
SELECT  *, CASE WHEN desmatamento > 2009 THEN TRUE ELSE FALSE end is_recente FROM irregularidades.proc2_step14_desmatamento_anual psda WHERE vsi.gid = psda.car ORDER BY desmatamento 
) foo 
WHERE (vsi.gid % :var_num_proc) = :var_proc