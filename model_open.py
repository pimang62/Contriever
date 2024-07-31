import torch
import pdb
from src.contriever import load_retriever

output_dir = "checkpoint/contriever/experiment/checkpoint/lastlog"

retriever, tokenizer, retriever_model_id = load_retriever(output_dir)

print(retriever)
# pdb.set_trace()