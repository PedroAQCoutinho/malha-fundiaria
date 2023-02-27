#!/bin/bash

curDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
start_date="$(date)"
SECONDS=0
. $curDir/bash_01_helpers.sh


userName=postgres
databaseName=malha_fundiaria
numProc=120
procName=proc1_overlay


psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_1.sql &


#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done 
wait



#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_3.sql &
done 
wait

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_4.sql &
done 
wait



