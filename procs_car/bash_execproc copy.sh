#!/bin/bash

userName=postgres
databaseName=malha_fundiaria
numProc=120
procName=proc1_overlay



psql -U $userName -d $databaseName -f ${procName}_1.sql


#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_proc=$i -f ${procName}_2.sql &
done > log_adm1_overlay 2>&1
wait

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_proc=$i -f ${procName}_3.sql &
done > log_adm2_overlay 2>&1
wait

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_proc=$i -f ${procName}_4.sql &
done > log_adm3_overlay 2>&1
wait


userName=postgres
databaseName=malha_fundiaria
numProc=1600144
procName=proc2_array_agg


psql -U $userName -d $databaseName -f ${procName}_1.sql


#If sql 2 exists execute it
for ((i=36209; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_proc=$i -f ${procName}_2.sql &
done 
wait