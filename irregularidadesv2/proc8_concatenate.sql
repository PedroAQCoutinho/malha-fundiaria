

DROP TABLE irregularidadesv2.car_irregularidades;
CREATE TABLE irregularidadesv2.car_irregularidades AS
SELECT pico.id_car_original,
vsi.cod_imovel , 
vsi.area area_imovel,
vsi.m_fiscal ,
vsi.uf ,
vsi.municipio , 
vsi.cod_munici ,
pr.is_recente ,
pr.area_desmatamento_recente ,
pr.area_desmatamento_antigo ,
pcaa.area_antropizada ,
case when vsi.area >= 2500 then TRUE else FALSE end is_grande ,
pccf.nm_agrup ,
pclr.is_local_restrito,
vsi.valid_geom geom FROM irregularidadesv2.proc7_id_car_original pico 
LEFT JOIN dados_brutos.valid_sicar_imovel vsi ON pico.id_car_original = vsi.gid 
LEFT JOIN irregularidadesv2.proc2_recente pr ON pico.id_car_original = pr.id_car_original 
LEFT JOIN irregularidadesv2.proc3_car_area_antropizada pcaa ON pico.id_car_original = pcaa.id_car_original 
LEFT JOIN irregularidadesv2.proc5_car_categoria_fundiaria pccf ON pico.id_car_original = pccf.car 
LEFT JOIN irregularidadesv2.proc6_car_local_restrito pclr ON pico.id_car_original = pclr.car;


CREATE INDEX car_irregularidades_geom_idx ON irregularidadesv2.car_irregularidades USING gist (geom);
CREATE INDEX car_irregularidades_id_car_original_idx ON irregularidadesv2.car_irregularidades USING btree (id_car_original);