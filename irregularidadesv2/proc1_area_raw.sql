\echo area raw

DROP TABLE irregularidadesv2.proc1_count;
CREATE TABLE irregularidadesv2.proc1_count 
(
cat_fund int NULL,
desmatamento int NULL,
uso int NULL,
area float8 NULL
);

CREATE INDEX proc1_count_desmatamento_idx ON irregularidadesv2.proc1_count USING btree (desmatamento);
CREATE INDEX proc1_count_cat_fund_idx ON irregularidadesv2.proc1_count USING btree (cat_fund);
CREATE INDEX proc1_count_uso_idx ON irregularidadesv2.proc1_count USING btree (uso);


INSERT INTO irregularidadesv2.proc1_count (cat_fund, desmatamento, uso, area)
SELECT cat_fund, desmatamento, uso, count*0.087 FROM public.proc1_row_by_row_mapbiomas_15052023
