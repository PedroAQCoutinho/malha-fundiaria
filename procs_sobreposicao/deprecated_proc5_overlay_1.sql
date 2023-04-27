-- Municipio x Biomas

\echo Mun + bioma
\echo  

DROP TABLE IF EXISTS outputs.adm1_overlay;
CREATE TABLE outputs.adm1_overlay
(
  gid serial NOT null,
  cd_mun integer NULL, 
  cd_bioma integer NULL,
  geom geometry NULL
);



CREATE INDEX adm1_overlay_gid_idx ON outputs.adm1_overlay USING gist (gid);
CREATE INDEX adm1_overlay_cd_bioma_idx ON outputs.adm1_overlay USING btree (cd_bioma);
CREATE INDEX adm1_overlay_cd_mun_idx ON outputs.adm1_overlay USING btree (cd_mun);
CREATE INDEX adm1_overlay_geom_idx ON outputs.adm1_overlay USING gist (geom);

\echo  

-- + Amazonia legal
\echo + am legal
\echo  


DROP TABLE IF EXISTS outputs.adm2_overlay;
CREATE TABLE outputs.adm2_overlay
(
  gid serial NOT null,
  cd_mun integer NULL, 
  cd_bioma integer NULL,
  am_legal boolean NULL,
  geom geometry NULL
);




CREATE INDEX adm2_overlay_gid_idx ON outputs.adm2_overlay USING btree (gid);
CREATE INDEX adm2_overlay_cd_bioma_idx ON outputs.adm2_overlay USING btree (cd_bioma);
CREATE INDEX adm2_overlay_cd_mun_idx ON outputs.adm2_overlay USING btree (cd_mun);
CREATE INDEX adm2_overlay_geom_idx ON outputs.adm2_overlay USING gist (geom);


\echo 


-- Terras indigenas
\echo + TIs
\echo     


-- 
DROP TABLE IF EXISTS outputs.step1_overlay;
CREATE TABLE outputs.step1_overlay
(
  gid serial NOT null,
  cd_mun integer NULL, 
  cd_bioma integer NULL,
  am_legal boolean NULL,
  original_gid integer[] NULL,
  original_layer integer[] NULL,
  is_ti boolean NULL,
  geom geometry NULL
);


CREATE INDEX step1_overlay_original_gid_idx ON outputs.step1_overlay USING btree (original_gid);
CREATE INDEX step1_overlay_cd_mun_idx ON outputs.step1_overlay USING btree (cd_mun);
CREATE INDEX step1_overlay_original_layer_idx ON outputs.step1_overlay USING btree (original_layer);
CREATE INDEX step1_overlay_geom_idx ON outputs.step1_overlay USING gist (geom);
CREATE INDEX step1_overlay_gid_idx ON outputs.step1_overlay USING btree (gid);



\echo  

-- Quilombolas
\echo + Quilombolas
\echo  

-- 
DROP TABLE IF EXISTS outputs.step2_overlay;
CREATE TABLE outputs.step2_overlay
(
  gid serial NOT null,
  cd_mun integer NULL, 
  cd_bioma integer NULL,
  am_legal BOOLEAN NULL,
  original_gid integer[] NULL,
  original_layer integer[] NULL,
  is_ti boolean NULL,
  is_qui boolean NULL,
  geom geometry NULL
);


CREATE INDEX step2_overlay_original_gid_idx ON outputs.step2_overlay USING btree (original_gid);
CREATE INDEX step2_overlay_cd_mun_idx ON outputs.step2_overlay USING btree (cd_mun);
CREATE INDEX step2_overlay_original_layer_idx ON outputs.step2_overlay USING btree (original_layer);
CREATE INDEX step2_overlay_geom_idx ON outputs.step2_overlay USING gist (geom);
CREATE INDEX step2_overlay_gid_idx ON outputs.step2_overlay USING btree (gid);
CREATE INDEX step2_overlay_cd_bioma_idx ON outputs.step2_overlay USING btree (cd_bioma);


\echo  

-- Assentamentos federais
\echo + Assentamentos federais
\echo  


-- 
DROP TABLE IF EXISTS outputs.step3_overlay;
CREATE TABLE outputs.step3_overlay
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
  geom geometry NULL
);


