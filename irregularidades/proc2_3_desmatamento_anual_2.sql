\echo RUN proc23_malha_uso_anual :var_proc
-- Essa tabela é com dupla contagem por conta do unnest
INSERT INTO irregularidades.proc23_malha_uso_anual (
cat_fund, iscar, id_car_break, car, uso, area_count, cd_grid, cd_mun, nm_agrup, nm_cat_fund)
SELECT cat_fund, iscar, id_car_break, UNNEST(original_gid) car, 
uso, area_count,  cd_grid , cd_mun, nm_agrup, nm_cat_fund
FROM irregularidades.proc22_malha_uso_anual a 
WHERE (a.cat_fund % :var_num_proc) = :var_proc

