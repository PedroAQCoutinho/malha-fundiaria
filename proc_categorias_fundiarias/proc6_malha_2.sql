\echo RUN proc6_malha :var_proc


INSERT INTO malhav2.proc6_malha (gid,original_gid ,original_layer,cd_grid,area, is_car,is_faixafronteira,is_militar,
is_massadagua,is_quilombola,is_ucpi,is_ucus,is_ucusapa,is_ti,is_imovel,is_gleba,is_assentamento,
original_layer_label,nm_cat_fund,nm_agrup,geom)
SELECT gid, original_gid, a.original_layer, cd_grid, area, is_car, is_faixafronteira,
is_militar, is_massadagua, is_quilombola, is_ucpi, is_ucus, is_ucusapa, is_ti, is_imovel,
is_gleba, is_assentamento, original_layer_label, nm_cat_fund, nm_agrup, geom
FROM malhav2.proc5_malha a 
LEFT JOIN auxiliares.nomenclatura_categorias_e_agrupamentos_fundiarios b 
ON a.original_layer_label = b.original_layer
WHERE (a.gid % :var_num_proc) = :var_proc