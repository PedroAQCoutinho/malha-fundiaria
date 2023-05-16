\echo starting proc6


DROP TABLE malhav2.proc6_malha;
CREATE TABLE malhav2.proc6_malha (
	gid serial4 NOT NULL,
    cd_mun INTEGER null,
    am_legal BOOLEAN NULL,
	original_gid _int4 NULL,
	original_layer _text NULL,
	cd_grid int4 NULL,
	area numeric NULL,
    is_car boolean null,
    is_faixafronteira boolean null,
    is_militar boolean null,
    is_massadagua boolean null,
    is_quilombola boolean null,
    is_ucpi boolean null,
    is_ucus boolean null,
    is_ucusapa boolean null,
    is_ti boolean null,
    is_imovel boolean null,
    is_gleba boolean null,
    is_assentamento boolean null,
    original_layer_label _text NULL,
    nm_cat_fund text null, 
    nm_agrup text null,
    floresta float8 NULL, 
    pfloresta float8 NULL, 
    agropecuario float8 NULL,
    pagropecuario float8 NULL,
    nao_vegetada float8 NULL,
    pnao_vegetada float8 NULL,
    corpo_dagua float8 NULL, 
    pcorpo_dagua float8 NULL, 
	geom public.geometry NULL
);


CREATE INDEX proc6_malha_cd_grid_idx ON malhav2.proc6_malha USING btree (cd_grid);
CREATE INDEX proc6_malha_geom_idx ON malhav2.proc6_malha USING gist (geom);
CREATE INDEX proc6_malha_gid_idx ON malhav2.proc6_malha USING btree (gid);
CREATE INDEX proc6_malha_original_layer_label_idx ON malhav2.proc6_malha USING btree (original_layer_label);
CREATE INDEX proc6_malha_nm_cat_fund_idx ON malhav2.proc6_malha USING btree (nm_cat_fund);
CREATE INDEX proc6_malha_nm_agrup_idx ON malhav2.proc6_malha USING btree (nm_agrup);
