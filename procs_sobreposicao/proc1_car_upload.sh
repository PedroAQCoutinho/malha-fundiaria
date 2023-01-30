--Alguns detalhes
declare -a arr=("al" "am" "ap" "ba" "df1" "es" "go" "ma" "ms" "mt" "pb" "pe" "pi" "rj" "rn" "ro" "rr" "se" "to")
for i in "${arr[@]}" 
do 
(shp2pgsql -c -I  "/home/pedro/hd1/pedro/GPP/ltmodel/inputs/CAR/car_2022/sicar_imoveis_$i/sicar_imoveis_$i.shp" dados_brutos.sicar_imoveis_$i | psql -U postgres -d malha_fundiaria)
done


export PGPASSWORD='gpp-es@lq'

psql -U postgres -d malha_fundiaria -c "DROP TABLE IF EXISTS dados_brutos.valid_sicar_imovel;"
psql -U postgres -d malha_fundiaria -c "CREATE TABLE dados_brutos.valid_sicar_imovel AS
SELECT *, ST_MakeValid(geom) valid_geom FROM dados_brutos.sicar_imovel icsp;"

psql -U postgres -d malha_fundiaria -c "CREATE INDEX valid_sicar_imovel_gid_idx ON dados_brutos.valid_sicar_imovel USING btree (gid);"
psql -U postgres -d malha_fundiaria -c "CREATE INDEX valid_sicar_imovel_geom_idx ON dados_brutos.valid_sicar_imovel USING gist (geom);"
psql -U postgres -d malha_fundiaria -c "CREATE INDEX valid_sicar_imovel_valid_geom_idx ON dados_brutos.valid_sicar_imovel USING gist (geom);"



psql -U postgres -d malha_fundiaria -c "DROP TABLE IF EXISTS autointersection.autointersection_input_sicar_imovel;"
psql -U postgres -d malha_fundiaria -c "CREATE TABLE autointersection.autointersection_input_sicar_imovel
(
  gid serial4 NOT null,
  agid int4 NULL,
  bgid int4 NULL,
  geom geometry NULL
);
"

psql -U postgres -d malha_fundiaria -c "CREATE INDEX autointersection_input_sicar_imovel_agid_idx ON autointersection.autointersection_input_sicar_imovel USING btree (agid);"
psql -U postgres -d malha_fundiaria -c "CREATE INDEX autointersection_input_sicar_imovel_geom_idx ON autointersection.autointersection_input_sicar_imovel USING gist (geom);"
psql -U postgres -d malha_fundiaria -c "CREATE INDEX autointersection_input_sicar_imovel_bgid_idx ON autointersection.autointersection_input_sicar_imovel USING btree (bgid);"



psql -U postgres -d malha_fundiaria -f aux_2.sql




