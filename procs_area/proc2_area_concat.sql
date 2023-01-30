DROP TABLE IF EXISTS layer_fundiario.step14_area_cat_fund;
CREATE TABLE layer_fundiario.step14_area_cat_fund AS 
SELECT cd_bioma, am_legal, cd_mun, original_layer_label, car, desmatamento, sum(count)*0.0941 area 
FROM layer_fundiario.step14_area_raw sa LEFT JOIN layer_fundiario.step14_id_label sil ON cat_fund = gid
WHERE cat_fund != 0 
GROUP BY cd_bioma, am_legal, cd_mun, original_layer_label, car, desmatamento


CREATE INDEX step14_area_cat_fund_cd_bioma_idx ON layer_fundiario.step14_area_cat_fund USING btree (cd_bioma);
CREATE INDEX step14_area_cat_fund_cd_mun_idx ON layer_fundiario.step14_area_cat_fund USING btree (cd_mun);
CREATE INDEX step14_area_cat_fund_car_idx ON layer_fundiario.step14_area_cat_fund USING btree (car);
CREATE INDEX step14_area_cat_fund_original_layer_label_idx ON layer_fundiario.step14_area_cat_fund USING btree (original_layer_label);
CREATE INDEX step14_area_cat_fund_desmatamento_idx ON layer_fundiario.step14_area_cat_fund USING btree (desmatamento);

