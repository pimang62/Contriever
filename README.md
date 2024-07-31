# Setting
```
conda create -n contriever python=3.10
pip install -r requirements.txt
```

# Data
## Path structure
```
/mnt/nasdata1/TXTDB/data_for_albert/original/
  ├── doc_summary_malmungchi_original/
      ├── txts/
          ├── NIKL_SC.txt
  ├── messenger_malmungchi_original/
      ├── txts/
          ├── *.txt 
          ├── *.txt 
          ├── *.txt 
           ...
  ├── spoken_malmungchi_original/
      ├── txts/
          ├── *.txt 
          ├── *.txt 
          ├── *.txt 
           ...
  ├── korean_petitions_original/
      ├── txts/
          ├── *.txt 
          ├── *.txt 
          ├── *.txt 
           ...
  ├── namuwikitext_original/
      ├── txts/
          ├── *.txt 
          ├── *.txt 
          ├── *.txt 
           ...
  ├── written_malmungchi_original/
      ├── None
  ├── kowikitext_original/
      ├── txts/
          ├── *.txt 
          ├── *.txt 
          ├── *.txt 
           ...
  ├── messenger_malmungchi_original/
      ├── txts/
          ├── *.txt 
          ├── *.txt 
          ├── *.txt 
           ...
  ├── newspaper_malmungchi_original/
      ├── txts/
          ├── *.txt 
          ├── *.txt 
          ├── *.txt 
           ...
```


# Run
## Tokenizing
```bash
bash data_scripts/tokenize_all.sh
```

## Pretraining
```bash
bash train_scripts/contriever_all.sh
```

## Inference(test)
```python
python3 inference.py
```

# Evaluation
## Generate passage embeddings
```bash
bash eval_scripts/generate_passage_emb.sh
```

## Passage retrieve
```bash
bash eval_scripts/passage_ret.sh
```

# Reference
- [Contriever paper](https://arxiv.org/pdf/2112.09118)
- [Contriever github](https://github.com/facebookresearch/contriever/)
- [KorQuAD 1.0](https://korquad.github.io/category/1.0_KOR.html)