CREATE TABLE irregularidades.proc1_step14_area_raw 
(
cat_fund TEXT NULL,
car bigint NULL,
desmatamento int NULL,
count int NULL
);

INSERT INTO irregularidades.step14_area_raw (cat_fund, car, desmatamento, count)
SELECT cat_fund, car, desmatamento, count FROM public.proc1_area_raw 