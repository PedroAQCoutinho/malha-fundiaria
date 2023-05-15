
CREATE TABLE irregularidadesv2.car_irregularidades
SELECT pico.id_car_original,
vsi.cod_imovel , 
vsi.area area_imovel,
vsi.m_fiscal ,
vsi.uf ,
vsi.municipio , 
vsi.cod_munici ,
pr.is_recente ,
pr.area_desmatamento_recente ,
pcaa.area_antropizada ,
pcto.is_grande ,
pccf.nm_agrup ,
pclr.is_local_restrito,
vsi.valid_geom geom FROM irregularidadesv2.proc7_id_car_original pico 
LEFT JOIN dados_brutos.valid_sicar_imovel vsi ON pico.id_car_original = vsi.gid 
LEFT JOIN irregularidadesv2.proc2_recente pr ON pico.id_car_original = pr.id_car_original 
LEFT JOIN irregularidadesv2.proc3_car_area_antropizada pcaa ON pico.id_car_original = pcaa.id_car_original 
LEFT JOIN irregularidadesv2.proc4_car_tamanho_ocupacao pcto ON pico.id_car_original = pcto.car 
LEFT JOIN irregularidadesv2.proc5_car_categoria_fundiaria pccf ON pico.id_car_original = pccf.car 
LEFT JOIN irregularidadesv2.proc6_car_local_restrito pclr ON pico.id_car_original = pclr.car 