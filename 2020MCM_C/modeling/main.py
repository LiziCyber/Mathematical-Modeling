from __future__ import print_function
import os
import sys
import numpy as np
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.layers import Dense, Input, GlobalMaxPooling1D
from tensorflow.keras.layers import Conv1D, MaxPooling1D, Embedding
from tensorflow.keras.models import Model
 
BASE_DIR = "/data/"
GLOVE_DIR = os.path.join(BASE_DIR, 'glove.6B')
 
TEXT_DATA_DIR = os.path.join(BASE_DIR, 'news20/20_newsgroup')
MAX_SEQUENCE_LENGTH = 64  # 每个文本或者句子的截断长度，只保留64个单词
MAX_NUM_WORDS = 20000  # 用于构建词向量的词汇表数量
EMBEDDING_DIM = 100  # 词向量维度
VALIDATION_SPLIT = 0.2

print("Indexing word vectors.")
embeddings_index = {}
with open(os.path.join(GLOVE_DIR, 'glove.6B.100d.txt'), encoding="utf-8") as f:
    for line in f:
        values = line.split()
        word = values[0]  # 单词
        coefs = np.asarray(values[1:], dtype='float32')
        embeddings_index[word] = coefs


print('预处理文本数据集')
texts = []  # 训练文本样本的list
labels_index = {}  # 标签和数字id的映射
labels = []  # 标签list

# 向量化文本样本
tokenizer = Tokenizer(num_words=MAX_NUM_WORDS)
# fit_on_text(texts) 使用一系列文档来生成token词典，texts为list类，每个元素为一个文档。就是对文本单词进行去重后
tokenizer.fit_on_texts(texts)
# texts_to_sequences(texts) 将多个文档转换为word在词典中索引的向量形式,shape为[len(texts)，len(text)] -- (文档数，每条文档的长度)
sequences = tokenizer.texts_to_sequences(texts)
print(sequences[0])
print(len(sequences))  # 19997
