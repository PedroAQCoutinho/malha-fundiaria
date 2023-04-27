

SELECT nm_agrup, CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento > 0 AND desmatamento < 9 THEN 2 ELSE 3 END isdesmatamento, sum(count)*0.087 area 
FROM irregularidades.proc1_step14_area_raw psar 
LEFT JOIN layer_fundiario.proc4_step14_id_label psil ON psar.cat_fund = psil.gid 
WHERE car IS NULL AND am_legal
GROUP BY nm_agrup, CASE WHEN desmatamento = 0 THEN 0 WHEN desmatamento > 0 AND desmatamento < 9 THEN 2 ELSE 3 END
HAVING nm_agrup IN ('glebas_publicas', 'vazio')




--vazios  total
SELECT 20806380.774+4556489.280+729837.606;
--vazios  desmatado
SELECT 4556489.280+729837.606;



--gleba  total
SELECT 30953944.542+2140221.054+682584.687;
--gleba  desmatado
SELECT 2140221.054+682584.687;

