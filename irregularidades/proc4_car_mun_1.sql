CREATE TABLE irregularidades.step14_car_mun
(
gid int NULL,
cd_mun int null
);

CREATE INDEX step14_car_mun_gid_idx ON irregularidades.step14_car_mun USING btree (gid);
CREATE INDEX step14_car_mun_cd_mun_idx ON irregularidades.step14_car_mun USING btree (cd_mun);
