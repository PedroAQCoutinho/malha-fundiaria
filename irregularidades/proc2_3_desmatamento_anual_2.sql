\echo RUN proc23_step14_desmatamento_anual :var_proc
-- Essa tabela é com dupla contagem por conta do unnest
INSERT INTO irregularidades.proc23_step14_desmatamento_anual (
cat_fund, iscar, gid_car, car, ano, area_count, cd_grid, cd_mun, am_legal, cd_bioma, nm_agrup, nm_cat_fund, orilabel)
SELECT cat_fund, iscar, gid_car, UNNEST(original_gid) car, 
ano, area_count,  cd_grid , cd_mun, am_legal, cd_bioma , nm_agrup, nm_cat_fund, orilabel
FROM irregularidades.proc22_step14_desmatamento_anual a 
WHERE (a.cat_fund % :var_num_proc) = :var_proc

