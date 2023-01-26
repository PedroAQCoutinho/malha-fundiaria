export PGPASSWORD='gpp-es@lq'
userName=postgres
databaseName=malha_fundiaria
numProc=1
wait=false
error=false
varPriority=random


while getopts "U:p:h:d:j:w" opt; do
  case $opt in
    h) databaseServer=$OPTARG;;
    U) userName=$OPTARG;;
    p) portNumber=$OPTARG;;
    d) databaseName=$OPTARG;;
    j) numProc=$OPTARG;;
    w) 
	useWait="-w"
	wait=true;;
    \?) 
	echo "$opt with $OPTARG"
	error=true;;
  esac
done

specificProc=${@:$OPTIND:1}
invalid=${@:$OPTIND+2:1}
[[ ! portNumber -gt 0 ]] && error=true
[[ ! numProc -gt 0 ]] && error=true
[[ ! -z "$invalid" ]] && error=true
if [ $error == true ]
then
  echo "Usage: ./luga_process.sh [-h host] [-p port] [-U user] [-d database] [-j Number_of_jobs] [proc_name_resume]" 
  echo
  echo "Remark: database passward show me exported in the beginning"
  exit
fi

useWait=$($wait && echo -w || echo "")
