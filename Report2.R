#Task-2: convert anylanguage text into English
#Natural Language Processing


install.packages(c("tidytext", "dplyr", "pdftools", "readr"))

library(tidytext)
library(dplyr)
library(pdftools)
library(readr)


pdf_file = "Data/korean_text.pdf"
data1 = pdf_text(pdf_file)

num_pages = length(data1)
cat("Number of pages in the PDF:", num_pages, "\n")

cat("First page:\n", data1[1])


#convert complete text data in string
text_data1= paste(data1, collapse = " ")
#Store complete string into one column text
df1 = data.frame(text = text_data1, stringsAsFactors = FALSE)
df1



# 3. Operations on Data

# here we gererate tokens and some new colums for ChecKing length, data type
df_tokens1 = df1 %>%
  unnest_tokens(token, text) %>%
  #mutate(
    #token_length = nchar(token),
    #is_numeric_token = grepl("^[0-9.]+$", token),
    #token_type = ifelse(is_numeric_token, "Numeric", "Character"),
    #numeric_value = ifelse(is_numeric_token, as.numeric(token), NA)
  #)
print(df_tokens1)
