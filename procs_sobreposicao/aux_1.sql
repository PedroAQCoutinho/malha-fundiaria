
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

--DROP TABLE IF EXISTS dados_brutos.valid_input_massas_dagua;
--CREATE TABLE dados_brutos.valid_input_massas_dagua AS
--SELECT *,  ST_SetSRID(ST_MakeValid(geom), 0) valid_geom FROM dados_brutos.geoft_bho_massa_dagua_2019 cb;

--CREATE INDEX valid_input_massas_dagua_gid_idx ON dados_brutos.valid_input_massas_dagua USING btree (gid);
--CREATE INDEX valid_input_massas_dagua_geom_idx ON dados_brutos.valid_input_massas_dagua USING gist (valid_geom);




-- Faixa de fronteira
\echo Faixa de fronteira
\echo  

--DROP TABLE IF EXISTS dados_brutos.valid_input_faixa_fronteira;
--CREATE TABLE dados_brutos.valid_input_faixa_fronteira AS
--SELECT 1 id , ST_MakeValid( ST_Intersection( ST_buffer( ST_BOUNDARY(geom)::geography, 150000) , geom)::geometry ) valid_geom 
--FROM geo_adm.pa_br_limitenacional_250_2015_ibge_4674 cb;

--CREATE INDEX valid_input_faixa_fronteira_gid_idx ON dados_brutos.valid_input_faixa_fronteira USING btree (gid);
--CREATE INDEX valid_input_faixa_fronteira_geom_idx ON dados_brutos.valid_input_faixa_fronteira USING gist (valid_geom);




--SICAR
\echo sicar_imovel
\echo


--DROP TABLE IF EXISTS dados_brutos.valid_sicar_imovel;
--CREATE TABLE dados_brutos.valid_sicar_imovel AS
--SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imovel icsp  ;

--CREATE INDEX valid_sicar_imovel_gid_idx ON dados_brutos.valid_sicar_imovel USING btree (gid);
--CREATE INDEX valid_sicar_imovel_valid_geom_idx ON dados_brutos.valid_sicar_imovel USING gist (geom);





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
--DROP TABLE IF EXISTS autointersection.autointersection_input_massas_dagua;
CREATE TABLE autointersection.autointersection_input_massas_dagua
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_massas_dagua_agid_idx ON autointersection.autointersection_input_massas_dagua USING btree (agid);
CREATE INDEX autointersection_input_massas_dagua_geom_idx ON autointersection.autointersection_input_massas_dagua USING gist (geom);
CREATE INDEX autointersection_input_massas_dagua_bgid_idx ON autointersection.autointersection_input_massas_dagua USING btree (bgid);


-- Faixa
/*
DROP TABLE IF EXISTS autointersection.autointersection_input_faixa_fronteira;
CREATE TABLE autointersection.autointersection_input_faixa_fronteira
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
--DROP TABLE IF EXISTS autointersection.autointersection_input_sicar_imovel;
CREATE TABLE autointersection.autointersection_input_sicar_imovel
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);


CREATE INDEX autointersection_input_sicar_imovel_agid_idx ON autointersection.autointersection_input_sicar_imovel USING btree (agid);
CREATE INDEX autointersection_input_sicar_imovel_geom_idx ON autointersection.autointersection_input_sicar_imovel USING gist (geom);
CREATE INDEX autointersection_input_sicar_imovel_bgid_idx ON autointersection.autointersection_input_sicar_imovel USING btree (bgid);

*/


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


/*

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

*/


----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
---------------------OVERLAY OUTPUTS----------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------








-- Massas dagua
\echo Massas dagua
\echo   

-- 
DROP TABLE IF EXISTS outputs.step15_overlay;
CREATE TABLE outputs.step15_overlay
(
  gid serial NOT null,
  cd_mun integer NULL, 
  cd_bioma integer NULL,
  am_legal BOOLEAN NULL,
  original_gid integer[] NULL,
  original_layer integer[] NULL,
  is_ti boolean NULL,
  is_qui boolean NULL,
  is_assenfed boolean NULL,
  is_assenrec BOOLEAN NULL,
  is_ucus BOOLEAN NULL,
  is_ucpi BOOLEAN NULL,
  is_glebaest BOOLEAN NULL,
  is_glebafed BOOLEAN NULL,
  is_sigefpub BOOLEAN NULL,
  is_sncipub BOOLEAN NULL,
  is_sigefpriv BOOLEAN NULL,
  is_sncipriv BOOLEAN NULL,
  is_terralegal BOOLEAN NULL,
  is_interesse_uniao BOOLEAN NULL,
  is_massas_dagua BOOLEAN NULL,
  geom geometry NULL
);


