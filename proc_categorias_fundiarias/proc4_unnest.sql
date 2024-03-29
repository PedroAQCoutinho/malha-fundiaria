\echo RUN proc4_unnest

DROP TABLE malhav2.proc4_unnest_v3;
CREATE TABLE malhav2.proc4_unnest_v3 AS 
SELECT sub.gid, sub.cd_grid, cd_mun , am_legal
FROM (SELECT gid, cd_grid, UNNEST(original_gid) original_gid, UNNEST(original_layer) original_layer FROM malhav2.proc2_malhav2 d) sub 
LEFT JOIN grid.adm2_overlay ao ON sub.original_gid = ao.gid
WHERE original_layer = 'GRID';




CREATE INDEX proc4_unnest_v3_gid_idx ON malhav2.proc4_unnest_v3 USING btree (gid);
CREATE INDEX proc4_unnest_v3_cd_grid_idx ON malhav2.proc4_unnest_v3 USING btree (cd_grid);
CREATE INDEX proc4_unnest_v3_cd_mun_idx ON malhav2.proc4_unnest_v3 USING btree (cd_mun);