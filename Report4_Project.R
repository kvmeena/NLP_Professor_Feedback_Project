install.packages("polyglotr")
install.packages(c("tidytext","dplyr","pdftools","readr","wordcloud","tm","tibble","ggplot2"))
library(tidytext)
library(dplyr)
library(pdftools)
library(readr)
library(wordcloud)
library(tm)
library(tibble)
library(ggplot2)
library(polyglotr)
library(pdftools)

# Load PDF and extract   text
pdf_file1 <- "Data/Text.pdf"
data1 <- pdf_text(pdf_file1)

# Convert complete text data into a single string
text_data1<- paste(data1, collapse = " ")
print(text_data1)
translation_google <- google_translate(text_data1, target_language = "en", source_language = "ko")
cat(translation_google)

