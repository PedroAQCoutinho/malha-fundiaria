
userName=postgres
databaseName=malha_fundiaria
numProc=10
procName=proc2_array_agg


psql -U $userName -d $databaseName -f ${procName}_1.sql


#If sql 2 exists execute it
for ((i=1; i < 3; i++))
do
    u=1
    while [ $u -lt 11 ]; 
    do 
    echo $u; 
    u=$((u+1)); 
    done 
    wait
done 
wait






