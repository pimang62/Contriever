#!/bin/bash

python passage_retrieval.py \
    --model_name_or_path checkpoint/contriever/experiment/checkpoint/step-400000 \
    --passages korquad_dataset/document.json \
    --passages_embeddings "contriever_embeddings/*" \
    --data korquad_dataset/dev_question.json \
    --output_dir contriever_korquad \