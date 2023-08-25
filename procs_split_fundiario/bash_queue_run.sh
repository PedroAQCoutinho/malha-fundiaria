#! /bin/bash

N=4  # Amount of jobs to run in parallel
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
WITH foo AS (SELECT UNNEST(original_gid) original_gid, UNNEST(original_layer) original_layer FROM malhav2.proc2_malhav2 pm),
bar AS (SELECT gid original_gid, cd_grid, geom FROM grid.adm2_overlay
WHERE substring(cd_mun::TEXT, 1, 2)::int IN (31)),
zeta AS (SELECT DISTINCT original_gid, TRUE exis FROM foo WHERE original_layer = 'GRID')
SELECT DISTINCT cd_grid FROM bar LEFT JOIN zeta using(original_gid)
WHERE exis IS NOT TRUE; " > cd_grid.txt


#psql -t -A -U $userName -d $databaseName -c "
# SELECT distinct cd_grid FROM grid.adm2_overlay ao
#WHERE cd_grid IN (848351,864354,1024345,876332,944265,1056262,1084265,1136274,1212289,1220289,1204310, 1204310, 1184260); " > cd_grid.txt



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