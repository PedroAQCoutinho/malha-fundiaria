
DROP TABLE IF EXISTS malhav2.proc2_malhav3;
CREATE TABLE malhav2.proc2_malhav2 (

gid serial NOT null,
original_gid int[] null,
original_layer text[] null,
cd_mun integer null,
cd_bioma integer null,
cd_grid integer null, 
area decimal null,
geom geometry null


);

CREATE INDEX proc2_malhav3_gid_idx ON malhav2.proc2_malhav3 USING btree (gid);
CREATE INDEX proc2_malhav3_geom_idx ON malhav2.proc2_malhav3 USING GIST (geom);
CREATE INDEX proc2_malhav3_cd_mun_idx ON malhav2.proc2_malhav3 USING btree (cd_mun);
CREATE INDEX proc2_malhav3_cd_grid_idx ON malhav2.proc2_malhav3 USING btree (cd_grid);
CREATE INDEX proc2_malhav3_cd_bioma_idx ON malhav2.proc2_malhav3 USING btree (cd_bioma);



DROP TABLE IF EXISTS malhav2.aux_distinct;
CREATE TABLE malhav2.aux_distinct (
cd_grid integer
);

CREATE INDEX aux_distinct_cd_grid_idx ON malhav2.aux_distinct USING btree (cd_grid);












