#!/bin/bash

userName=postgres
databaseName=malha_fundiaria
numProc=8
procName=proc5_cat_fund
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}_1.sql

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done
wait



procName=proc4_local_irregular
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}_1.sql

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done
wait



procName=proc8_concatenate
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}.sql
