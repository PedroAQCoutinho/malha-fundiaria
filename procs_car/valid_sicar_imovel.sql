DROP TABLE dados_brutos.valid_sicar_imovel;
CREATE TABLE dados_brutos.valid_sicar_imovel (
	gid serial4 NOT NULL,
	gid_original int4 NULL,
	cod_imovel text NULL,
	status_imo text NULL,
	dat_criaca text NULL,
	area numeric NULL,
	condicao text NULL,
	uf text NULL,
	municipio text NULL,
	cod_munici int4 NULL,
	m_fiscal int4 NULL,
	tipo_imove text NULL,
	valid_geom public.geometry NULL
);
CREATE INDEX valid_sicar_imovel_gid_idx2 ON dados_brutos.valid_sicar_imovel USING btree (gid);
CREATE INDEX valid_sicar_imovel_valid_geom_idx2 ON dados_brutos.valid_sicar_imovel USING gist (valid_geom);

INSERT INTO dados_brutos.valid_sicar_imovel (gid_original, cod_imovel , status_imo ,
dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , valid_geom  )
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_ac
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_al
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_am
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_ap
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_ba
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_ce
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_df
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_es
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_go
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_ma
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_mg
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_ms
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_mt
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_pa
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_pb
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_pe
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_pi
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_pr
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_rj
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_rn
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_ro
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_rr
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_rs
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_sc
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_se
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_sp
UNION ALL
SELECT gid gid_original, cod_imovel , status_imo , dat_criaca , area , condicao , uf , municipio ,  cod_munici , m_fiscal , tipo_imove , ST_MAkeValid(geom) valid_geom 
FROM dados_brutos.sicar_imoveis_to
