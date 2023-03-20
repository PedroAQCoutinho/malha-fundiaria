DROP TABLE IF EXISTS layer_fundiario.proc4_step14_id_label;
CREATE TABLE layer_fundiario.proc4_step14_id_label (
	gid int4 NULL,
	original_layer text[] NULL,
	am_legal bool NULL,
	cd_bioma int4 NULL,
	cd_mun int4 NULL,
	area float8 NULL,
	orilayer integer[] NULL,
	orilabel text[] NULL,
	nm_agrup text NULL,
	nm_cat_fund text NULL,
	geom public.geometry NULL
);


CREATE INDEX proc4_step14_id_label_gid_idx ON layer_fundiario.proc4_step14_id_label USING btree (gid);
CREATE INDEX proc4_step14_id_label_original_layer_idx ON layer_fundiario.proc4_step14_id_label USING btree (original_layer);
CREATE INDEX proc4_step14_id_label_am_legal_idx ON layer_fundiario.proc4_step14_id_label USING btree (am_legal);
CREATE INDEX proc4_step14_id_label_cd_bioma_idx ON layer_fundiario.proc4_step14_id_label USING btree (cd_bioma);
CREATE INDEX proc4_step14_id_label_orilayer_idx ON layer_fundiario.proc4_step14_id_label USING btree (orilayer);
CREATE INDEX proc4_step14_id_label_orilabel_idx ON layer_fundiario.proc4_step14_id_label USING btree (orilabel);
CREATE INDEX proc4_step14_id_label_nm_agrup_idx ON layer_fundiario.proc4_step14_id_label USING btree (nm_agrup);
CREATE INDEX proc4_step14_id_label_nm_cat_fund_idx ON layer_fundiario.proc4_step14_id_label USING btree (nm_cat_fund);
CREATE INDEX proc4_step14_id_label_geom_idx ON layer_fundiario.proc4_step14_id_label USING gist (geom);


INSERT INTO layer_fundiario.proc4_step14_id_label 
SELECT a.gid, original_layer, am_legal, cd_bioma, cd_mun, ST_Area(geom::geography)/10000 area ,  orilayer, orilabel, nm_agrup , nm_cat_fund, st_collectionextract(geom, 3) geom FROM layer_fundiario.proc1_limpeza_duplicados a
LEFT JOIN layer_fundiario.categorias_fundiarias_unicas b ON orilabel = anyarray_sort
LEFT JOIN auxiliares.step14_chave_agrupamento c ON b.id_agrup::int = c.id_agrup
LEFT JOIN auxiliares.step14_chave_categorias_limpas d ON b.id_cat_fund::int = d.id_cat_fund
LEFT JOIN outputs.step14_overlay e ON a.gid = e.gid
WHERE NOT ST_IsEmpty(geom);