\echo proc_1


DROP TABLE IF EXISTS irregularidades.proc3_step14_ano_ocupacaov2;
CREATE TABLE irregularidades.proc3_step14_ano_ocupacaov2 (
gid bigint null, 
desmatamento int null, 
is_recente boolean null
);


CREATE INDEX proc3_step14_ano_ocupacaov2_gid_idx ON irregularidades.proc3_step14_ano_ocupacaov2 USING btree (gid);

