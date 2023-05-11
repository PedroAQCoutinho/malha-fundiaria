#!/bin/bash

userName=postgres
databaseName=malha_fundiaria
numProc=8
procName=proc1_cat_fund_1
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}_1.sql

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done
wait



