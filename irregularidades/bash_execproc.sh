#!/bin/bash

userName=postgres
databaseName=malha_fundiaria
numProc=16






procName=proc2_2_desmatamento_anual
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}.sql


procName=proc2_3_desmatamento_anual
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}_1.sql


#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done
wait


procName=proc3_antigo
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}_1.sql

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done
wait



procName=proc4_grande
export PGPASSWORD='gpp-es@lq'



procName=proc5_cat_fund
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}_1.sql

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done
wait




procName=proc6_local_irregular
export PGPASSWORD='gpp-es@lq'

psql -U $userName -d $databaseName -f ${procName}_1.sql

#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done
wait

