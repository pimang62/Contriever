#!/bin/bash
#SBATCH --cpus-per-task=5
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=8
#SBATCH --gres=gpu:8
#SBATCH --time=72:00:00
#SBATCH --job-name=contriever
#SBATCH --output=/private/home/gizacard/contriever/logtrain/%A
#SBATCH --partition=learnlab
#SBATCH --mem=450GB
#SBATCH --signal=USR1@140
#SBATCH --open-mode=append

export OMP_NUM_THREADS=8

# Set the port for communication
port=$(shuf -i 15000-16000 -n 1)

# Define the directory containing the encoded data
TDIR="./output/encoded-data/bert-base-uncased"

# List of all directories to process
DIRS=(
    "${TDIR}/doc_summary_malmungchi_original"
    "${TDIR}/messenger_malmungchi_original"
    # "${TDIR}/spoken_malmungchi_original"
    "${TDIR}/korean_petitions_original"
    "${TDIR}/namuwikitext_original"
    # "${TDIR}/written_malmungchi_original"
    "${TDIR}/kowikitext_original"
    "${TDIR}/newspaper_malmungchi_original"
)

# Join all directories into a single string separated by spaces
TRAINDATASETS=$(printf " %s" "${DIRS[@]}")

# Define hyperparameters
rmin=0.05
rmax=0.5
T=0.05
QSIZE=131072
MOM=0.9995
POOL=average
AUG=delete
PAUG=0.1
LC=0.
mo=bert-base-uncased
mp=none

# Define the name of the job
name=experiment #$SLURM_JOB_ID-$POOL-rmin$rmin-rmax$rmax-T$T-$QSIZE-$MOM-$mo-$AUG-$PAUG

# Run the training script with the specified parameters
# srun python3 train.py \
python3 train.py \
    --model_path $mp \
    --sampling_coefficient $LC \
    --retriever_model_id $mo --pooling $POOL \
    --augmentation $AUG --prob_augmentation $PAUG \
    --train_data $TRAINDATASETS --loading_mode split \
    --ratio_min $rmin --ratio_max $rmax --chunk_length 256 \
    --momentum $MOM --queue_size $QSIZE --temperature $T \
    --warmup_steps 20000 --total_steps 500000 --lr 0.00005 \
    --name $name \
    --scheduler linear \
    --optim adamw \
    --per_gpu_batch_size 64 \
    --output_dir ./checkpoint/contriever/$name \
    --main_port $port
