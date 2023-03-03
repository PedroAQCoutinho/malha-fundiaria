DROP TABLE IF EXISTS irregularidades.proc3_step14_ano_ocupacao;
CREATE TABLE irregularidades.proc3_step14_ano_ocupacao (
gid bigint null, 
desmatamento int null, 
is_recente boolean null
);


CREATE INDEX proc3_step14_ano_ocupacao_gid_idx ON irregularidades.proc3_step14_ano_ocupacao USING btree (gid);

