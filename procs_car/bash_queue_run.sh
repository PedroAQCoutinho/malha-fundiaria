  N=10  # Amount of jobs to run in parallel
  T=0  # Counter for amount of jobs
  Q=() # Job queue
  FILE='run.txt'


userName=postgres
databaseName=malha_fundiaria
numProc=10
procName=proc2_array_agg


psql -U $userName -d $databaseName -f ${procName}_1.sql

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

while [ $T -lt 100 ]; do
        echo $line
        psql -U $userName -d $databaseName -f ${procName}_2.sql -v run=$T &

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
done 
wait


echo "Processed ($T/20) jobs"
