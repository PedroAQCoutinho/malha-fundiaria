-- TerrasIndigenas
\echo TerrasIndigenas
\echo  
\echo  

-- Cria tabela que será populada
DROP TABLE IF EXISTS inputs.input_terrasindigenas_funai_2022;
CREATE TABLE inputs.input_terrasindigenas_funai_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX input_terrasindigenas_funai_2022_original_gid_idx ON inputs.input_terrasindigenas_funai_2022 USING btree (original_gid);
CREATE INDEX input_terrasindigenas_funai_2022_geom_idx ON inputs.input_terrasindigenas_funai_2022 USING gist (geom);
CREATE INDEX input_terrasindigenas_funai_2022_gid_idx ON inputs.input_terrasindigenas_funai_2022 USING btree (gid);


-- Quilombolas
\echo Quilombolas
\echo  
\echo  


-- Cria tabela que será populada
DROP TABLE IF EXISTS inputs.input_quilombolas_2022;
CREATE TABLE inputs.input_quilombolas_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_quilombolas_2022_original_gid_idx ON inputs.input_quilombolas_2022 USING btree (original_gid);
CREATE INDEX input_quilombolas_2022_geom_idx ON inputs.input_quilombolas_2022 USING gist (geom);
CREATE INDEX input_quilombolas_2022_gid_idx ON inputs.input_quilombolas_2022 USING btree (gid);


-- Assentamentos federais
\echo Assentamentos federais
\echo  
\echo


-- Cria tabela que será populada
DROP TABLE IF EXISTS inputs.input_assentamento_federal_2022;
CREATE TABLE inputs.input_assentamento_federal_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX input_assentamento_federal_2022_original_gid_idx ON inputs.input_assentamento_federal_2022 USING btree (original_gid);
CREATE INDEX input_assentamento_federal_2022_geom_idx ON inputs.input_assentamento_federal_2022 USING gist (geom);
CREATE INDEX input_assentamento_federal_2022_gid_idx ON inputs.input_assentamento_federal_2022 USING btree (gid);

-- Assentamentos reconhecimento
\echo Assentamentos reconhecimento
\echo  
\echo 


-- Cria tabela que será populada
DROP TABLE IF EXISTS inputs.input_assentamento_reconhecimento_2022;
CREATE TABLE inputs.input_assentamento_reconhecimento_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_assentamento_reconhecimento_2022_original_gid_idx ON inputs.input_assentamento_reconhecimento_2022 USING btree (original_gid);
CREATE INDEX input_assentamento_reconhecimento_2022_geom_idx ON inputs.input_assentamento_reconhecimento_2022 USING gist (geom);
CREATE INDEX input_assentamento_reconhecimento_2022_gid_idx ON inputs.input_assentamento_reconhecimento_2022 USING btree (gid);


-- UCPIs
\echo UCUSs
\echo  
\echo 

-- Cria tabela que será populada
DROP TABLE IF EXISTS inputs.input_ucus_2022;
CREATE TABLE inputs.input_ucus_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_ucus_2022_original_gid_idx ON inputs.input_ucus_2022 USING btree (original_gid);
CREATE INDEX input_ucus_2022_geom_idx ON inputs.input_ucus_2022 USING gist (geom);
CREATE INDEX input_ucus_2022_gid_idx ON inputs.input_ucus_2022 USING btree (gid);


-- UCPIs
\echo UCPIs
\echo  
\echo 

-- Cria tabela que será populada
DROP TABLE IF EXISTS inputs.input_ucpi_2022;
CREATE TABLE inputs.input_ucpi_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX input_ucpi_2022_original_gid_idx ON inputs.input_ucpi_2022 USING btree (original_gid);
CREATE INDEX input_ucpi_2022_geom_idx ON inputs.input_ucpi_2022 USING gist (geom);
CREATE INDEX input_ucpi_2022_gid_idx ON inputs.input_ucpi_2022 USING btree (gid);


-- Glebas Publicas est
\echo GlebasPublicas est
\echo  
\echo 

-- Cria tabela que será populada
DROP TABLE IF EXISTS inputs.input_glebaspublicas_est_2022;
CREATE TABLE inputs.input_glebaspublicas_est_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX input_glebaspublicas_est_2022_original_gid_idx ON inputs.input_glebaspublicas_est_2022 USING btree (original_gid);
CREATE INDEX input_glebaspublicas_est_2022_geom_idx ON inputs.input_glebaspublicas_est_2022 USING gist (geom);
CREATE INDEX input_glebaspublicas_est_2022_gid_idx ON inputs.input_glebaspublicas_est_2022 USING btree (gid);



-- Glebas Publicas fed
\echo GlebasPublicas fed
\echo   
\echo 

-- Cria tabela que será populada
DROP TABLE IF EXISTS inputs.input_glebaspublicas_fed_2022;
CREATE TABLE inputs.input_glebaspublicas_fed_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);



