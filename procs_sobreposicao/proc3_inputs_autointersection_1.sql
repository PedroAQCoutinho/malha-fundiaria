-- Terras indigenas
\echo TerrasIndigenas
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_terrasindigenas_funai_2022;
CREATE TABLE autointersection.autointersection_input_terrasindigenas_funai_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_terrasindigenas_funai_2022_agid_idx ON autointersection.autointersection_input_terrasindigenas_funai_2022 USING btree (agid);
CREATE INDEX input_terrasindigenas_funai_2022_geom_idx ON autointersection.autointersection_input_terrasindigenas_funai_2022 USING gist (geom);
CREATE INDEX input_terrasindigenas_funai_2022_bgid_idx ON autointersection.autointersection_input_terrasindigenas_funai_2022 USING btree (bgid);


-- Quilombolas
\echo Quilombolas
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_quilombolas_2022;
CREATE TABLE autointersection.autointersection_input_quilombolas_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);

CREATE INDEX autointersection_input_quilombolas_2022_agid_idx ON autointersection.autointersection_input_quilombolas_2022 USING btree (agid);
CREATE INDEX autointersection_input_quilombolas_2022_geom_idx ON autointersection.autointersection_input_quilombolas_2022 USING gist (geom);
CREATE INDEX autointersection_input_quilombolas_2022_bgid_idx ON autointersection.autointersection_input_quilombolas_2022 USING btree (bgid);



-- AssFederais
\echo AssFederais
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_assentamento_federal_2022;
CREATE TABLE autointersection.autointersection_input_assentamento_federal_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX input_assentamento_federal_2022_agid_idx ON autointersection.autointersection_input_assentamento_federal_2022 USING btree (agid);
CREATE INDEX input_assentamento_federal_2022_geom_idx ON autointersection.autointersection_input_assentamento_federal_2022 USING gist (geom);
CREATE INDEX input_assentamento_federal_2022_bgid_idx ON autointersection.autointersection_input_assentamento_federal_2022 USING btree (bgid);


-- AssReconhecimento
\echo AssReconhecimento
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_assentamento_reconhecimento_2022;
CREATE TABLE autointersection.autointersection_input_assentamento_reconhecimento_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_assentamento_reconhecimento_2022_agid_idx ON autointersection.autointersection_input_assentamento_reconhecimento_2022 USING btree (agid);
CREATE INDEX input_assentamento_reconhecimento_2022_geom_idx ON autointersection.autointersection_input_assentamento_reconhecimento_2022 USING gist (geom);
CREATE INDEX input_assentamento_reconhecimento_2022_bgid_idx ON autointersection.autointersection_input_assentamento_reconhecimento_2022 USING btree (bgid);



-- UCUSs
\echo ucs
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_ucus_2022;
CREATE TABLE autointersection.autointersection_input_ucus_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_ucus_2022_agid_idx ON autointersection.autointersection_input_ucus_2022 USING btree (agid);
CREATE INDEX autointersection_input_ucus_2022_geom_idx ON autointersection.autointersection_input_ucus_2022 USING gist (geom);
CREATE INDEX autointersection_input_ucus_2022_bgid_idx ON autointersection.autointersection_input_ucus_2022 USING btree (bgid);



-- ucs
\echo ucs
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_ucpi_2022;
CREATE TABLE autointersection.autointersection_input_ucpi_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_ucpi_2022_agid_idx ON autointersection.autointersection_input_ucpi_2022 USING btree (agid);
CREATE INDEX autointersection_input_ucpi_2022_geom_idx ON autointersection.autointersection_input_ucpi_2022 USING gist (geom);
CREATE INDEX autointersection_input_ucpi_2022_bgid_idx ON autointersection.autointersection_input_ucpi_2022 USING btree (bgid);



-- Glebas est
\echo Glebas est
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_glebaspublicas_est_2022;
CREATE TABLE autointersection.autointersection_input_glebaspublicas_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_glebaspublicas_est_2022_agid_idx ON autointersection.autointersection_input_glebaspublicas_est_2022 USING btree (agid);
CREATE INDEX autointersection_input_glebaspublicas_est_2022_geom_idx ON autointersection.autointersection_input_glebaspublicas_est_2022 USING gist (geom);
CREATE INDEX autointersection_input_glebaspublicas_est_2022_bgid_idx ON autointersection.autointersection_input_glebaspublicas_est_2022 USING btree (bgid);

-- Glebas fed
\echo Glebas fed
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_glebaspublicas_fed_2022;
CREATE TABLE autointersection.autointersection_input_glebaspublicas_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);

CREATE INDEX autointersection_input_glebaspublicas_fed_2022_agid_idx ON autointersection.autointersection_input_glebaspublicas_fed_2022 USING btree (agid);
CREATE INDEX autointersection_input_glebaspublicas_fed_2022_geom_idx ON autointersection.autointersection_input_glebaspublicas_fed_2022 USING gist (geom);
CREATE INDEX autointersection_input_glebaspublicas_fed_2022_bgid_idx ON autointersection.autointersection_input_glebaspublicas_fed_2022 USING btree (bgid);




