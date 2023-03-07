CREATE TABLE auxiliares.input_gid_ucus_apa AS 
WITH foo AS (SELECT gid gid_input, UNNEST(original_gid) origid, cd_layer FROM inputs.input_ucus_2022)
SELECT DISTINCT gid_input FROM foo
LEFT JOIN dados_brutos.valid_geoft_unidade_conservacao_ucus a 
ON origid = a.gid 
WHERE categori3 = 'Área de Proteção Ambiental'