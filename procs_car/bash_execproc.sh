#!/bin/bash
start_date="$(date)"
SECONDS=0
userName=postgres
databaseName=malha_fundiaria
numProc=32
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


