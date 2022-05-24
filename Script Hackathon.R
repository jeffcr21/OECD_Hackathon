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

stip <- read_delim('stip.csv', '|', escape_double = FALSE, trim_ws = TRUE) #Importing dataset