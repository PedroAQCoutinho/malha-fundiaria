#!/bin/bash

export PGPASSWORD="gpp-es@lq"

gdal_rasterize  -a gid -of GTiff -a_srs EPSG:4326 -co "COMPRESS=DEFLATE" -co "PREDICTOR=2" -co "ZLEVEL=9" -co "BIGTIFF=IF_SAFER" -co "NUM_THREADS=8" -co "TILED=YES" -te -74.8973961 -34.7917510 -33.0613262 7.9120915 -ts 155239 158459 -ot UInt32 PG:"user=postgres dbname=malha_fundiaria" -sql "select gid, valid_geom geom from dados_brutos.valid_sicar_imovel" $HOME/sicar_imovel.tif
gdal_rasterize  -a gid -of GTiff -a_srs EPSG:4326 -co "COMPRESS=DEFLATE" -co "PREDICTOR=2" -co "ZLEVEL=9" -co "BIGTIFF=IF_SAFER" -co "NUM_THREADS=8" -co "TILED=YES" -te -74.8973961 -34.7917510 -33.0613262 7.9120915 -ts 155239 158459 -ot UInt32 PG:"user=postgres dbname=malha_fundiaria" -sql "select gid, geom from outputs.step14_overlay" $HOME/step14_overlay.tif