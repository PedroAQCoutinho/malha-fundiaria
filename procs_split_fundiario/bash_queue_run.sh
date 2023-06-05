#! /bin/bash

N=8  # Amount of jobs to run in parallel
T=0  # Counter for amount of jobs
Q=() # Job queue
FILE='cd_grid.txt'
start_date="$(date)"
SECONDS=0
export PGPASSWORD='gpp-es@lq'
userName=postgres
databaseName=malha_fundiaria
procName=proc1_malhav2

echo "$$" > pid
echo "Parameter: $1"

psql -t -A -U $userName -d $databaseName -c "
SELECT * FROM (
SELECT DISTINCT cd_grid FROM grid.adm2_overlay a
LEFT JOIN (SELECT DISTINCT cd_grid , TRUE exis FROM malhav2.proc6_malha) foo using(cd_grid) 
WHERE exis IS NOT TRUE AND NOT a.am_legal AND substring(cd_mun::TEXT, 1, 2)::int = '29' 
) bar ORDER BY cd_grid ; " > cd_grid.txt





psql -U $userName -d $databaseName -f functionsv2.sql
#psql -U $userName -d $databaseName -f ${procName}_1.sql

  # Clean Q array
  function _clean {
          for ((i=0; i < ${N}; ++i)); do
                  tst=/proc/${Q[$i]}
                  if [ ! -d $tst ]; then
                          Q[$i]=0
                  fi
          done
  }

# Setup the Q




for ((i=0; i < $N; i++)); do
        Q[$i]=0
done

while read -r line; do
        echo RUN $T
        echo cd_grid $line
        psql -U $userName -d $databaseName -f ${procName}_2.sql -v run=$line &

        # Try to find an open sport (Q[i]=0)
        while true; do
                for ((i=0; i < ${N}; ++i)); do
                        if [ ${Q[$i]} -eq 0 ]; then
                                Q[$i]=$!
                                break 2
                        fi
                done
                # Clean the Q array if no free entry is found
                _clean
        done
        ((T++))
done < ${FILE}
wait
echo "Processed ($T/$(wc -l < cd_grid.txt)) jobs"


pg_dump 



echo Started at: 
echo $start_date
echo 
echo Finished at:
echo `date`
echo Elapsed:
displaytime $SECONDS