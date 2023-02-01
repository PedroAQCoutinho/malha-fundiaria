DROP TABLE IF EXISTS irregularidades.step14_tipo_oii;
CREATE TABLE irregularidades.step14_tipo_oii AS 
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
FROM irregularidades.step14_car_join;



