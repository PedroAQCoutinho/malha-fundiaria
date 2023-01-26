DROP TABLE IF EXISTS layer_fundiario.step15_agregado;
CREATE TABLE layer_fundiario.step15_agregado AS 
SELECT cd_bioma, cd_mun, array_to_string(original_layer_label, ',') original_layer_label, sum(ST_Area(geom::geography)) area, ST_Union(st_force2d(geom)) geom 
FROM outputs.step15_overlay so 
LEFT JOIN layer_fundiario.step15_id_label sil USING (gid) 
WHERE am_legal GROUP BY cd_bioma, cd_mun, original_layer_label

CREATE INDEX step15_id_label_cd_bioma_idx ON layer_fundiario.step15_id_label USING btree (cd_bioma);
CREATE INDEX step15_id_label_cd_mun_idx ON layer_fundiario.step15_id_label USING btree (cd_mun);
CREATE INDEX step15_id_label_original_layer_label_idx ON layer_fundiario.step15_id_label USING btree (original_layer_label);
CREATE INDEX step15_id_label_geom_idx ON layer_fundiario.step15_id_label USING gist (geom);
CREATE INDEX step15_id_label_area_idx ON layer_fundiario.step15_id_label USING btree (area);