CREATE INDEX step3_overlay_original_gid_idx ON outputs.step3_overlay USING btree (original_gid);
CREATE INDEX step3_overlay_cd_mun_idx ON outputs.step3_overlay USING btree (cd_mun);
CREATE INDEX step3_overlay_original_layer_idx ON outputs.step3_overlay USING btree (original_layer);
CREATE INDEX step3_overlay_geom_idx ON outputs.step3_overlay USING gist (geom);
CREATE INDEX step3_overlay_gid_idx ON outputs.step3_overlay USING btree (gid);
CREATE INDEX step3_overlay_cd_bioma_idx ON outputs.step3_overlay USING btree (cd_bioma);



\echo  




-- Assentamentos reconhecimento
\echo + Assentamentos reconhecimento
\echo  

-- 
DROP TABLE IF EXISTS outputs.step4_overlay;
CREATE TABLE outputs.step4_overlay
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
  geom geometry NULL
);


CREATE INDEX step4_overlay_original_gid_idx ON outputs.step4_overlay USING btree (original_gid);
CREATE INDEX step4_overlay_cd_mun_idx ON outputs.step4_overlay USING btree (cd_mun);
CREATE INDEX step4_overlay_original_layer_idx ON outputs.step4_overlay USING btree (original_layer);
CREATE INDEX step4_overlay_geom_idx ON outputs.step4_overlay USING gist (geom);
CREATE INDEX step4_overlay_gid_idx ON outputs.step4_overlay USING btree (gid);
CREATE INDEX step4_overlay_cd_bioma_idx ON outputs.step4_overlay USING btree (cd_bioma);


\echo  




-- UCUSs
\echo + UCUSs
\echo  


-- 
DROP TABLE IF EXISTS outputs.step5_overlay;
CREATE TABLE outputs.step5_overlay
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
  geom geometry NULL
);


CREATE INDEX step5_overlay_original_gid_idx ON outputs.step5_overlay USING btree (original_gid);
CREATE INDEX step5_overlay_cd_mun_idx ON outputs.step5_overlay USING btree (cd_mun);
CREATE INDEX step5_overlay_original_layer_idx ON outputs.step5_overlay USING btree (original_layer);
CREATE INDEX step5_overlay_geom_idx ON outputs.step5_overlay USING gist (geom);
CREATE INDEX step5_overlay_gid_idx ON outputs.step5_overlay USING btree (gid);
CREATE INDEX step5_overlay_cd_bioma_idx ON outputs.step5_overlay USING btree (cd_bioma);


\echo  


-- UCPIs
\echo + UCPIs
\echo  

-- 
DROP TABLE IF EXISTS outputs.step6_overlay;
CREATE TABLE outputs.step6_overlay
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
  geom geometry NULL
);


CREATE INDEX step6_overlay_original_gid_idx ON outputs.step6_overlay USING btree (original_gid);
CREATE INDEX step6_overlay_cd_mun_idx ON outputs.step6_overlay USING btree (cd_mun);
CREATE INDEX step6_overlay_original_layer_idx ON outputs.step6_overlay USING btree (original_layer);
CREATE INDEX step6_overlay_geom_idx ON outputs.step6_overlay USING gist (geom);
CREATE INDEX step6_overlay_gid_idx ON outputs.step6_overlay USING btree (gid);
CREATE INDEX step6_overlay_cd_bioma_idx ON outputs.step6_overlay USING btree (cd_bioma);


\echo  






-- Glebas Publicas est
\echo + GlebasPublicas  est
\echo  


-- 
DROP TABLE IF EXISTS outputs.step7_overlay;
CREATE TABLE outputs.step7_overlay
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
  geom geometry NULL
);


CREATE INDEX step7_overlay_original_gid_idx ON outputs.step7_overlay USING btree (original_gid);
CREATE INDEX step7_overlay_cd_mun_idx ON outputs.step7_overlay USING btree (cd_mun);
CREATE INDEX step7_overlay_original_layer_idx ON outputs.step7_overlay USING btree (original_layer);
CREATE INDEX step7_overlay_geom_idx ON outputs.step7_overlay USING gist (geom);
CREATE INDEX step7_overlay_gid_idx ON outputs.step7_overlay USING btree (gid);
CREATE INDEX step7_overlay_cd_bioma_idx ON outputs.step7_overlay USING btree (cd_bioma);


