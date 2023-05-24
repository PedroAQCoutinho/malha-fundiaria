#!/bin/bash

export PGPASSWORD="gpp-es@lq"
#gdal_rasterize  -a gid -of GTiff -a_srs EPSG:4326 -co "COMPRESS=DEFLATE" -co "PREDICTOR=2" -co "ZLEVEL=9" -co "BIGTIFF=IF_SAFER" -co "NUM_THREADS=8" -co "TILED=YES" -te -74.8973961 -34.7917510 -33.0613262 7.9120915 -ts 155239 158459 -ot UInt32 PG:"user=postgres dbname=malha_fundiaria port=5433" -sql "select gid, valid_geom geom from dados_brutos.valid_sicar_imovel" $HOME/sicar_imovel.tif
gdal_rasterize  -a gid -of GTiff -a_srs EPSG:4326 -co "COMPRESS=DEFLATE" -co "PREDICTOR=2" -co "ZLEVEL=9" -co "BIGTIFF=IF_SAFER" -co "NUM_THREADS=8" -co "TILED=YES" -co "CPL_LOG=gdallog" -te -74.8973961 -34.7917510 -33.0613262 7.9120915 -ts 155239 158459 -ot UInt32 PG:"user=postgres dbname=malha_fundiaria port=5433 password=gpp-es@lq" -sql "select gid, geom from car.proc2_array_agg where am_legal" proc2_array_agg.tif
gdal_rasterize  -a gid -of GTiff -a_srs EPSG:4326 -co "COMPRESS=DEFLATE" -co "PREDICTOR=2" -co "ZLEVEL=9" -co "BIGTIFF=IF_SAFER" -co "NUM_THREADS=32" -co "TILED=YES" -te -74.8973961 -34.7917510 -33.0613262 7.9120915 -ts 155239 158459 -ot UInt32 PG:"user=postgres dbname=malha_fundiaria port=5433 password=gpp-es@lq" -sql "select gid, geom from malhav2.proc6_malha" proc6_malha.tif > log 2>&1 &




gdal_rasterize  -a cd -of GTiff -a_srs EPSG:4326 -co "COMPRESS=DEFLATE" -co "PREDICTOR=2" -co "ZLEVEL=9" -co "BIGTIFF=IF_SAFER" -co "NUM_THREADS=32" -co "TILED=YES" -te -74.8973961 -34.7917510 -33.0613262 7.9120915 -ts 155239 158459 -ot UInt32 PG:"user=postgres dbname=malha_fundiaria port=5433 password=gpp-es@lq" -sql "select cd, geom from public.car_classificado" car_classificado.tif > log 2>&1 &


gdal_rasterize  -a cd -of GTiff -a_srs EPSG:4326 -co "COMPRESS=DEFLATE" -co "PREDICTOR=2" -co "ZLEVEL=9" -co "BIGTIFF=IF_SAFER" -co "NUM_THREADS=32" -co "TILED=YES" -te -74.8973961 -34.7917510 -33.0613262 7.9120915 -ts 155239 158459 -ot UInt32 PG:"user=postgres dbname=malha_fundiaria port=5433 password=gpp-es@lq" -sql "select cd_mun::integer cd, geom from geo_adm.pa_br_limitemunicipal_250_2015_ibge_4674" /home/arquivos/dados_espaciais/limites_administrativos/pa_br_limiteMunicipios_30m_2006_ibge_4326.tif > log 2>&1 &


