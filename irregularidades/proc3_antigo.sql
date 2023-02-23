DROP TABLE IF EXISTS irregularidades.proc3_step14_ano_ocupacao;
CREATE TABLE irregularidades.proc3_step14_ano_ocupacao AS 
SELECT car, min(desmatamento) ano, CASE 
	WHEN min(desmatamento) > 9 THEN TRUE
	ELSE FALSE
END is_recente
FROM irregularidades.proc2_step14_desmatamento_anual psar GROUP BY car