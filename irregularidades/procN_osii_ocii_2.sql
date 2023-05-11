
\echo RUN :var_proc
CREATE TABLE irregularidades.proc7_car_categorizacao as 
SELECT a.gid, a.uf , a.municipio , a.tipo_imove , a.m_fiscal,
a.area area_imovel, c.area area_imovel_check, b.desmatamento ano_ocupacao, b.is_recente,
c.is_grande, d.nm_agrup , e.is_local_restrito , foo.area_antropizada
FROM dados_brutos.valid_sicar_imovel a
LEFT JOIN irregularidades.proc3_malha_ano_ocupacao b ON a.gid = b.gid 
LEFT JOIN irregularidades.proc4_malha_tamanho_ocupacao c ON a.gid = c.car 
LEFT JOIN irregularidades.proc5_malha_categoria_fundiaria d ON a.gid = d.car 
LEFT JOIN irregularidades.proc6_malha_local_restrito e ON a.gid = e.car 
LEFT JOIN (SELECT car, sum(pmua.area_count) area_antropizada FROM irregularidades.proc23_malha_uso_anual pmua 
WHERE  pmua.uso IN (9,15,20,21,24,30,31,39,40,41,46,47,48,62) 
GROUP BY pmua.car ) foo ON foo.car = a.gid






CREATE INDEX proc7_car_categorizacao_gid_idx ON irregularidades.proc7_car_categorizacao USING btree (gid);
CREATE INDEX proc7_car_categorizacao_cd_mun_idx ON irregularidades.proc7_car_categorizacao USING btree (cd_mun);
CREATE INDEX proc7_car_categorizacao_cd_bioma_idx ON irregularidades.proc7_car_categorizacao USING btree (cd_bioma);
CREATE INDEX proc7_car_categorizacao_original_layer_label_idx ON irregularidades.proc7_car_categorizacao USING btree (original_layer_label);
CREATE INDEX proc7_car_categorizacao_nm_agrup_idx ON irregularidades.proc7_car_categorizacao USING btree (nm_agrup);
CREATE INDEX proc7_car_categorizacao_nm_cat_fund_idx ON irregularidades.proc7_car_categorizacao USING btree (nm_cat_fund);
CREATE INDEX proc7_car_categorizacao_geom_idx ON irregularidades.proc7_car_categorizacao USING GIST (geom);




