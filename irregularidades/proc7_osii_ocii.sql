DROP TABLE IF EXISTS irregularidades.proc8_tipo_osii_ocii;
CREATE TABLE irregularidades.proc8_tipo_osii_ocii AS 
SELECT car, 
am_legal, 
cd_bioma, 
cd_mun, 
tipo_imove, 
nm_agrup agrupamento_fundiario, 
area_sobrep,
area_imovel, 
is_ocupacao_irregular, 
is_grande, 
is_recente, 
ano ano_ocupacao, CASE 
	WHEN tipo_imove = 'IRU' AND is_recente AND NOT is_grande AND NOT is_ocupacao_irregular AND am_legal  THEN 'A'
	WHEN tipo_imove = 'IRU' AND NOT is_recente AND NOT is_grande AND is_ocupacao_irregular AND am_legal  THEN 'B'
	WHEN tipo_imove = 'IRU' AND is_recente AND NOT is_grande AND is_ocupacao_irregular AND am_legal  THEN 'C'
	WHEN tipo_imove = 'IRU' AND NOT is_recente AND is_grande AND NOT is_ocupacao_irregular AND am_legal  THEN 'D'
	WHEN tipo_imove = 'IRU' AND NOT is_recente AND is_grande AND is_ocupacao_irregular AND am_legal  THEN 'E'
	WHEN tipo_imove = 'IRU' AND is_recente AND is_grande AND NOT is_ocupacao_irregular AND am_legal  THEN 'F'
	WHEN tipo_imove = 'IRU' AND is_recente AND is_grande AND is_ocupacao_irregular AND am_legal  THEN 'G'
	ELSE 'OSII'
END tipo, a.geom
FROM irregularidades.proc63_step14_cat_fund a
LEFT JOIN irregularidades.proc62_step14_cat_fund b USING(car)
LEFT JOIN irregularidades.proc5_ocupacao_irregular c  USING(car)
LEFT JOIN irregularidades.proc4_step14_tamanho_ocupacao d using(car)
LEFT JOIN irregularidades.proc3_step14_ano_ocupacao e using(car)
LEFT JOIN geo_adm.pa_br_limitebiomas_250_2006_ibge_4674 f USING(cd_bioma)
WHERE nm_agrup IS NOT null


CREATE INDEX proc8_tipo_osii_ocii_car_idx ON irregularidades.proc8_tipo_osii_ocii USING btree (car);
CREATE INDEX proc8_tipo_osii_ocii_geom_idx ON irregularidades.proc8_tipo_osii_ocii USING gist (geom);
CREATE INDEX proc8_tipo_osii_ocii_agrupamento_fundiario_idx ON irregularidades.proc8_tipo_osii_ocii USING btree (agrupamento_fundiario);