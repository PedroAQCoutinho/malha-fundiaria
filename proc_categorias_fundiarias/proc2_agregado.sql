DROP TABLE IF EXISTS layer_fundiario.step2_agregado;
CREATE TABLE layer_fundiario.step2_agregado AS 
SELECT cd_bioma, cd_mun, array_to_string(original_layer_label, ',') original_layer_label, sum(ST_Area(geom::geography)) area, ST_Union(st_force2d(geom)) geom 
FROM outputs.step14_overlay so 
LEFT JOIN layer_fundiario.step1_id_label sil USING (gid) 
WHERE am_legal GROUP BY cd_bioma, cd_mun, original_layer_label

CREATE INDEX step2_agregado_cd_bioma_idx ON layer_fundiario.step2_agregado USING btree (cd_bioma);
CREATE INDEX step2_agregado_cd_mun_idx ON layer_fundiario.step2_agregado USING btree (cd_mun);
CREATE INDEX step2_agregado_original_layer_label_idx ON layer_fundiario.step2_agregado USING btree (original_layer_label);
CREATE INDEX step2_agregado_geom_idx ON layer_fundiario.step2_agregado USING gist (geom);
CREATE INDEX step2_agregado_area_idx ON layer_fundiario.step2_agregado USING btree (area);

