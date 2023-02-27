#!/bin/bash

userName=postgres
databaseName=malha_fundiaria
numProc=10
procName=proc1_overlay




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