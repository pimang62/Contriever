#!/bin/bash

# Define base directories
BASE_DIR="/mnt/nasdata1/TXTDB/data_for_albert/original"
OUTPUT_BASE_DIR="./output/encoded-data"
TOKENIZER="bert-base-uncased"
NPROCESS=8

# Function to process a single directory
process_directory() {
    local DIR=$1
    local OUTDIR=${OUTPUT_BASE_DIR}/${TOKENIZER}/$(basename ${DIR})

    mkdir -p ${OUTDIR}

    for FILE in ${DIR}/txts/*.txt; do
        # Process the file
        python3 preprocess.py --tokenizer ${TOKENIZER} --datapath ${FILE} --outdir ${OUTDIR} --overwrite &
        pids+=($!)

        # Control parallel execution
        if (( ${#pids[@]} >= NPROCESS )); then
            for pid in ${pids[@]}; do
                wait $pid
            done
            pids=()
        fi
    done

    # Wait for any remaining processes to finish
    for pid in ${pids[@]}; do
        wait $pid
    done
}

# List of all directories to process
DIRS=(
    "${BASE_DIR}/doc_summary_malmungchi_original"
    "${BASE_DIR}/messenger_malmungchi_original"
    # "${BASE_DIR}/spoken_malmungchi_original"
    "${BASE_DIR}/korean_petitions_original"
    "${BASE_DIR}/namuwikitext_original"
    # "${BASE_DIR}/written_malmungchi_original"
    "${BASE_DIR}/kowikitext_original"
    "${BASE_DIR}/newspaper_malmungchi_original"
)

# Process each directory
for DIR in "${DIRS[@]}"; do
    process_directory ${DIR}
done
