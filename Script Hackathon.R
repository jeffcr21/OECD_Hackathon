rm(list = ls())

library(readr)
library(tidyverse)
library(ggplot2)
library(stringi)
library(stringr)
library(quanteda)
library(topicmodels)
library(spacyr)
library(corpustools)
require(readtext)
require(quanteda.textplots)

stip <- read_delim('stip.csv', '|', escape_double = FALSE, trim_ws = TRUE) #Importing dataset STIP

load("strategies_final.RData") ##Load the STI dataset

head(data_final, 1)
summary(data_final)

data_final <- data_final[,-6] ##Elimnate colums that are not necesary

##Create the corpus
corpus_data_final <- corpus(data_final$text_clean, 
                     docvars = data.frame(data_final$country, data_final$year, data_final$period, data_final$doc_id, data_final$title))
print(corpus_data_final)

##Tokenization
toks_data_final <- tokens(corpus_data_final)
head(toks_data_final, 2)

##Creating the Document-feature matrix
dfm_data_final <- dfm(toks_data_final)
print(dfm_data_final)

dfm_data_final  <- dfm_data_final %>% 
  dfm_wordstem() %>% #stem the dfm
  dfm_trim(min_docfreq = 0.01,  docfreq_type = 'prop') %>% # retain only words included in at least 1% of documents
  dfm_subset(ntoken(dfm_data_final) >= 10) # remove documents with less than 10 words

textplot_wordcloud(dfm_data_final)

warnings()
