\echo area raw


DROP TABLE irregularidades.proc1_malhav2;
CREATE TABLE irregularidades.proc1_malhav2 
(
cat_fund int NULL,
car bigint NULL,
uso int NULL,
count int NULL
);

CREATE INDEX proc1_malhav2_car_idx ON irregularidades.proc1_malhav2 USING btree (car);
CREATE INDEX proc1_malhav2_cat_fund_idx ON irregularidades.proc1_malhav2 USING btree (cat_fund);
CREATE INDEX proc1_malhav2_uso_idx ON irregularidades.proc1_malhav2 USING btree (uso);


INSERT INTO irregularidades.proc1_malhav2 (cat_fund, car, uso, count)
SELECT cat_fund, car, uso, count FROM public.proc1_row_by_row_mapbiomas
WHERE cat_fund IS NOT NULL