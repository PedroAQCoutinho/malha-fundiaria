export PGPASSWORD="gpp-es@lq"

psql -U postgres -d malha_fundiaria < /home/pedro/hd1/pedro/GPP/ltmodel/outputs/car/proc2_array_agg.sql

export PGPASSWORD="gpp-es@lq"

gdal_rasterize  -a gid -of GTiff -a_srs EPSG:4326 -co "COMPRESS=DEFLATE" -co "PREDICTOR=2" -co "ZLEVEL=9" -co "BIGTIFF=IF_SAFER" -co "TILED=YES" -co "CPL_LOG=gdallog" -te -74.8973961 -34.7917510 -33.0613262 7.9120915 -ts 155239 158459 -ot UInt32 PG:"user=postgres dbname=malha_fundiaria port=5434" -sql "select gid, geom from car.proc2_array_agg" proc2_array_agg.tif