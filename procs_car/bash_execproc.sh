#!/bin/bash
start_date="$(date)"
SECONDS=0
userName=postgres
databaseName=malha_fundiaria
numProc=8
procName=proc1_overlay
export PGPASSWORD='gpp-es@lq'


function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S
}


psql -U $userName -d $databaseName -f ${procName}_1.sql
#
#
##If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
done 
wait
#
#
##If sql 2 exists execute it
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


psql -U $userName -d $databaseName -c "SELECT avg(cd_grid) cd_grid FROM grid.adm3_overlay WHERE am_legal 
GROUP BY cd_grid, am_legal
ORDER BY am_legal DESC, cd_grid" > cd_grid.txt


#bash bash_queue_run.sh > log_split 2>&1 
