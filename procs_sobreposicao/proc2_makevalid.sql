
--SNCI publico
\echo imovel_certificado_snci_publico
\echo
DROP TABLE IF EXISTS dados_brutos.valid_imovel_certificado_snci_publico;
CREATE TABLE dados_brutos.valid_imovel_certificado_snci_publico AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.imovel_certificado_snci_publico icsp  ;

CREATE INDEX valid_imovel_certificado_snci_publico_gid_idx ON dados_brutos.valid_imovel_certificado_snci_publico USING btree (gid);
CREATE INDEX valid_imovel_certificado_snci_publico_geom_idx ON dados_brutos.valid_imovel_certificado_snci_publico USING gist (geom);





--Quilombolas
\echo areas_de_quilombolas
\echo  
DROP TABLE IF EXISTS dados_brutos.valid_areas_de_quilombolas;
CREATE TABLE dados_brutos.valid_areas_de_quilombolas AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.areas_de_quilombolas; 

CREATE INDEX valid_areas_de_quilombolas_gid_idx ON dados_brutos.valid_areas_de_quilombolas USING btree (gid);
CREATE INDEX valid_areas_de_quilombolas_geom_idx ON dados_brutos.valid_areas_de_quilombolas USING gist (geom);

--Assentamento federal
\echo assentamento_federal
\echo  
DROP TABLE IF EXISTS dados_brutos.valid_assentamento_federal;
CREATE TABLE dados_brutos.valid_assentamento_federal AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.assentamento_federal  ;

CREATE INDEX valid_assentamento_federal_gid_idx ON dados_brutos.valid_assentamento_federal USING btree (gid);
CREATE INDEX valid_assentamento_federal_geom_idx ON dados_brutos.valid_assentamento_federal USING gist (geom);

--Assentamento reconhecimento
\echo assentamento_reconhecimento
\echo 
DROP TABLE IF EXISTS dados_brutos.valid_assentamento_reconhecimento;
CREATE TABLE dados_brutos.valid_assentamento_reconhecimento AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.assentamento_reconhecimento ;

CREATE INDEX valid_assentamento_reconhecimento_gid_idx ON dados_brutos.valid_assentamento_reconhecimento USING btree (gid);
CREATE INDEX valid_assentamento_reconhecimento_geom_idx ON dados_brutos.valid_assentamento_reconhecimento USING gist (geom);


--CNFP ESTADUAL
\echo cnfp_2020_br_est
\echo
DROP TABLE IF EXISTS dados_brutos.valid_cnfp_2020_br_est;
CREATE TABLE dados_brutos.valid_cnfp_2020_br_est AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.cnfp_2020_br
WHERE classe in  ('GLEBAEST', 'GLEBAEST/UMF')  ;

CREATE INDEX valid_cnfp_2020_br_est_gid_idx ON dados_brutos.valid_cnfp_2020_br_est USING btree (gid);
CREATE INDEX valid_cnfp_2020_br_est_geom_idx ON dados_brutos.valid_cnfp_2020_br_est USING gist (geom);
CREATE INDEX valid_cnfp_2020_br_est_classe_idx ON dados_brutos.valid_cnfp_2020_br_est USING btree (classe);



--CNFP FEDERAL
\echo cnfp_2020_br_fed
\echo
DROP TABLE IF EXISTS dados_brutos.valid_cnfp_2020_br_fed;
CREATE TABLE dados_brutos.valid_cnfp_2020_br_fed AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.cnfp_2020_br
WHERE classe in  ( 'GLEBAFED')  ;

CREATE INDEX valid_cnfp_2020_br_fed_gid_idx ON dados_brutos.valid_cnfp_2020_br_fed USING btree (gid);
CREATE INDEX valid_cnfp_2020_br_fed_geom_idx ON dados_brutos.valid_cnfp_2020_br_fed USING gist (geom);
CREATE INDEX valid_cnfp_2020_br_fed_classe_idx ON dados_brutos.valid_cnfp_2020_br_fed USING btree (classe);


--TI
\echo geoft_terra_indigena
\echo
DROP TABLE IF EXISTS dados_brutos.valid_geoft_terra_indigena;
CREATE TABLE dados_brutos.valid_geoft_terra_indigena AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.geoft_terra_indigena gti   ;

CREATE INDEX valid_geoft_terra_indigena_gid_idx ON dados_brutos.valid_geoft_terra_indigena USING btree (gid);
CREATE INDEX valid_geoft_terra_indigena_geom_idx ON dados_brutos.valid_geoft_terra_indigena USING gist (geom);


-- UCUSs
\echo geoft_unidade_conservacao ucus
\echo
DROP TABLE IF EXISTS dados_brutos.valid_geoft_unidade_conservacao_ucus;
CREATE TABLE dados_brutos.valid_geoft_unidade_conservacao_ucus AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.geoft_unidade_conservacao guc 
WHERE grup4 = 'US' ;


CREATE INDEX valid_geoft_unidade_conservacao_ucus_gid_idx ON dados_brutos.valid_geoft_unidade_conservacao_ucus USING btree (gid);
CREATE INDEX valid_geoft_unidade_conservacao_ucus_geom_idx ON dados_brutos.valid_geoft_unidade_conservacao_ucus USING gist (geom);



-- UCPIs
\echo geoft_unidade_conservacao ucpi
\echo
DROP TABLE IF EXISTS dados_brutos.valid_geoft_unidade_conservacao_ucpi;
CREATE TABLE dados_brutos.valid_geoft_unidade_conservacao_ucpi AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.geoft_unidade_conservacao guc 
WHERE grup4 = 'PI';


