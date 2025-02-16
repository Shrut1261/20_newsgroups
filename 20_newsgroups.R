# Load necessary libraries
library(tidytext)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(data.table)
library(topicmodels)
library(tm)

# Set the working directory (adjust path as needed)
setwd("C:/Users/pshru/Desktop/Vs code/20_newsgroups")

# Select newsgroups for analysis
selected_newsgroups <- c("comp.graphics", "sci.space", "talk.politics.misc")

# Function to read and preprocess a single file
read_message <- function(file_path) {
  tryCatch({
    text <- readLines(file_path, warn = FALSE)
    text <- paste(text, collapse = " ")
    # Basic pre processing
    text <- tolower(text)
    text <- removePunctuation(text)
    data.table(newsgroup = basename(dirname(file_path)), message = text)
  }, error = function(e) {
    warning(paste("Error reading file:", file_path, "Error:", e$message))
    NULL
  })
}

# Read all files from selected newsgroups
usenet_data <- rbindlist(lapply(selected_newsgroups, function(newsgroup) {
  files <- list.files(path = newsgroup, full.names = TRUE)
  rbindlist(lapply(files, read_message))
}))

# 1. Analysis of Words within newsgroups using tf-idf metric
usenet_words <- usenet_data %>%
  unnest_tokens(word, message) %>%
  count(newsgroup, word, sort = TRUE)

usenet_tf_idf <- usenet_words %>%
  bind_tf_idf(word, newsgroup, n)

# Visualization for top terms by tf-idf
p1 <- usenet_tf_idf %>%
  group_by(newsgroup) %>%
  slice_max(tf_idf, n = 10) %>%
  ungroup() %>%
  ggplot(aes(tf_idf, reorder_within(word, tf_idf, newsgroup), fill = newsgroup)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~newsgroup, scales = "free_y", ncol = 1) +
  scale_y_reordered() +
  labs(x = "TF-IDF Score", y = "Word", 
       title = "Top 10 Most Distinctive Terms by Newsgroup",
       subtitle = "Based on TF-IDF Score") +
  theme(axis.text.y = element_text(size = 8),
        strip.text = element_text(size = 10, face = "bold"),
        plot.title = element_text(size = 14, face = "bold")) +
  scale_x_continuous(expand = c(0, 0), limits = c(0, NA))

print(p1)
ggsave("tf_idf_analysis.png", p1, width = 10, height = 15, units = "in")

# 2. Topic Modeling Analysis
usenet_dtm <- usenet_data %>%
  unnest_tokens(word, message) %>%
  count(newsgroup, word) %>%
  cast_dtm(newsgroup, word, n)

usenet_lda <- LDA(usenet_dtm, k = 5, control = list(seed = 1234))
usenet_topics <- tidy(usenet_lda, matrix = "beta")

# Visualize top terms for each topic
usenet_top_terms <- usenet_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>% 
  ungroup() %>%
  arrange(topic, -beta)

p2 <- ggplot(usenet_top_terms, aes(beta, reorder(term, beta), fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  labs(x = "Beta", y = "Term", 
       title = "Top 10 Terms for Each Topic",
       subtitle = "Based on LDA Topic Modeling")

print(p2)
ggsave("topic_modeling.png", p2, width = 12, height = 8, units = "in")

# 3. Sentiment Analysis by Word
usenet_sentiment <- usenet_data %>%
  unnest_tokens(word, message) %>%
  inner_join(get_sentiments("bing")) %>%
  count(newsgroup, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

p3 <- ggplot(usenet_sentiment, aes(newsgroup, sentiment, fill = sentiment > 0)) +
  geom_col() +
  coord_flip() +
  labs(x = "Newsgroup", y = "Overall Sentiment Score", 
       title = "Sentiment Analysis by Newsgroup",
       subtitle = "Positive vs Negative Words") +
  scale_fill_manual(values = c("red", "green"), guide = FALSE)

print(p3)
ggsave("sentiment_analysis.png", p3, width = 10, height = 6, units = "in")

# 4. Sentiment Analysis by Message
usenet_message_sentiment <- usenet_data %>%
  group_by(newsgroup) %>%
  mutate(message_id = row_number()) %>%
  ungroup() %>%
  unnest_tokens(word, message) %>%
  inner_join(get_sentiments("bing")) %>%
  count(newsgroup, message_id, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

p4 <- usenet_message_sentiment %>%
  group_by(newsgroup) %>%
  summarize(avg_sentiment = mean(sentiment)) %>%
  ggplot(aes(newsgroup, avg_sentiment, fill = avg_sentiment > 0)) +
  geom_col() +
  coord_flip() +
  labs(x = "Newsgroup", y = "Average Sentiment per Message", 
       title = "Average Sentiment by Newsgroup",
       subtitle = "Based on Individual Message Sentiment") +
  scale_fill_manual(values = c("red", "green"), guide = FALSE)

print(p4)
ggsave("avg_sentiment_by_newsgroup.png", p4, width = 10, height = 6, units = "in")

# 5. N-gram Analysis
usenet_bigrams <- usenet_data %>%
  unnest_tokens(bigram, message, token = "ngrams", n = 2) %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  filter(!word1 %in% stop_words$word, !word2 %in% stop_words$word) %>%
  count(newsgroup, word1, word2, sort = TRUE)

# Visualization for top bigrams
p5 <- usenet_bigrams %>%
  group_by(newsgroup) %>%
  slice_max(n, n = 10) %>%
  ungroup() %>%
  mutate(bigram = paste(word1, word2, sep=" ")) %>%
  ggplot(aes(n, reorder(bigram, n), fill = newsgroup)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ newsgroup, scales = "free_y", ncol = 1) +
  labs(x = "Count", y = "Bigram", 
       title = "Top 10 Bigrams by Newsgroup",
       subtitle = "Most Frequent Word Pairs") +
  theme(axis.text.y = element_text(size = 8),
        strip.text = element_text(size = 10, face = "bold"),
        plot.title = element_text(size = 14, face = "bold")) +
  scale_x_continuous(expand = c(0, 0), limits = c(0, NA))

print(p5)
ggsave("top_bigrams.png", p5, width = 10, height = 15, units = "in")

# Save key data frames
write.csv(usenet_tf_idf, "usenet_tf_idf.csv", row.names = FALSE)
write.csv(usenet_top_terms, "usenet_top_terms.csv", row.names = FALSE)
write.csv(usenet_sentiment, "usenet_sentiment.csv", row.names = FALSE)
write.csv(usenet_message_sentiment, "usenet_message_sentiment.csv", row.names = FALSE)
write.csv(usenet_bigrams, "usenet_bigrams.csv", row.names = FALSE)

