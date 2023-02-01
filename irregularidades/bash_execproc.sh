#!/bin/bash

userName=postgres
databaseName=malha_fundiaria
numProc=64
export PGPASSWORD='gpp-es@lq'
procName=proc4_car_mun


psql -U $userName -d $databaseName -f ${procName}_1.sql

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done > log_cd_mun 2>&1
wait