CREATE INDEX valid_geoft_unidade_conservacao_ucpi_gid_idx ON dados_brutos.valid_geoft_unidade_conservacao_ucpi USING btree (gid);
CREATE INDEX valid_geoft_unidade_conservacao_ucpi_geom_idx ON dados_brutos.valid_geoft_unidade_conservacao_ucpi USING gist (geom);





--Sigef privado
\echo sigef_privado
\echo
DROP TABLE IF EXISTS dados_brutos.valid_sigef_privado;
CREATE TABLE dados_brutos.valid_sigef_privado AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.sigef_privado sp ;

CREATE INDEX valid_sigef_privado_gid_idx ON dados_brutos.valid_sigef_privado USING btree (gid);
CREATE INDEX valid_sigef_privado_geom_idx ON dados_brutos.valid_sigef_privado USING gist (geom);


--Sigef publico
\echo sigef_publico
\echo
DROP TABLE IF EXISTS dados_brutos.valid_sigef_publico;
CREATE TABLE dados_brutos.valid_sigef_publico AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.sigef_publico sp ;

CREATE INDEX valid_sigef_publico_gid_idx ON dados_brutos.valid_sigef_publico USING btree (gid);
CREATE INDEX valid_sigef_publico_geom_idx ON dados_brutos.valid_sigef_publico USING gist (geom);


--SNCI privado
\echo imovel_certificado_snci_privado
\echo
DROP TABLE IF EXISTS dados_brutos.valid_imovel_certificado_snci_privado;
CREATE TABLE dados_brutos.valid_imovel_certificado_snci_privado AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.imovel_certificado_snci_privado icsp  ;

CREATE INDEX valid_imovel_certificado_snci_privado_gid_idx ON dados_brutos.valid_imovel_certificado_snci_privado USING btree (gid);
CREATE INDEX valid_imovel_certificado_snci_privado_geom_idx ON dados_brutos.valid_imovel_certificado_snci_privado USING gist (geom);



--SNCI publico
\echo imovel_certificado_snci_publico
\echo
DROP TABLE IF EXISTS dados_brutos.valid_imovel_certificado_snci_publico;
CREATE TABLE dados_brutos.valid_imovel_certificado_snci_publico AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.imovel_certificado_snci_publico icsp  ;

CREATE INDEX valid_imovel_certificado_snci_publico_gid_idx ON dados_brutos.valid_imovel_certificado_snci_publico USING btree (gid);
CREATE INDEX valid_imovel_certificado_snci_publico_geom_idx ON dados_brutos.valid_imovel_certificado_snci_publico USING gist (geom);



--Terra legal
\echo terra legal
\echo

DROP TABLE IF EXISTS dados_brutos.valid_terralegal_privado;
CREATE TABLE dados_brutos.valid_terralegal_privado AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.input_terralegal_particular_incra icsp  ;

CREATE INDEX valid_terralegal_privado_gid_idx ON dados_brutos.valid_terralegal_privado USING btree (gid);
CREATE INDEX valid_terralegal_privado_geom_idx ON dados_brutos.valid_terralegal_privado USING gist (geom);


-- Interesse da união
\echo interesse da uniao 
\echo  

DROP TABLE IF EXISTS dados_brutos.valid_areas_interesse_uniao;
CREATE TABLE dados_brutos.valid_areas_interesse_uniao AS
SELECT *,  ST_SetSRID(ST_MakeValid(geom), 0) valid_geom FROM dados_brutos.cnfp_2020_br cb WHERE classe = 'USO MILITAR';

CREATE INDEX valid_areas_interesse_uniao_gid_idx ON dados_brutos.valid_areas_interesse_uniao USING btree (gid);
CREATE INDEX valid_areas_interesse_uniao_geom_idx ON dados_brutos.valid_areas_interesse_uniao USING gist (valid_geom);




-- Massas dagua
\echo Massas dagua 
\echo  

DROP TABLE IF EXISTS dados_brutos.valid_input_massas_dagua;
CREATE TABLE dados_brutos.valid_input_massas_dagua AS
SELECT *,  ST_SetSRID(ST_MakeValid(geom), 0) valid_geom FROM dados_brutos.geoft_bho_massa_dagua_2019 cb;

CREATE INDEX valid_input_massas_dagua_gid_idx ON dados_brutos.valid_input_massas_dagua USING btree (gid);
CREATE INDEX valid_input_massas_dagua_geom_idx ON dados_brutos.valid_input_massas_dagua USING gist (valid_geom);




-- Faixa de fronteira
\echo Faixa de fronteira
\echo  

DROP TABLE IF EXISTS dados_brutos.valid_input_faixa_fronteira;
CREATE TABLE dados_brutos.valid_input_faixa_fronteira AS
SELECT 1 id , ST_MakeValid( ST_Intersection( ST_buffer( ST_BOUNDARY(geom)::geography, 150000) , geom)::geometry ) valid_geom 
FROM geo_adm.pa_br_limitenacional_250_2015_ibge_4674 cb;

CREATE INDEX valid_input_faixa_fronteira_gid_idx ON dados_brutos.valid_input_faixa_fronteira USING btree (gid);
CREATE INDEX valid_input_faixa_fronteira_geom_idx ON dados_brutos.valid_input_faixa_fronteira USING gist (valid_geom);




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








