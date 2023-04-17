DROP TABLE inputs.proc1_ucpi_ucus_ti_ocii;
CREATE TABLE inputs.proc1_ucpi_ucus_ti_ocii AS 
WITH foo AS (SELECT a.gid gid_ucpi, nome_uc1 , nome_org12 , a.valid_geom geom FROM dados_brutos.valid_geoft_unidade_conservacao_ucpi a
LEFT JOIN geo_adm.pa_br_amazonia_legal_ibge_250_4674 b ON ST_Intersects(a.valid_geom, b.geom)
WHERE b.gid IS NOT NULL )
SELECT 'UCPI' tipo, nome_uc1 nome , nome_org12 obs ,count(*) n_sobreposicoes,  
ST_Area(ST_INtersection(ST_Union(foo.geom) , ST_Union(c.geom))::geography)/10000 area_sobreposicao_ha, 
ST_Area(ST_Union(foo.geom)::geography)/10000 area_unidade,
((ST_Area(ST_INtersection(ST_Union(foo.geom) , ST_Union(c.geom))::geography)/10000)/(ST_Area(ST_Union(foo.geom)::geography)/10000))*100 parea,
ST_Union(foo.geom) geom FROM foo 
LEFT JOIN irregularidades.proc7_step14_categorizacao c ON ST_Intersects(foo.geom, c.geom)
WHERE c.tipo_irregularidade != 'OSII'
GROUP BY gid_ucpi, nome_uc1 , nome_org12
UNION ALL
(WITH foo AS (SELECT a.gid gid_ucpi, nome_uc1 , nome_org12 , a.valid_geom geom FROM dados_brutos.valid_geoft_unidade_conservacao_ucus a
LEFT JOIN geo_adm.pa_br_amazonia_legal_ibge_250_4674 b ON ST_Intersects(a.valid_geom, b.geom)
WHERE b.gid IS NOT NULL AND categori3 != 'Área de Proteção Ambiental')
SELECT 'UCUS' tipo, nome_uc1 nome, nome_org12 obs,  count(*) n_sobreposicoes,  
ST_Area(ST_INtersection(ST_Union(foo.geom) , ST_Union(c.geom))::geography)/10000 area_sobreposicao_ha, 
ST_Area(ST_Union(foo.geom)::geography)/10000 area_unidade,
((ST_Area(ST_INtersection(ST_Union(foo.geom) , ST_Union(c.geom))::geography)/10000)/(ST_Area(ST_Union(foo.geom)::geography)/10000))*100 parea,
ST_Union(foo.geom) geom FROM foo 
LEFT JOIN irregularidades.proc7_step14_categorizacao c ON ST_Intersects(foo.geom, c.geom)
WHERE c.tipo_irregularidade != 'OSII'
GROUP BY gid_ucpi, nome_uc1 , nome_org12)
UNION ALL 
(WITH foo AS (SELECT * FROM dados_brutos.valid_geoft_terra_indigena a
LEFT JOIN geo_adm.pa_br_amazonia_legal_ibge_250_4674 b ON ST_Intersects(a.valid_geom, b.geom)
WHERE b.gid IS NOT NULL )
SELECT 'TI' tipo, terrai_nom , fase_ti obs, count(*) n_sobreposicoes,  
ST_Area(ST_INtersection(ST_Union(foo.valid_geom) , ST_Union(c.geom))::geography)/10000 area_sobreposicao_ha, 
ST_Area(ST_Union(foo.valid_geom)::geography)/10000 area_unidade,
((ST_Area(ST_INtersection(ST_Union(foo.valid_geom) , ST_Union(c.geom))::geography)/10000)/(ST_Area(ST_Union(foo.valid_geom)::geography)/10000))*100 parea,
ST_Union(foo.valid_geom) geom FROM foo 
LEFT JOIN irregularidades.proc7_step14_categorizacao c ON ST_Intersects(foo.valid_geom, c.geom)
WHERE c.tipo_irregularidade != 'OSII'
GROUP BY foo.__gid, terrai_nom , fase_ti)
































