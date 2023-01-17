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



-- areas interesse da uniao 
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

CREATE INDEX input_sncipublico_2022_agid_idx ON autointersection.autointersection_input_sncipublico_2022 USING btree (agid);
CREATE INDEX input_sncipublico_2022_geom_idx ON autointersection.autointersection_input_sncipublico_2022 USING gist (geom);
CREATE INDEX input_sncipublico_2022_bgid_idx ON autointersection.autointersection_input_sncipublico_2022 USING btree (bgid);

CREATE INDEX input_sigefpublico_2022_agid_idx ON autointersection.autointersection_input_sigefpublico_2022 USING btree (agid);
CREATE INDEX input_sigefpublico_2022_geom_idx ON autointersection.autointersection_input_sigefpublico_2022 USING gist (geom);
CREATE INDEX input_sigefpublico_2022_bgid_idx ON autointersection.autointersection_input_sigefpublico_2022 USING btree (bgid);

CREATE INDEX input_snciprivado_2022_agid_idx ON autointersection.autointersection_input_snciprivado_2022 USING btree (agid);
CREATE INDEX input_snciprivado_2022_geom_idx ON autointersection.autointersection_input_snciprivado_2022 USING gist (geom);
CREATE INDEX input_snciprivado_2022_bgid_idx ON autointersection.autointersection_input_snciprivado_2022 USING btree (bgid);

CREATE INDEX input_sigefprivado_2022_agid_idx ON autointersection.autointersection_input_sigefprivado_2022 USING btree (agid);
CREATE INDEX input_sigefprivado_2022_geom_idx ON autointersection.autointersection_input_sigefprivado_2022 USING gist (geom);
CREATE INDEX input_sigefprivado_2022_bgid_idx ON autointersection.autointersection_input_sigefprivado_2022 USING btree (bgid);

CREATE INDEX input_terrasindigenas_funai_2022_agid_idx ON autointersection.autointersection_input_terrasindigenas_funai_2022 USING btree (agid);
CREATE INDEX input_terrasindigenas_funai_2022_geom_idx ON autointersection.autointersection_input_terrasindigenas_funai_2022 USING gist (geom);
CREATE INDEX input_terrasindigenas_funai_2022_bgid_idx ON autointersection.autointersection_input_terrasindigenas_funai_2022 USING btree (bgid);

CREATE INDEX input_quilombolas_2022_agid_idx ON autointersection.autointersection_input_quilombolas_2022 USING btree (agid);
CREATE INDEX input_quilombolas_2022_geom_idx ON autointersection.autointersection_input_quilombolas_2022 USING gist (geom);
CREATE INDEX input_quilombolas_2022_bgid_idx ON autointersection.autointersection_input_quilombolas_2022 USING btree (bgid);

CREATE INDEX input_assentamento_federal_2022_agid_idx ON autointersection.autointersection_input_assentamento_federal_2022 USING btree (agid);
CREATE INDEX input_assentamento_federal_2022_geom_idx ON autointersection.autointersection_input_assentamento_federal_2022 USING gist (geom);
CREATE INDEX input_assentamento_federal_2022_bgid_idx ON autointersection.autointersection_input_assentamento_federal_2022 USING btree (bgid);

CREATE INDEX input_assentamento_reconhecimento_2022_agid_idx ON autointersection.autointersection_input_assentamento_reconhecimento_2022 USING btree (agid);
CREATE INDEX input_assentamento_reconhecimento_2022_geom_idx ON autointersection.autointersection_input_assentamento_reconhecimento_2022 USING gist (geom);
CREATE INDEX input_assentamento_reconhecimento_2022_bgid_idx ON autointersection.autointersection_input_assentamento_reconhecimento_2022 USING btree (bgid);

CREATE INDEX input_uc_2022_agid_idx ON autointersection.autointersection_input_uc_2022 USING btree (agid);
CREATE INDEX input_uc_2022_geom_idx ON autointersection.autointersection_input_uc_2022 USING gist (geom);
CREATE INDEX input_uc_2022_bgid_idx ON autointersection.autointersection_input_uc_2022 USING btree (bgid);

CREATE INDEX input_glebaspublicas_2022_agid_idx ON autointersection.autointersection_input_glebaspublicas_2022 USING btree (agid);
CREATE INDEX input_glebaspublicas_2022_geom_idx ON autointersection.autointersection_input_glebaspublicas_2022 USING gist (geom);
CREATE INDEX input_glebaspublicas_2022_bgid_idx ON autointersection.autointersection_input_glebaspublicas_2022 USING btree (bgid);