\echo  



-- Glebas Publicas fed
\echo + GlebasPublicas  fed
\echo  

-- 
DROP TABLE IF EXISTS outputs.step8_overlay;
CREATE TABLE outputs.step8_overlay
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
  geom geometry NULL
);


CREATE INDEX step8_overlay_original_gid_idx ON outputs.step8_overlay USING btree (original_gid);
CREATE INDEX step8_overlay_cd_mun_idx ON outputs.step8_overlay USING btree (cd_mun);
CREATE INDEX step8_overlay_original_layer_idx ON outputs.step8_overlay USING btree (original_layer);
CREATE INDEX step8_overlay_geom_idx ON outputs.step8_overlay USING gist (geom);
CREATE INDEX step8_overlay_gid_idx ON outputs.step8_overlay USING btree (gid);
CREATE INDEX step8_overlay_cd_bioma_idx ON outputs.step8_overlay USING btree (cd_bioma);


\echo  




-- Sigef publico
\echo SIGEFpublico
\echo   

-- 
DROP TABLE IF EXISTS outputs.step9_overlay;
CREATE TABLE outputs.step9_overlay
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
  geom geometry NULL
);


CREATE INDEX step9_overlay_original_gid_idx ON outputs.step9_overlay USING btree (original_gid);
CREATE INDEX step9_overlay_cd_mun_idx ON outputs.step9_overlay USING btree (cd_mun);
CREATE INDEX step9_overlay_original_layer_idx ON outputs.step9_overlay USING btree (original_layer);
CREATE INDEX step9_overlay_geom_idx ON outputs.step9_overlay USING gist (geom);
CREATE INDEX step9_overlay_gid_idx ON outputs.step9_overlay USING btree (gid);
CREATE INDEX step9_overlay_cd_bioma_idx ON outputs.step9_overlay USING btree (cd_bioma);


\echo  


-- SNCI publico
\echo SNCI publico
\echo   

-- 
DROP TABLE IF EXISTS outputs.step10_overlay;
CREATE TABLE outputs.step10_overlay
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
  geom geometry NULL
);


CREATE INDEX step10_overlay_original_gid_idx ON outputs.step10_overlay USING btree (original_gid);
CREATE INDEX step10_overlay_cd_mun_idx ON outputs.step10_overlay USING btree (cd_mun);
CREATE INDEX step10_overlay_original_layer_idx ON outputs.step10_overlay USING btree (original_layer);
CREATE INDEX step10_overlay_geom_idx ON outputs.step10_overlay USING gist (geom);
CREATE INDEX step10_overlay_gid_idx ON outputs.step10_overlay USING btree (gid);
CREATE INDEX step10_overlay_cd_bioma_idx ON outputs.step10_overlay USING btree (cd_bioma);


\echo  



-- SIGEF privado
\echo SIGEF privado
\echo   

-- 
DROP TABLE IF EXISTS outputs.step11_overlay;
CREATE TABLE outputs.step11_overlay
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
  geom geometry NULL
);


CREATE INDEX step11_overlay_original_gid_idx ON outputs.step11_overlay USING btree (original_gid);
CREATE INDEX step11_overlay_cd_mun_idx ON outputs.step11_overlay USING btree (cd_mun);
CREATE INDEX step11_overlay_original_layer_idx ON outputs.step11_overlay USING btree (original_layer);
CREATE INDEX step11_overlay_geom_idx ON outputs.step11_overlay USING gist (geom);
CREATE INDEX step11_overlay_gid_idx ON outputs.step11_overlay USING btree (gid);
CREATE INDEX step11_overlay_cd_bioma_idx ON outputs.step11_overlay USING btree (cd_bioma);


\echo  



-- SNCI privado
\echo SNCI privado
\echo   

-- 
DROP TABLE IF EXISTS outputs.step12_overlay;
CREATE TABLE outputs.step12_overlay
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
  geom geometry NULL
);


CREATE INDEX step12_overlay_original_gid_idx ON outputs.step12_overlay USING btree (original_gid);
CREATE INDEX step12_overlay_cd_mun_idx ON outputs.step12_overlay USING btree (cd_mun);
CREATE INDEX step12_overlay_original_layer_idx ON outputs.step12_overlay USING btree (original_layer);
CREATE INDEX step12_overlay_geom_idx ON outputs.step12_overlay USING gist (geom);
CREATE INDEX step12_overlay_gid_idx ON outputs.step12_overlay USING btree (gid);
CREATE INDEX step12_overlay_cd_bioma_idx ON outputs.step12_overlay USING btree (cd_bioma);


