\echo area antrop

DROP TABLE IF EXISTS irregularidades.proc8_area_antrop;
CREATE TABLE irregularidades.proc8_area_antrop (
gid bigint null, 
desmatamento int null, 
is_desm_recente boolean null
);


CREATE INDEX proc8_area_antrop_gid_idx ON irregularidades.proc8_area_antrop USING btree (gid);

