-- Para a car é preciso saber se ele está em local restritivo ou nao à regularizacao fundiaria
-- Para isso verificamos que pelo menos 10% da propriedade está em área restrita
-- Area restrita: nm_agrup = 'publica_afetada' OR nm_agrup = 'publica_afetada__imovel_rural_privado' OR nm_agrup = 'publica afetada_coletiva_privada' OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada'
DROP TABLE IF EXISTS irregularidades.proc6_step14_local_restrito;
CREATE TABLE irregularidades.proc6_step14_local_restrito (

car int null, 
is_local_restrito boolean NULL,
area_imovel decimal NULL,
m_fiscal int NULL, 
cat_fund_irregular TEXT NULL,
original_layer_label_irregular text[] NULL ,
nm_cat_fund_irregular TEXT NULL,
nm_agrup_irregular TEXT NULL

);


CREATE INDEX proc6_step14_local_restrito_car_idx ON irregularidades.proc6_step14_local_restrito USING btree (car);
CREATE INDEX proc6_step14_local_restrito_m_fiscal_idx ON irregularidades.proc6_step14_local_restrito USING btree (m_fiscal);
CREATE INDEX proc6_step14_local_restrito_cat_fund_irregular_idx ON irregularidades.proc6_step14_local_restrito USING btree (cat_fund_irregular);
CREATE INDEX proc6_step14_local_restrito_original_layer_label_irregular_idx ON irregularidades.proc6_step14_local_restrito USING btree (original_layer_label_irregular);
CREATE INDEX proc6_step14_local_restrito_nm_cat_fund_irregular_idx ON irregularidades.proc6_step14_local_restrito USING btree (nm_cat_fund_irregular);
CREATE INDEX proc6_step14_local_restrito_nm_agrup_irregular_idx ON irregularidades.proc6_step14_local_restrito USING btree (nm_agrup_irregular);