CREATE INDEX step15_overlay_original_gid_idx ON outputs.step15_overlay USING btree (original_gid);
CREATE INDEX step15_overlay_cd_mun_idx ON outputs.step15_overlay USING btree (cd_mun);
CREATE INDEX step15_overlay_original_layer_idx ON outputs.step15_overlay USING btree (original_layer);
CREATE INDEX step15_overlay_geom_idx ON outputs.step15_overlay USING gist (geom);
CREATE INDEX step15_overlay_gid_idx ON outputs.step15_overlay USING btree (gid);
CREATE INDEX step15_overlay_cd_bioma_idx ON outputs.step15_overlay USING btree (cd_bioma);


\echo  


/*
-- Faixa de fronteira
\echo faixa de fronteira
\echo   

-- 
DROP TABLE IF EXISTS outputs.step16_overlay;
CREATE TABLE outputs.step16_overlay
(
  gid serial NOT null,
  cd_mun integer NULL, 
  cd_bioma integer NULL,
  am_legal BOOLEAN NULL,
  original_gid integer[] NULL,
  original_layer integer[] NULL,
  is_ti boolean NULL,
  is_qui boolean NULL,
  is_assenfed boolean NULL,
  is_assenrec BOOLEAN NULL,
  is_ucus BOOLEAN NULL,
  is_ucpi BOOLEAN NULL,
  is_glebaest BOOLEAN NULL,
  is_glebafed BOOLEAN NULL,
  is_sigefpub BOOLEAN NULL,
  is_sncipub BOOLEAN NULL,
  is_sigefpriv BOOLEAN NULL,
  is_sncipriv BOOLEAN NULL,
  is_terralegal BOOLEAN NULL,
  is_interesse_uniao BOOLEAN NULL,
  is_massas_dagua BOOLEAN NULL,
  is_fronteira BOOLEAN NULL,
  geom geometry NULL
);


CREATE INDEX step16_overlay_original_gid_idx ON outputs.step16_overlay USING btree (original_gid);
CREATE INDEX step16_overlay_cd_mun_idx ON outputs.step16_overlay USING btree (cd_mun);
CREATE INDEX step16_overlay_original_layer_idx ON outputs.step16_overlay USING btree (original_layer);
CREATE INDEX step16_overlay_geom_idx ON outputs.step16_overlay USING gist (geom);
CREATE INDEX step16_overlay_gid_idx ON outputs.step16_overlay USING btree (gid);
CREATE INDEX step16_overlay_cd_bioma_idx ON outputs.step16_overlay USING btree (cd_bioma);


\echo  


-- SICAR
\echo SICAR
\echo   

-- 
DROP TABLE IF EXISTS outputs.step17_overlay;
CREATE TABLE outputs.step17_overlay
(
  gid serial NOT null,
  cd_mun integer NULL, 
  cd_bioma integer NULL,
  am_legal BOOLEAN NULL,
  original_gid integer[] NULL,
  original_layer integer[] NULL,
  is_ti boolean NULL,
  is_qui boolean NULL,
  is_assenfed boolean NULL,
  is_assenrec BOOLEAN NULL,
  is_ucus BOOLEAN NULL,
  is_ucpi BOOLEAN NULL,
  is_glebaest BOOLEAN NULL,
  is_glebafed BOOLEAN NULL,
  is_sigefpub BOOLEAN NULL,
  is_sncipub BOOLEAN NULL,
  is_sigefpriv BOOLEAN NULL,
  is_sncipriv BOOLEAN NULL,
  is_terralegal BOOLEAN NULL,
  is_interesse_uniao BOOLEAN NULL,
  is_massas_dagua BOOLEAN NULL,
  is_fronteira BOOLEAN NULL,
  is_sicar BOOLEAN NULL,
  geom geometry NULL
);


CREATE INDEX step17_overlay_original_gid_idx ON outputs.step17_overlay USING btree (original_gid);
CREATE INDEX step17_overlay_cd_mun_idx ON outputs.step17_overlay USING btree (cd_mun);
CREATE INDEX step17_overlay_original_layer_idx ON outputs.step17_overlay USING btree (original_layer);
CREATE INDEX step17_overlay_geom_idx ON outputs.step17_overlay USING gist (geom);
CREATE INDEX step17_overlay_gid_idx ON outputs.step17_overlay USING btree (gid);
CREATE INDEX step17_overlay_cd_bioma_idx ON outputs.step17_overlay USING btree (cd_bioma);


\echo  

*/