-- Sigef publico
\echo Sigef pub
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_sigefpublico_2022;
CREATE TABLE autointersection.autointersection_input_sigefpublico_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_sigefpublico_2022_agid_idx ON autointersection.autointersection_input_sigefpublico_2022 USING btree (agid);
CREATE INDEX input_sigefpublico_2022_geom_idx ON autointersection.autointersection_input_sigefpublico_2022 USING gist (geom);
CREATE INDEX input_sigefpublico_2022_bgid_idx ON autointersection.autointersection_input_sigefpublico_2022 USING btree (bgid);




-- SNCI publico
\echo SNCI pub
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_sncipublico_2022;
CREATE TABLE autointersection.autointersection_input_sncipublico_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX input_sncipublico_2022_agid_idx ON autointersection.autointersection_input_sncipublico_2022 USING btree (agid);
CREATE INDEX input_sncipublico_2022_geom_idx ON autointersection.autointersection_input_sncipublico_2022 USING gist (geom);
CREATE INDEX input_sncipublico_2022_bgid_idx ON autointersection.autointersection_input_sncipublico_2022 USING btree (bgid);




-- Sigef privado
\echo SIGEF priv
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_sigefprivado_2022;
CREATE TABLE autointersection.autointersection_input_sigefprivado_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);



CREATE INDEX input_sigefprivado_2022_agid_idx ON autointersection.autointersection_input_sigefprivado_2022 USING btree (agid);
CREATE INDEX input_sigefprivado_2022_geom_idx ON autointersection.autointersection_input_sigefprivado_2022 USING gist (geom);
CREATE INDEX input_sigefprivado_2022_bgid_idx ON autointersection.autointersection_input_sigefprivado_2022 USING btree (bgid);


-- SNCI privado
\echo SNCI priv
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_snciprivado_2022;
CREATE TABLE autointersection.autointersection_input_snciprivado_2022
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_snciprivado_2022_agid_idx ON autointersection.autointersection_input_snciprivado_2022 USING btree (agid);
CREATE INDEX input_snciprivado_2022_geom_idx ON autointersection.autointersection_input_snciprivado_2022 USING gist (geom);
CREATE INDEX input_snciprivado_2022_bgid_idx ON autointersection.autointersection_input_snciprivado_2022 USING btree (bgid);



-- Terra legal
\echo Terra legal
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS autointersection.autointersection_input_terralegal;
CREATE TABLE autointersection.autointersection_input_terralegal
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);

CREATE INDEX autointersection_input_terralegal_agid_idx ON autointersection.autointersection_input_terralegal USING btree (agid);
CREATE INDEX autointersection_input_terralegal_geom_idx ON autointersection.autointersection_input_terralegal USING gist (geom);
CREATE INDEX autointersection_input_terralegal_bgid_idx ON autointersection.autointersection_input_terralegal USING btree (bgid);


-- Areas interesse da uniao 
DROP TABLE IF EXISTS autointersection.autointersection_input_areas_interesse_uniao;
CREATE TABLE autointersection.autointersection_input_areas_interesse_uniao
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_areas_interesse_uniao_agid_idx ON autointersection.autointersection_input_areas_interesse_uniao USING btree (agid);
CREATE INDEX autointersection_input_areas_interesse_uniao_geom_idx ON autointersection.autointersection_input_areas_interesse_uniao USING gist (geom);
CREATE INDEX autointersection_input_areas_interesse_uniao_bgid_idx ON autointersection.autointersection_input_areas_interesse_uniao USING btree (bgid);


-- Massas dagua
DROP TABLE IF EXISTS autointersection.autointersection_input_massas_dagua;
CREATE TABLE autointersection.autointersection_inputs_massas_dagua
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_massas_dagua_agid_idx ON autointersection.autointersection_input_massas_dagua USING btree (agid);
CREATE INDEX autointersection_input_massas_dagua_geom_idx ON autointersection.autointersection_input_massas_dagua USING gist (geom);
CREATE INDEX autointersection_input_massas_dagua_bgid_idx ON autointersection.autointersection_input_massas_dagua USING btree (bgid);



-- Faixa de fronteira
DROP TABLE IF EXISTS autointersection.autointersection_input_faixa_fronteira;
CREATE TABLE autointersection.autointersection_valid_input_faixa_fronteira
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_faixa_fronteira_agid_idx ON autointersection.autointersection_input_faixa_fronteira USING btree (agid);
CREATE INDEX autointersection_input_faixa_fronteira_geom_idx ON autointersection.autointersection_input_faixa_fronteira USING gist (geom);
CREATE INDEX autointersection_input_faixa_fronteira_bgid_idx ON autointersection.autointersection_input_faixa_fronteira USING btree (bgid);




-- SICAR
DROP TABLE IF EXISTS autointersection.autointersection_input_sicar_imovel;
CREATE TABLE autointersection.autointersection_valid_sicar_imovel
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_sicar_imovel_agid_idx ON autointersection.autointersection_input_sicar_imovel USING btree (agid);
CREATE INDEX autointersection_input_sicar_imovel_geom_idx ON autointersection.autointersection_input_sicar_imovel USING gist (geom);
CREATE INDEX autointersection_input_sicar_imovel_bgid_idx ON autointersection.autointersection_input_sicar_imovel USING btree (bgid);
