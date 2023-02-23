CREATE TABLE irregularidades.proc61_step14_cat_fund AS 
SELECT cat_fund, car, desmatamento , area_desmatamento , am_legal , cd_bioma, cd_mun , nm_cat_fund , nm_agrup , vsi.area 
FROM irregularidades.proc2_step14_desmatamento_anual a 
LEFT JOIN dados_brutos.valid_sicar_imovel vsi ON vsi.gid = a.car 



CREATE INDEX proc61_step14_cat_fund_car_idx ON irregularidades.proc61_step14_cat_fund USING btree (car);
CREATE INDEX proc61_step14_cat_fund_cat_fund_idx ON irregularidades.proc61_step14_cat_fund USING btree (cat_fund);
CREATE INDEX proc61_step14_cat_fund_nm_agrup_idx ON irregularidades.proc61_step14_cat_fund USING btree (nm_agrup);




CREATE TABLE irregularidades.proc62_step14_cat_fund AS 
WITH foo AS (SELECT car, nm_agrup, sum(area_desmatamento) area_desmatamento, avg(area) area 
FROM irregularidades.proc61_step14_cat_fund a 
GROUP BY car, nm_agrup)
SELECT car, nm_agrup , max(area_desmatamento) area_sobrep FROM foo GROUP BY car, nm_agrup


CREATE INDEX proc62_step14_cat_fund_car_idx ON irregularidades.proc62_step14_cat_fund USING btree (car);
CREATE INDEX proc62_step14_cat_fund_nm_agrup_idx ON irregularidades.proc62_step14_cat_fund USING btree (nm_agrup);



DROP TABLE IF EXISTS irregularidades.proc63_step14_cat_fund;
CREATE TABLE irregularidades.proc63_step14_cat_fund AS 
SELECT gid car, am_legal, cd_bioma, cd_mun, tipo_imove, ST_CollectionExtract(st_force2d(st_makevalid(valid_geom)), 3) geom FROM dados_brutos.valid_sicar_imovel a , LATERAL (
SELECT am_legal, cd_bioma, cd_mun FROM irregularidades.proc2_step14_desmatamento_anual psda ORDER BY area_desmatamento LIMIT 1
) foo


CREATE INDEX proc63_step14_cat_fund_car_idx ON irregularidades.proc63_step14_cat_fund USING btree (car);
CREATE INDEX proc63_step14_cat_fund_geom_idx ON irregularidades.proc63_step14_cat_fund USING btree (geom);
