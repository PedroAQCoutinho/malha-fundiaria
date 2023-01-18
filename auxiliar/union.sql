DROP TABLE IF EXISTS dados_brutos.sicar_imovel;
CREATE TABLE dados_brutos.sicar_imovel AS 
SELECT * FROM dados_brutos.sicar_imoveis_ac UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_al UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_am UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_ap UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_ba UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_ce UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_df UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_es UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_go UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_ma UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_mg UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_ms UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_mt UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_pa UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_pb UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_pi UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_pr UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_rj UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_rn UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_ro UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_rr UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_rs UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_sc UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_se UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_sp UNION ALL 
SELECT * FROM dados_brutos.sicar_imoveis_to;


CREATE INDEX sicar_imovel_gid_idx ON dados_brutos.sicar_imovel USING btree (gid);
CREATE INDEX sicar_imovel_geom_idx ON dados_brutos.sicar_imovel USING gist (geom);