\echo  


-- Terra legal
\echo Terra legal
\echo   

-- 
DROP TABLE IF EXISTS outputs.step13_overlay;
CREATE TABLE outputs.step13_overlay
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
  geom geometry NULL
);


CREATE INDEX step13_overlay_original_gid_idx ON outputs.step13_overlay USING btree (original_gid);
CREATE INDEX step13_overlay_cd_mun_idx ON outputs.step13_overlay USING btree (cd_mun);
CREATE INDEX step13_overlay_original_layer_idx ON outputs.step13_overlay USING btree (original_layer);
CREATE INDEX step13_overlay_geom_idx ON outputs.step13_overlay USING gist (geom);
CREATE INDEX step13_overlay_gid_idx ON outputs.step13_overlay USING btree (gid);
CREATE INDEX step13_overlay_cd_bioma_idx ON outputs.step13_overlay USING btree (cd_bioma);


\echo  



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




-- Massas dagua
\echo Massas dagua
\echo   

-- 
DROP TABLE IF EXISTS outputs.step15_overlay;
CREATE TABLE outputs.step15_overlay
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
  is_massas_dagua BOOLEAN NULL,
  geom geometry NULL
);


CREATE INDEX step15_overlay_original_gid_idx ON outputs.step15_overlay USING btree (original_gid);
CREATE INDEX step15_overlay_cd_mun_idx ON outputs.step15_overlay USING btree (cd_mun);
CREATE INDEX step15_overlay_original_layer_idx ON outputs.step15_overlay USING btree (original_layer);
CREATE INDEX step15_overlay_geom_idx ON outputs.step15_overlay USING gist (geom);
CREATE INDEX step15_overlay_gid_idx ON outputs.step15_overlay USING btree (gid);
CREATE INDEX step15_overlay_cd_bioma_idx ON outputs.step15_overlay USING btree (cd_bioma);


\echo  



-- Faixa de fronteira
\echo faixa de fronteira
\echo   

-- 
DROP TABLE IF EXISTS outputs.step16_overlay;
CREATE TABLE outputs.step16_overlay
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
  is_massas_dagua BOOLEAN NULL,
  is_fronteira BOOLEAN NULL,
  geom geometry NULL
);


CREATE INDEX step16_overlay_original_gid_idx ON outputs.step16_overlay USING btree (original_gid);
CREATE INDEX step16_overlay_cd_mun_idx ON outputs.step16_overlay USING btree (cd_mun);
CREATE INDEX step16_overlay_original_layer_idx ON outputs.step16_overlay USING btree (original_layer);
CREATE INDEX step16_overlay_geom_idx ON outputs.step16_overlay USING gist (geom);
CREATE INDEX step16_overlay_gid_idx ON outputs.step16_overlay USING btree (gid);
CREATE INDEX step16_overlay_cd_bioma_idx ON outputs.step16_overlay USING btree (cd_bioma);


\echo  


-- SICAR
\echo SICAR
\echo   

-- 
DROP TABLE IF EXISTS outputs.step17_overlay;
CREATE TABLE outputs.step17_overlay
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
  is_massas_dagua BOOLEAN NULL,
  is_fronteira BOOLEAN NULL,
  is_sicar BOOLEAN NULL,
  geom geometry NULL
);


CREATE INDEX step17_overlay_original_gid_idx ON outputs.step17_overlay USING btree (original_gid);
CREATE INDEX step17_overlay_cd_mun_idx ON outputs.step17_overlay USING btree (cd_mun);
CREATE INDEX step17_overlay_original_layer_idx ON outputs.step17_overlay USING btree (original_layer);
CREATE INDEX step17_overlay_geom_idx ON outputs.step17_overlay USING gist (geom);
CREATE INDEX step17_overlay_gid_idx ON outputs.step17_overlay USING btree (gid);
CREATE INDEX step17_overlay_cd_bioma_idx ON outputs.step17_overlay USING btree (cd_bioma);


\echo  
