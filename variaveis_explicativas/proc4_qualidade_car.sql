


DROP TABLE IF EXISTS variaveis_explicativas.proc4_qualidade_car;
CREATE TABLE variaveis_explicativas.proc4_qualidade_car (

id_car_original integer null, 
area_imovel decimal NULL,
m_fiscal integer NULL,
tipo_irregularidade text NULL,
qualidade_car text NULL

);

CREATE INDEX proc4_qualidade_car_id_car_original_idx ON variaveis_explicativas.proc4_qualidade_car USING btree (id_car_original);
CREATE INDEX proc4_qualidade_car_m_fiscal_idx ON variaveis_explicativas.proc4_qualidade_car USING btree (m_fiscal);
CREATE INDEX proc4_qualidade_car_tipo_irregularidade_idx ON variaveis_explicativas.proc4_qualidade_car USING btree (tipo_irregularidade);
CREATE INDEX proc4_qualidade_car_qualidade_car_idx ON variaveis_explicativas.proc4_qualidade_car USING btree (qualidade_car);





INSERT INTO variaveis_explicativas.proc4_qualidade_car
SELECT a.gid id_car_original, a.area area_imovel, m_fiscal, d.tipo_irregularidade ,
CASE 
	WHEN m_fiscal <= 4 AND 1-(area_poligono/a.area) > 0.1 THEN 'poor'
	WHEN m_fiscal > 4 AND m_fiscal <= 15 AND 1-(area_poligono/a.area) > 0.03 THEN 'poor'
	WHEN m_fiscal > 15 AND 1-(area_poligono/a.area)  > 0.01 THEN 'poor'
	WHEN area_poligono IS NULL THEN 'poor'	
	ELSE 'premium'
END car_qualidade
FROM dados_brutos.valid_sicar_imovel a
LEFT JOIN irregularidades.proc7_step14_categorizacao d ON a.gid = d.car 
LEFT JOIN LATERAL (
SELECT b.id_car_original , b.array_length , sum(b.area)/10000 area_poligono 
FROM car.proc4_unnest b 
WHERE b.id_car_original=a.gid AND array_length = 1 
GROUP BY id_car_original , array_length  ) c
ON TRUE



