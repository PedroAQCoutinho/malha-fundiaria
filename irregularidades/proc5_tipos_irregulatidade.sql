WITH foo AS (SELECT gid, flag, original_layer_label, cat_agrupada , area, tipo_imove,
CASE
	WHEN flag > 8 AND flag != 999 THEN TRUE
	ELSE FALSE 
END is_data_irregular,
CASE
	WHEN cat_agrupada IS NOT NULL THEN TRUE
	ELSE FALSE 
END is_ocupa_irregular,
CASE
	WHEN area > 2500 THEN TRUE
	ELSE FALSE 
END is_area_irregular
FROM dados_brutos.valid_sicar_imovel vsi 
LEFT JOIN irregularidades.step14_car_flag scf ON gid = scf.car
LEFT JOIN irregularidades.step14_car_ocupacao sco  ON gid = sco.car)
SELECT *, 
CASE 
	WHEN tipo_imove = 'IRU' AND is_data_irregular AND NOT is_area_irregular AND NOT is_ocupa_irregular THEN 'A'
	WHEN tipo_imove = 'IRU' AND NOT is_data_irregular AND NOT is_area_irregular AND is_ocupa_irregular THEN 'B'
	WHEN tipo_imove = 'IRU' AND is_data_irregular AND NOT is_area_irregular AND is_ocupa_irregular THEN 'C'
	WHEN tipo_imove = 'IRU' AND NOT is_data_irregular AND is_area_irregular AND NOT is_ocupa_irregular THEN 'D'
	WHEN tipo_imove = 'IRU' AND NOT is_data_irregular AND is_area_irregular AND is_ocupa_irregular THEN 'E'
	WHEN tipo_imove = 'IRU' AND is_data_irregular AND is_area_irregular AND NOT is_ocupa_irregular THEN 'F'
	WHEN tipo_imove = 'IRU' AND is_data_irregular AND is_area_irregular AND is_ocupa_irregular THEN 'G'
END tipo
FROM foo
WHERE is_area_irregular AND is_ocupa_irregular AND is_data_irregular