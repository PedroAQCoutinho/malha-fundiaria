#!/bin/bash

pid_file="/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_split_fundiario/pid"

# Leia o PID a partir do arquivo
pid=$(cat "$pid_file")

# Verifique se o PID está em execução
if kill -0 "$pid" > /dev/null 2>&1
then
    echo "Already running !"
    echo "Time: $(date '+%Y-%m-%d %T') - O arquivo cd_grid.txt ainda contém $(wc -l < cd_grid.txt) linhas."


else
    # Execute o script bash_execproc.sh se o PID não estiver em execução
    echo "Not running, then run !" 
    echo "Time: $(date '+%Y-%m-%d %T') - O arquivo cd_grid.txt ainda contém $(wc -l < cd_grid.txt) linhas porém agora iniciando uma nova contagem..."
    bash /home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_split_fundiario/bash_queue_run.sh > log 2>&1 &
fi



