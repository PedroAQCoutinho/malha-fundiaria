

INSERT INTO irregularidades.proc8_area_antrop (gid, desmatamento, is_desm_recente)
SELECT gid, ano, CASE WHEN ano <= 8 THEN FALSE WHEN ano > 8 THEN FALSE END is_desm_recente
FROM dados_brutos.valid_sicar_imovel a, LATERAL 
(SELECT * FROM irregularidades.proc23_malha_uso_anual b 
WHERE a.gid = b.car AND ano != 0  ORDER BY gid_car, ano DESC LIMIT 1) foo
WHERE (a.gid % :var_num_proc) = :var_proc


