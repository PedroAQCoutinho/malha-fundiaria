#!/bin/bash

pid_file="/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_split_fundiario/pid"

# Leia o PID a partir do arquivo
pid=$(cat "$pid_file")

# Verifique se o PID está em execução
if kill -0 "$pid" > /dev/null 2>&1
then
    echo "ok"
else
    # Execute o script bash_execproc.sh se o PID não estiver em execução
    echo "not running, then run !" 
    bash /home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_split_fundiario/bash_queue_run.sh > log 2>&1 &
fi