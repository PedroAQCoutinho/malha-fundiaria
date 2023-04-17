DROP TABLE workshop.proc1_contingencia1;
CREATE TABLE workshop.proc1_contingencia1 AS 
SELECT *, CASE 
	WHEN tipo = '{OSII}' THEN 'OSII'
	WHEN tipo = '{OCII}' THEN 'OCII'
	ELSE 'OCII'
END tipo_irregularidade FROM irregularidades.proc1_step14_area_raw a
LEFT JOIN LATERAL (SELECT id_car_break, anyarray_sort(anyarray_uniq(array_agg(CASE WHEN tipo_irregularidade = 'OSII' THEN 'OSII'ELSE 'OCII' END))) tipo
FROM car.proc3_id_key pik 
LEFT JOIN irregularidades.proc7_step14_categorizacao psc ON psc.car = pik.id_car_original 
WHERE am_legal AND a.car = pik.id_car_break
GROUP BY id_car_break) foo ON TRUE 

CREATE INDEX proc1_contingencia1_car_idx ON workshop.proc1_contingencia1 USING btree (car);
CREATE INDEX proc1_contingencia1_desmatamento_idx ON workshop.proc1_contingencia1 USING btree (desmatamento);
CREATE INDEX proc1_contingencia1_id_car_break_idx ON workshop.proc1_contingencia1 USING btree (id_car_break);


CREATE TABLE workshop.proc11_contingencia1 AS 
SELECT car, desmatamento, tipo_irregularidade , sum(count) count 
FROM workshop.proc1_contingencia1 
GROUP BY car, desmatamento, tipo_irregularidade



DROP TABLE workshop.proc2_contingencia1;
CREATE TABLE workshop.proc2_contingencia1 AS 
SELECT psc.car , psc.am_legal , psc.cd_mun ,
psc.nm_agrup , psc.nm_cat_fund , tipo_irregularidade, area_imovel, is_older_2008, area_pos_2008 , area_desmatamento_total 
FROM irregularidades.proc7_step14_categorizacao psc 
LEFT JOIN LATERAL (
SELECT car,  CASE WHEN ano > 8 THEN TRUE ELSE FALSE END is_older_2008 , sum(area_count) area_pos_2008
FROM irregularidades.proc23_step14_desmatamento_anual psda 
WHERE psda.car = psc.car AND ano != 0 
GROUP BY car, CASE WHEN ano > 8 THEN TRUE ELSE FALSE END
) foo ON TRUE 
LEFT JOIN LATERAL (
SELECT car, sum(area_count) area_desmatamento_total
FROM irregularidades.proc23_step14_desmatamento_anual psda 
WHERE psda.ano != 0 AND psda.car = psc.car 
GROUP BY car
) foo1 ON TRUE 
WHERE am_legal






SELECT tipo_irregularidade, CASE WHEN desmatamento > 8 THEN TRUE ELSE FALSE END is_2008_recente , sum(count)*0.087 area
FROM workshop.proc1_contingencia1 pc 
WHERE desmatamento != 0 
GROUP BY tipo_irregularidade , CASE WHEN desmatamento > 8 THEN TRUE ELSE FALSE END



SELECT CASE 
	WHEN tipo_irregularidade = 'OSII' THEN 'OSII'
	ELSE 'OCII'
END, count(*) numero, sum(area_imovel) area_imoveis FROM workshop.proc2_contingencia1 a
GROUP BY CASE 
	WHEN tipo_irregularidade = 'OSII' THEN 'OSII'
	ELSE 'OCII'
END 
