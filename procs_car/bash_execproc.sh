#!/bin/bash
start_date="$(date)"
SECONDS=0
userName=postgres
databaseName=malha_fundiaria
numProc=120
procName=proc1_overlay
export PGPASSWORD='gpp-es@lq'


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



echo Started at: 
echo $start_date
echo 
echo Finished at:
echo `date`
echo Elapsed:
displaytime $SECONDS



