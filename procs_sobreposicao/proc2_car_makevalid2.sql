DROP TABLE dados_brutos.valid_sicar_imovel;
CREATE TABLE dados_brutos.valid_sicar_imovel
(
gid serial4 NOT null,
gid_original int NULL,
cod_imovel TEXT NULL,
status_imo TEXT NULL, 
dat_criaca TEXT NULL,
area decimal NULL,
condicao TEXT NULL,
uf TEXT NULL,
municipio TEXT NULL,
cod_munici INT NULL,
m_fiscal INT NULL,
tipo_imove TEXT NULL,
valid_geom geometry NULL

);
CREATE SEQUENCE teams_id_seq;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_ac ; 

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_al ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_am ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_ap ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_ba ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_ce ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_df ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_es;


INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_go;


INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_ma;


INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_ms ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_mt  ;


INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_pa ;


INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_pb ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_pe ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_pi ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_pr ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_rj ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_rn ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_ro ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_rr ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_rs ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_sc ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_se ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_sp ;

INSERT INTO dados_brutos.valid_sicar_imovel (gid, gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove, valid_geom)
SELECT nextval('teams_id_seq') gid , gid gid_original, cod_imovel, status_imo, dat_criaca, area, condicao, uf, municipio, cod_munici, m_fiscal, tipo_imove,
ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imoveis_to ;





















