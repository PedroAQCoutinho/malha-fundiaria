CREATE TABLE layer_fundiario.proc3_step14_id_label as
SELECT a.gid, original_layer, am_legal, cd_bioma, cd_mun, ST_Area(geom::geography)/10000 area ,  orilayer, orilabel, nm_agrup , nm_cat_fund, st_collectionextract(geom, 3) geom FROM layer_fundiario.proc1_limpeza_duplicados a
LEFT JOIN layer_fundiario.categorias_fundiarias_unicas b ON orilabel = anyarray_sort
LEFT JOIN auxiliares.step14_chave_agrupamento c ON b.id_agrup::int = c.id_agrup
LEFT JOIN auxiliares.step14_chave_categorias_limpas d ON b.id_cat_fund::int = d.id_cat_fund
LEFT JOIN outputs.step14_overlay e ON a.gid = e.gid
WHERE NOT ST_IsEmpty(geom)


CREATE INDEX proc3_step14_id_label_cd_bioma_idx ON layer_fundiario.proc3_step14_id_label USING btree (cd_bioma);
CREATE INDEX proc3_step14_id_label_cd_mun_idx ON layer_fundiario.proc3_step14_id_label USING btree (cd_mun);
CREATE INDEX proc3_step14_id_label_orilabel_idx ON layer_fundiario.proc3_step14_id_label USING btree (orilabel);
CREATE INDEX proc3_step14_id_label_geom_idx ON layer_fundiario.proc3_step14_id_label USING gist (geom);


