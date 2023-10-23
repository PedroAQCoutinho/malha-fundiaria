\echo RUN proc5_malha_v3_1

DROP TABLE malhav2.proc6_malha_v3;
CREATE TABLE malhav2.proc6_malha_v3 (
	gid serial4 NOT NULL,
    cd_mun integer NULL,
	original_gid _int4 NULL,
	original_layer _text NULL,
	cd_grid int4 NULL,
	area numeric NULL,
    am_legal boolean null ,
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
    is_gleba_fed boolean null,
    is_gleba_est boolean null,
    is_assentamento boolean null,
    original_layer_label _text NULL,
	geom public.geometry NULL
);


CREATE INDEX proc5_malha_v3_cd_grid_idx ON malhav2.proc6_malha_v3 USING btree (cd_grid);
CREATE INDEX proc5_malha_v3_geom_idx ON malhav2.proc6_malha_v3 USING gist (geom);
CREATE INDEX proc5_malha_v3_gid_idx ON malhav2.proc6_malha_v3 USING btree (gid);
CREATE INDEX proc5_malha_v3_original_layer_label_idx ON malhav2.proc5_malha_v3 USING btree (original_layer_label);
