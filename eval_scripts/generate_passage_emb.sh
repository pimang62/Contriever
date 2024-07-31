#!/bin/bash

python generate_passage_embeddings.py \
    --model_name_or_path checkpoint/contriever/experiment/checkpoint/step-400000 \
    --output_dir contriever_embeddings \
    --passages korquad_dataset/document.json \
    --shard_id 0 --num_shards 1 \