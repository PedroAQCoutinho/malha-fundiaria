INSERT INTO malhav2.proc5_malha
SELECT a.gid, cd_mun, a.original_gid , a.original_layer , a.cd_grid, area,  
CASE 
	WHEN 'CAR' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_car,
CASE 
	WHEN 'FF' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_faixafronteira,
CASE 
	WHEN 'MI' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_militar,
CASE 
	WHEN 'MD' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_massadagua,
CASE 
	WHEN 'QUI' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_quilombola,
CASE 
	WHEN 'UCPI' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_ucpi,
CASE 
	WHEN 'UCUS' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_ucus,
CASE 
	WHEN 'UCUSAPA' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_ucusapa,
CASE 
	WHEN 'TI' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_ti,
CASE 
	WHEN 'TERRALEG' = ANY(original_layer) THEN TRUE
	WHEN 'SIGEFPRIV' = ANY(original_layer) THEN TRUE
	WHEN 'SNCIPRIV' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_imovel,
CASE 
	WHEN 'GLEBAEST' = ANY(original_layer) THEN TRUE
	WHEN 'GLEBAFED' = ANY(original_layer) THEN TRUE
	WHEN 'SIGEFPUB' = ANY(original_layer) THEN TRUE
	WHEN 'SNCIPUB' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_gleba,
CASE 
	WHEN 'ASSENREC' = ANY(original_layer) THEN TRUE
	WHEN 'ASSENFED' = ANY(original_layer) THEN TRUE
	ELSE FALSE
END is_assentamento,
anyarray_sort(anyarray_uniq(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(
array_replace(array_remove(array_remove(array_remove(original_layer, 'FF'),'CAR'), 'MD'), 'ASSENREC', 'ASSEN'), 
'ASSENFED', 'ASSEN'),
'GLEBAEST', 'GLEBA'),
'GLEBAFED', 'GLEBA'), 
'SIGEFPUB', 'GLEBA'), 
'SNCIPUB', 'GLEBA'), 
'TERRALEG', 'IMOVEL'), 
'SIGEFPRIV', 'IMOVEL'), 
'SNCIPRIV', 'IMOVEL'))) original_layer_label,
geom
FROM malhav2.proc2_malhav2 a 
LEFT JOIN LATERAL (
SELECT * FROM malhav2.proc4_unnest pu WHERE  pu.gid = a.gid
) foo ON TRUE 
WHERE (a.gid % :var_num_proc) = :var_proc




