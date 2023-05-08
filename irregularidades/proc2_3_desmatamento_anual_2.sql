\echo RUN proc23_malha_uso_anual :var_proc
-- Essa tabela é com dupla contagem por conta do unnest
INSERT INTO irregularidades.proc23_malha_uso_anual (
cat_fund, iscar, gid_car, car, uso, area_count, cd_grid, cd_mun, am_legal, cd_bioma, nm_agrup, nm_cat_fund, orilabel)
SELECT cat_fund, iscar, gid_car, UNNEST(original_gid) car, 
uso, area_count,  cd_grid , cd_mun, am_legal, cd_bioma , nm_agrup, nm_cat_fund, orilabel
FROM irregularidades.proc22_malha_uso_anual a 
WHERE (a.cat_fund % :var_num_proc) = :var_proc

