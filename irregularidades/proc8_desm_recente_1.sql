\echo proc_1

DROP TABLE IF EXISTS irregularidades.proc8_step14_desmatamento_recente;
CREATE TABLE irregularidades.proc8_step14_desmatamento_recente (
gid bigint null, 
desmatamento int null, 
is_desm_recente boolean null
);


CREATE INDEX proc8_step14_desmatamento_recente_gid_idx ON irregularidades.proc8_step14_desmatamento_recente USING btree (gid);

