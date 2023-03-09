-- Essa tabela não possui duplas contagens (não foi realizado o unnest) e será usada para calcular aŕeas
CREATE TABLE proc22_step14_desmatamento_anual AS 
SELECT cat_fund, CASE WHEN car IS NOT NULL THEN 1 ELSE 0 END iscar, car gid_car, original_gid, 
desmatamento ano,a.area area_count,  cd_grid, c.cd_mun, c.am_legal, c.cd_bioma , nm_agrup, nm_cat_fund, orilabel
FROM irregularidades.proc21_step14_desmatamento_anual a
LEFT JOIN car.proc2_array_agg b ON car = gid
LEFT JOIN layer_fundiario.proc3_step14_id_label c ON c.gid = cat_fund 

CREATE INDEX proc22_step14_desmatamento_anual_car_idx ON irregularidades.proc22_step14_desmatamento_anual USING btree (car);
CREATE INDEX proc22_step14_desmatamento_anual_cat_fund_idx ON irregularidades.proc22_step14_desmatamento_anual USING btree (cat_fund);
CREATE INDEX proc22_step14_desmatamento_anual_original_layer_label_idx ON irregularidades.proc22_step14_desmatamento_anual USING btree (orilabel);
CREATE INDEX proc22_step14_desmatamento_anual_nm_cat_fund_idx ON irregularidades.proc22_step14_desmatamento_anual USING btree (nm_cat_fund);
CREATE INDEX proc22_step14_desmatamento_anual_nm_agrup_idx ON irregularidades.proc22_step14_desmatamento_anual USING btree (nm_agrup);