CREATE INDEX input_glebaspublicas_fed_2022_original_gid_idx ON inputs.input_glebaspublicas_fed_2022 USING btree (original_gid);
CREATE INDEX input_glebaspublicas_fed_2022_geom_idx ON inputs.input_glebaspublicas_fed_2022 USING gist (geom);
CREATE INDEX input_glebaspublicas_fed_2022_gid_idx ON inputs.input_glebaspublicas_fed_2022 USING btree (gid);

-- Sigef publico
\echo SIGEFpubli
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.input_sigefpublico_2022;
CREATE TABLE inputs.input_sigefpublico_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_sigefpublico_2022_original_gid_idx ON inputs.input_sigefpublico_2022 USING btree (original_gid);
CREATE INDEX input_sigefpublico_2022_geom_idx ON inputs.input_sigefpublico_2022 USING gist (geom);
CREATE INDEX input_sigefpublico_2022_gid_idx ON inputs.input_sigefpublico_2022 USING btree (gid);


-- SNCI publico
\echo SNCIpubli
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.input_sncipublico_2022;
CREATE TABLE inputs.input_sncipublico_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);



CREATE INDEX input_sncipublico_2022_original_gid_idx ON inputs.input_sncipublico_2022 USING btree (original_gid);
CREATE INDEX input_sncipublico_2022_geom_idx ON inputs.input_sncipublico_2022 USING gist (geom);
CREATE INDEX input_sncipublico_2022_gid_idx ON inputs.input_sncipublico_2022 USING btree (gid);

-- Sigef privado
\echo SIGEFpriv
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.input_sigefprivado_2022;
CREATE TABLE inputs.input_sigefprivado_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);

CREATE INDEX input_sigefprivado_2022_original_gid_idx ON inputs.input_sigefprivado_2022 USING btree (original_gid);
CREATE INDEX input_sigefprivado_2022_geom_idx ON inputs.input_sigefprivado_2022 USING gist (geom);
CREATE INDEX input_sigefprivado_2022_gid_idx ON inputs.input_sigefprivado_2022 USING btree (gid);


-- SNCI privado
\echo SNCIpriv
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.input_snciprivado_2022;
CREATE TABLE inputs.input_snciprivado_2022
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX input_snciprivado_2022_original_gid_idx ON inputs.input_snciprivado_2022 USING btree (original_gid);
CREATE INDEX input_snciprivado_2022_geom_idx ON inputs.input_snciprivado_2022 USING gist (geom);
CREATE INDEX input_snciprivado_2022_gid_idx ON inputs.input_snciprivado_2022 USING btree (gid);






-- Terra legal
\echo Terra legal
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.input_terralegal_privado;
CREATE TABLE inputs.input_terralegal_privado
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX input_terralegal_privado_original_gid_idx ON inputs.input_terralegal_privado USING btree (original_gid);
CREATE INDEX input_terralegal_privado_geom_idx ON inputs.input_terralegal_privado USING gist (geom);
CREATE INDEX input_terralegal_privado_gid_idx ON inputs.input_terralegal_privado USING btree (gid);




-- Interesse da uninao
\echo Interesse da uniao
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.inputs_interesse_uniao;
CREATE TABLE inputs.inputs_interesse_uniao
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX inputs_interesse_uniao_original_gid_idx ON inputs.inputs_interesse_uniao USING btree (original_gid);
CREATE INDEX inputs_interesse_uniao_geom_idx ON inputs.inputs_interesse_uniao USING gist (geom);
CREATE INDEX inputs_interesse_uniao_gid_idx ON inputs.inputs_interesse_uniao USING btree (gid);


-- SICAR
\echo SICAR imoveis
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.inputs_sicar_imovel;
CREATE TABLE inputs.inputs_sicar_imovel
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX inputs_sicar_imovel_original_gid_idx ON inputs.inputs_sicar_imovel USING btree (original_gid);
CREATE INDEX inputs_sicar_imovel_geom_idx ON inputs.inputs_sicar_imovel USING gist (geom);
CREATE INDEX inputs_sicar_imovel_gid_idx ON inputs.inputs_sicar_imovel USING btree (gid);






-- Faixa de fronteira
\echo Faixa de fronteira
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.inputs_faixa_fronteira;
CREATE TABLE inputs.inputs_faixa_fronteira
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX inputs_faixa_fronteira_original_gid_idx ON inputs.inputs_faixa_fronteira USING btree (original_gid);
CREATE INDEX inputs_faixa_fronteira_geom_idx ON inputs.inputs_faixa_fronteira USING gist (geom);
CREATE INDEX inputs_faixa_fronteira_gid_idx ON inputs.inputs_faixa_fronteira USING btree (gid);






-- Faixa de fronteira
\echo Faixa de fronteira
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.inputs_faixa_fronteira;
CREATE TABLE inputs.inputs_faixa_fronteira
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX inputs_faixa_fronteira_original_gid_idx ON inputs.inputs_faixa_fronteira USING btree (original_gid);
CREATE INDEX inputs_faixa_fronteira_geom_idx ON inputs.inputs_faixa_fronteira USING gist (geom);
CREATE INDEX inputs_faixa_fronteira_gid_idx ON inputs.inputs_faixa_fronteira USING btree (gid);



 














