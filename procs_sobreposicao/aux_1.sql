
-- Interesse da uniao
\echo Interesse da uniao
\echo   

-- 
DROP TABLE IF EXISTS outputs.step14_overlay;
CREATE TABLE outputs.step14_overlay
(
  gid serial NOT null,
  cd_mun integer NULL, 
  cd_bioma integer NULL,
  am_legal BOOLEAN NULL,
  original_gid integer[] NULL,
  original_layer integer[] NULL,
  is_ti boolean NULL,
  is_qui boolean NULL,
  is_assenfed boolean NULL,
  is_assenrec BOOLEAN NULL,
  is_ucus BOOLEAN NULL,
  is_ucpi BOOLEAN NULL,
  is_glebaest BOOLEAN NULL,
  is_glebafed BOOLEAN NULL,
  is_sigefpub BOOLEAN NULL,
  is_sncipub BOOLEAN NULL,
  is_sigefpriv BOOLEAN NULL,
  is_sncipriv BOOLEAN NULL,
  is_terralegal BOOLEAN NULL,
  is_interesse_uniao BOOLEAN NULL,
  geom geometry NULL
);


CREATE INDEX step14_overlay_original_gid_idx ON outputs.step14_overlay USING btree (original_gid);
CREATE INDEX step14_overlay_cd_mun_idx ON outputs.step14_overlay USING btree (cd_mun);
CREATE INDEX step14_overlay_original_layer_idx ON outputs.step14_overlay USING btree (original_layer);
CREATE INDEX step14_overlay_geom_idx ON outputs.step14_overlay USING gist (geom);
CREATE INDEX step14_overlay_gid_idx ON outputs.step14_overlay USING btree (gid);
CREATE INDEX step14_overlay_cd_bioma_idx ON outputs.step14_overlay USING btree (cd_bioma);


\echo  