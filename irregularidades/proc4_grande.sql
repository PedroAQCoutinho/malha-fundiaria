DROP TABLE IF EXISTS irregularidades.proc4_step14_tamanho_ocupacao;
CREATE TABLE irregularidades.proc4_step14_tamanho_ocupacao AS 
SELECT gid car, area, CASE 
	WHEN area > 2500 THEN TRUE 
	ELSE false
END is_grande
FROM dados_brutos.valid_sicar_imovel vsi 