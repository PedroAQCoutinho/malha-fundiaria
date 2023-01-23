#!/bin/bash

userName=postgres
databaseName=malha_fundiaria
numProc=1
procName=test


#If sql 2 exists execute it
for ((i=0; i < ${numProc}; i++))
do
    psql -U $userName -d $databaseName -f ${procName}.sql &  
done > log 2>&1
wait 


echo Terminou




