\echo RUN proc6_malha :var_proc



INSERT INTO malhav2.proc6_malha (gid, cd_mun, am_legal, original_gid ,original_layer,cd_grid,area, is_car,is_faixafronteira,is_militar,
is_massadagua,is_quilombola,is_ucpi,is_ucus,is_ucusapa,is_ti,is_imovel,is_gleba,is_assentamento,
original_layer_label,nm_cat_fund,nm_agrup,floresta, pfloresta, agropecuario, pagropecuario,
nao_vegetada, pnao_vegetada, corpo_dagua,  pcorpo_dagua, geom)
WITH foo AS (SELECT
  cat_fund,
  SUM(CASE WHEN uso IN (1,3,4,5,49,10,11,12,32,29,50,13) THEN count ELSE 0 END)*0.087 AS floresta,
  sum(CASE WHEN uso IN (14,15,18,19,39,20,40,62,41,36,46,47,48,9,21) THEN count ELSE 0 END)*0.087 AS agropecuario,
  sum(CASE WHEN uso IN (22,23,24,30,25) THEN count ELSE 0 END)*0.087 AS nao_vegetada,
  sum(CASE WHEN uso IN (26,33,31,27) THEN count ELSE 0 END)*0.087 AS corpo_dagua
  FROM public.proc1_row_by_row_mapbiomas_15052023 prbrm 
GROUP BY cat_fund)
SELECT gid, cd_mun, am_legal, original_gid, a.original_layer, cd_grid, area, is_car, is_faixafronteira,
is_militar, is_massadagua, is_quilombola, is_ucpi, is_ucus, is_ucusapa, is_ti, is_imovel,
is_gleba, is_assentamento, original_layer_label, nm_cat_fund, nm_agrup, 
floresta, 
floresta/area pfloresta, agropecuario, 
agropecuario/area pagropecuario,
nao_vegetada, 
nao_vegetada/area pnao_vegetada, 
corpo_dagua,  
corpo_dagua/area pcorpo_dagua, geom
FROM malhav2.proc5_malha a 
LEFT JOIN auxiliares.nomenclatura_categorias_e_agrupamentos_fundiarios b 
ON a.original_layer_label = b.original_layer
LEFT JOIN foo ON foo.cat_fund = a.gid 

