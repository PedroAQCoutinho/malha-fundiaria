DROP TABLE IF EXISTS irregularidades.proc7_step14_categorizacao;
CREATE TABLE irregularidades.proc7_step14_categorizacao
(
car int null,  
area_imovel decimal NULL , 
am_legal boolean NULL , 
cd_mun int null, 
cd_bioma int null, 
original_layer_label TEXT[] null, 
nm_agrup TEXT NULL , 
nm_cat_fund TEXT NULL , 
is_grande boolean NULL , 
is_recente boolean NULL , 
is_local_restrito boolean NULL , 
tipo_irregularidade TEXT NULL , 
geom  geometry null

)

CREATE INDEX proc7_step14_categorizacao_car_idx ON irregularidades.proc7_step14_categorizacao USING btree (car);
CREATE INDEX proc7_step14_categorizacao_cd_mun_idx ON irregularidades.proc7_step14_categorizacao USING btree (cd_mun);
CREATE INDEX proc7_step14_categorizacao_cd_bioma_idx ON irregularidades.proc7_step14_categorizacao USING btree (cd_bioma);
CREATE INDEX proc7_step14_categorizacao_original_layer_label_idx ON irregularidades.proc7_step14_categorizacao USING btree (original_layer_label);
CREATE INDEX proc7_step14_categorizacao_nm_agrup_idx ON irregularidades.proc7_step14_categorizacao USING btree (nm_agrup);
CREATE INDEX proc7_step14_categorizacao_nm_cat_fund_idx ON irregularidades.proc7_step14_categorizacao USING btree (nm_cat_fund);
CREATE INDEX proc7_step14_categorizacao_geom_idx ON irregularidades.proc7_step14_categorizacao USING GIST (geom);


INSERT INTO irregularidades.proc7_step14_categorizacao (car,  area_imovel, am_legal, cd_mun, cd_bioma, original_layer_label, nm_agrup, nm_cat_fund, is_grande, is_recente, is_local_restrito, tipo_irregularidade, geom )
SELECT a.gid car, a.area area_imovel, am_legal, cd_mun, cd_bioma, original_layer_label, nm_agrup, nm_cat_fund , is_grande, is_recente , is_local_restrito, CASE 
	WHEN tipo_imove = 'IRU' AND (nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado')
 AND is_recente AND NOT is_grande AND NOT is_local_restrito AND am_legal  THEN 'A'
	WHEN tipo_imove = 'IRU' AND ( nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado' )
 AND NOT is_recente AND NOT is_grande AND is_local_restrito AND am_legal  THEN 'B'
	WHEN tipo_imove = 'IRU' AND ( nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado' )
 AND is_recente AND NOT is_grande AND is_local_restrito AND am_legal  THEN 'C'
	WHEN tipo_imove = 'IRU' AND ( nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado' )
 AND NOT is_recente AND is_grande AND NOT is_local_restrito AND am_legal  THEN 'D'
	WHEN tipo_imove = 'IRU' AND ( nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado')
 AND NOT is_recente AND is_grande AND is_local_restrito AND am_legal  THEN 'E'
	WHEN tipo_imove = 'IRU' AND ( nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado' )
 AND is_recente AND is_grande AND NOT is_local_restrito AND am_legal  THEN 'F'
	WHEN tipo_imove = 'IRU' AND ( nm_agrup <> ' coletiva_privada' or nm_agrup <> 'imovel_rural_privado' or nm_agrup <> 'coletiva_privada_imovel_privado' )
 AND is_recente AND is_grande AND is_local_restrito AND am_legal  THEN 'G'
	ELSE 'OSII'
END tipo_irregularidade, valid_geom geom
FROM dados_brutos.valid_sicar_imovel a
LEFT JOIN irregularidades.proc3_step14_ano_ocupacao b ON a.gid = b.gid
LEFT JOIN irregularidades.proc4_step14_tamanho_ocupacao c ON a.gid = c.car
LEFT JOIN irregularidades.proc5_step14_categoria_fundiaria d ON a.gid = d.car
LEFT JOIN irregularidades.proc6_step14_local_restrito e ON a.gid = e.car
LEFT JOIN auxiliares.step14_chave_geral f USING(original_layer_label)
LEFT JOIN auxiliares.step14_chave_agrupamento g USING (id_agrup)
LEFT JOIN auxiliares.step14_chave_categorias_limpas h USING (id_cat_fund)
LEFT JOIN LATERAL (
SELECT car, am_legal, cd_mun, cd_bioma FROM irregularidades.proc2_step14_desmatamento_anual psda WHERE a.gid = psda.car ORDER BY area_desmatamento DESC 
LIMIT 1) foo
ON TRUE
