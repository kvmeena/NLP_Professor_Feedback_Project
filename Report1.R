# Install and load necessary packages
install.packages(c("tidytext", "dplyr", "pdftools", "readr", "wordcloud", "tm", "tibble", "ggplot2", "httr", "jsonlite"))
library(tidytext)
library(dplyr)
library(pdftools)
library(readr)
library(wordcloud)
library(tm)
library(tibble)
library(ggplot2)
library(httr)
library(jsonlite)

# 1. Data Preprocessing

pdf_file <- "Data/korean_text.pdf"
data <- pdf_text(pdf_file)

num_pages <- length(data)
cat("Number of pages in the PDF:", num_pages, "\n")

cat("First page:\n", data[1])
cat("24th page:\n", data[24])

# 2. Data conversion

# Convert complete text data into a single string
text_data <- paste(data, collapse = " ")
# Store complete string into one column text
df <- data.frame(text = text_data, stringsAsFactors = FALSE)

# 3. Define translation function
translate_text <- function(text, target_language = "en", api_key) {
  url <- "https://translation.googleapis.com/language/translate/v2"



# 4. Operations on Data

# Generate tokens and some new columns for checking length and data type
df_tokens <- df_translated %>%
  unnest_tokens(token, text) %>%
  mutate(
    token_length = nchar(token),
    is_numeric_token = grepl("^[0-9.]+$", token),
    token_type = ifelse(is_numeric_token, "Numeric", "Character"),
    numeric_value = ifelse(is_numeric_token, as.numeric(token), NA)
  )

# View the tokens
View(df_tokens)

# Count of tokens
token_count <- df_tokens %>%
  count(token, sort = TRUE)
View(token_count)

# 5. Data Cleaning

df_tokens_filtered <- df_tokens %>%
  filter(!is_numeric_token)
View(df_tokens_filtered)

# Remove stop words
data("stop_words")
df_tokens_stop <- df_tokens_filtered %>%
  anti_join(stop_words, by = c("token" = "word"))

View(df_tokens_stop)

# After removing stop words, count of each token
token_count <- df_tokens_stop %>%
  count(token, sort = TRUE)
View(token_count)

# 6. Create a tibble to improve insight readability
df_tibble <- as_tibble(df_tokens_stop)
head(df_tibble)

# 7. Analysis (EDA)

# Using token_count from part 4
top_words <- token_count %>%
  top_n(10)

# Create the bar plot of the most common words
ggplot(top_words, aes(x = reorder(token, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 10 Most Common Words", x = "Words", y = "Frequency") +
  theme_minimal()


