
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
---------------------VALID--------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

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




--SICAR
\echo sicar_imovel
\echo


DROP TABLE IF EXISTS dados_brutos.valid_sicar_imovel;
CREATE TABLE dados_brutos.valid_sicar_imovel AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imovel icsp  ;

CREATE INDEX valid_sicar_imovel_gid_idx ON dados_brutos.valid_sicar_imovel USING btree (gid);
CREATE INDEX valid_sicar_imovel_geom_idx ON dados_brutos.valid_sicar_imovel USING gist (geom);
CREATE INDEX valid_sicar_imovel_valid_geom_idx ON dados_brutos.valid_sicar_imovel USING gist (geom);





----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
---------------------AUTOINTERSECTION---------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------




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




----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
---------------------INPUTS-------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------





-- Massas dagua
\echo Massas dagua
\echo  
\echo  


-- Autointersecção
DROP TABLE IF EXISTS inputs.inputs_massas_dagua;
CREATE TABLE inputs.inputs_massas_dagua
(
  gid serial NOT NULL ,
  original_gid int4[] NULL,
  cd_layer int4 NULL,
  geom geometry NULL
);


CREATE INDEX inputs_massas_dagua_original_gid_idx ON inputs.inputs_massas_dagua USING btree (original_gid);
CREATE INDEX inputs_massas_dagua_geom_idx ON inputs.inputs_massas_dagua USING gist (geom);
CREATE INDEX inputs_massas_dagua_gid_idx ON inputs.inputs_massas_dagua USING btree (gid);




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

