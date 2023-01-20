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



