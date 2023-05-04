CREATE TABLE malhav2.proc5_malha (
	gid serial4 NOT NULL,
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
    original_layer_label _text NULL
    nm_cat_fund text null,
    nm_agrup text null,
	geom public.geometry NULL
);


CREATE INDEX proc5_malha_cd_grid_idx ON malhav2.proc5_malha USING btree (cd_grid);
CREATE INDEX proc5_malha_geom_idx ON malhav2.proc5_malha USING gist (geom);
CREATE INDEX proc5_malha_gid_idx ON malhav2.proc5_malha USING btree (gid);
