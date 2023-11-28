now=$(date)
sqs_out=$(squeue)
sinfo_out=$(sinfo)

num_run=$(printf "$sqs_out" | grep ' R ' | wc -l)
num_pend=$(printf "$sqs_out" | grep ' PD ' | wc -l)

batch_nodes=$(sinfo | grep 'batch\*' | tr -s ' ' | cut -d' ' -f 4 | paste -sd+ | bc)
idle_nodes=$(sinfo | grep 'batch\*' | grep 'idle' | tr -s ' ' | cut -d' ' -f 4 | paste -sd+ | bc)
alloc_nodes=$(sinfo | grep 'batch\*' | grep 'alloc' | tr -s ' ' | cut -d' ' -f 4 | paste -sd+ | bc)
down_nodes=$(sinfo | grep 'batch\*' | grep 'down' | tr -s ' ' | cut -d' ' -f 4 | paste -sd+ | bc)
plnd_nodes=$(sinfo | grep 'batch\*' | grep 'plnd' | tr -s ' ' | cut -d' ' -f 4 | paste -sd+ | bc)
comp_nodes=$(sinfo | grep 'batch\*' | grep 'comp' | tr -s ' ' | cut -d' ' -f 4 | paste -sd+ | bc)
maint_nodes=$(sinfo | grep 'batch\*' | grep 'maint' | tr -s ' ' | cut -d' ' -f 4 | paste -sd+ | bc)
drng_nodes=$(sinfo | grep 'batch\*' | grep 'drng' | tr -s ' ' | cut -d' ' -f 4 | paste -sd+ | bc)

if [[ $idle_nodes == "" ]];  then idle_nodes=0; fi
if [[ $alloc_nodes == "" ]]; then alloc_nodes=0; fi
if [[ $down_nodes == "" ]];  then down_nodes=0; fi
if [[ $plnd_nodes == "" ]];  then plnd_nodes=0; fi
if [[ $comp_nodes == "" ]];  then comp_nodes=0; fi
if [[ $maint_nodes == "" ]];  then maint_nodes=0; fi
if [[ $drng_nodes == "" ]];  then drng_nodes=0; fi

echo "$num_run running, $num_pend pending"
echo "$idle_nodes/$batch_nodes idle"
echo "$alloc_nodes/$batch_nodes alloc"
echo "$down_nodes/$batch_nodes down"
echo "$plnd_nodes/$batch_nodes plnd"
echo "$comp_nodes/$batch_nodes comp"
echo "$maint_nodes/$batch_nodes maint"
echo "$drng_nodes/$batch_nodes drng"

echo "$now,$num_run,$num_pend,$batch_nodes,$idle_nodes,$alloc_nodes,$down_nodes,$plnd_nodes,$comp_nodes,$maint_nodes,$drng_nodes" >> $OUTPUT
