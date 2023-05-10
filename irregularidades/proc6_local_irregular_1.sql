-- Para a car é preciso saber se ele está em local restritivo ou nao à regularizacao fundiaria
-- Para isso verificamos que pelo menos 10% da propriedade está em área restrita
-- Area restrita: nm_agrup = 'publica_afetada' OR nm_agrup = 'publica_afetada__imovel_rural_privado' OR nm_agrup = 'publica afetada_coletiva_privada' OR nm_agrup = 'publica imovel_privado_coletivo_publica_destinada'
\echo local irregular

DROP TABLE IF EXISTS irregularidades.proc6_malha_local_restrito;
CREATE TABLE irregularidades.proc6_malha_local_restrito (

car int null, 
is_local_restrito boolean NULL

);


CREATE INDEX proc6_malha_local_restrito_car_idx ON irregularidades.proc6_malha_local_restrito USING btree (car);


DROP TABLE irregularidades.temp_area_restrita;
CREATE TABLE irregularidades.temp_area_restrita as 
SELECT original_gid, nm_agrup, area
FROM (SELECT original_gid, nm_agrup, sum(area) area
FROM (SELECT gid, cd_grid, UNNEST(original_gid) original_gid, UNNEST(original_layer) original_layer, nm_agrup, area FROM malhav2.proc6_malha d 
WHERE am_legal) sub 
WHERE original_layer = 'CAR' AND nm_agrup = 'area_restrita'
GROUP BY original_gid , nm_agrup) foo2;


CREATE INDEX temp_area_restrita_original_gid_irregular_idx ON irregularidades.temp_area_restrita USING btree (original_gid);
CREATE INDEX temp_area_restrita_nm_agrup_irregular_idx ON irregularidades.temp_area_restrita USING btree (nm_agrup);
CREATE INDEX temp_area_restrita_area_idx ON irregularidades.temp_area_restrita USING btree (area);