#!/bin/bash

userName=postgres
databaseName=malha_fundiaria
numProc=190
export PGPASSWORD='gpp-es@lq'
procName=aux


psql -U $userName -d $databaseName -f ${procName}_1.sql


#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done > log_autointersection 2>&1
wait


#If sql 2 exists execute it
#for ((i=0; i < ${numProc}; i++))
#do
#    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_3.sql &
#done > log_inputs 2>&1
#wait


#procName=proc5_overlay

#If sql 2 exists execute it
#for ((i=0; i < ${numProc}; i++))
#do
#    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f procs/${procName}_2_17.sql &
#done > log_massas 2>&1
wait

#If sql 2 exists execute it
#for ((i=0; i < ${numProc}; i++))
#do
#    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f procs/${procName}_2_18.sql &
#done > log_fronteira 2>&1
#wait

#If sql 2 exists execute it
#for ((i=0; i < ${numProc}; i++))
#do
#    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f procs/${procName}_2_19.sql &
#done > log_sicar 2>&1
#wait



echo Terminou



