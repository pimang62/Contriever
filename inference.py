from src.contriever import Contriever, load_retriever
from transformers import AutoTokenizer

output_dir = "checkpoint/contriever/experiment/checkpoint/step-400000"

contriever, tokenizer, retriever_model_id = load_retriever(output_dir)

sentences = [
    "마리 퀴리는 어디에서 살았나요?",
    "마리 퀴리로 알려져 있는 마리 스크워도프스카는 1867년 11월 7일에 태어났습니다.",
    "1859년 5월 15일, 파리에서 유진 퀴리의 아들로 태어난 피에르 퀴리는 가톨릭 출신의 알자스 지방 출신의 의사였다."
]

inputs = tokenizer(sentences, padding=True, truncation=True, return_tensors="pt")
embeddings = contriever(**inputs)

if __name__=="__main__":
    score01 = embeddings[0] @ embeddings[1] #1.0473 / 2.8851
    score02 = embeddings[0] @ embeddings[2] #1.0095 / 2.6357
    print(score01, score02)