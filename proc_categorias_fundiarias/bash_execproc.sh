userName=postgres
databaseName=malha_fundiaria
numProc=14
procName=proc1_limpeza_duplicados

psql -U $userName -d $databaseName -f ${procName}_1.sql


#If sql 2 exists execute it
#for ((i=0; i < ${numProc}; i++))
#do
#    psql -U $userName -d $databaseName -v var_num_proc=$numProc -v var_proc=$i -f ${procName}_2.sql &
#done
#wait



echo Terminou



