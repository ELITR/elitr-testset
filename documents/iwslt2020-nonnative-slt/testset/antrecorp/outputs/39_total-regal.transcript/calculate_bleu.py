import codecs
from nltk.translate.bleu_score import corpus_bleu
from nltk.translate.bleu_score import sentence_bleu

candidate_file = "temp"
reference_file = "temp"
reference = []
hypothesis = []

with codecs.open(candidate_file, encoding='utf-8') as f:
    for line in f:
        line = line.split(' ')
        hypothesis.append(line)
        
with codecs.open(reference_file, encoding='utf-8') as f:
    for line in f:
        line = line.split(' ')
        reference.append(line)

print(hypothesis)
print(reference)

score = corpus_bleu(reference, hypothesis)
print(score)