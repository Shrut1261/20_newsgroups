# 20_Newsgroups Dataset

## Dataset Availability
**Dataset Link:** [20 Newsgroups Dataset](https://www.kaggle.com/datasets/crawford/20-newsgroups)

## Description
This project is part of my fifth assignment, where I analyzed a dataset containing approximately **20,000 messages** from **20 different Usenet newsgroups**. For this analysis, I focused on a subset of **2,992 messages** from three selected groups to compare technology-related discussions in the early 1990s. The selection was necessary because, after processing **4,000 messages**, my **R Studio crashed**, leading me to refine my dataset.

This comparison provides an exciting opportunity to explore how technology was discussed in different contexts such as **graphics, space science, and general discussions** during the early days of the internet. 

Following text mining methodologies, I applied several techniques including **TF-IDF analysis, topic modeling, sentiment analysis, and n-gram analysis** to uncover patterns in language use, dominant topics, and emotional tone across these newsgroups.

## Key Analysis Points

### 1. TF-IDF Analysis
- Determines the most distinctive words within each newsgroup.
- Highlights frequently used terms unique to specific discussions.

### 2. Topic Modeling Analysis
- Identifies hidden themes by grouping words that frequently appear together.

### 3. Sentiment Analysis (Word-Level)
- Assesses emotional tone by analyzing individual word sentiments.

### 4. Sentiment Analysis (Message-Level)
- Evaluates overall sentiment in messages based on the combined sentiment of words.

### 5. N-Gram Analysis
- Detects frequently occurring word sequences to understand common linguistic patterns.

## Graphical Representations & Insights

### **1. Top 10 Most Distinctive Terms by Newsgroup (TF-IDF Analysis)**
![TF-IDF Analysis](https://github.com/user-attachments/assets/b6ae19c3-8a21-427d-8f48-0daab6eba59d)
- Highlights the most commonly used terms in **comp.graphics, sci.space, and talk.politics.misc** newsgroups.
- Provides insights into the unique language and key discussion points of each group.

### **2. Top Terms for Each Topic (Topic Modeling Analysis)**
![Topic Modeling](https://github.com/user-attachments/assets/88d1c033-607e-4485-bac6-9f44cddb8a69)
- Identifies the most frequent terms within topics.
- Shows discussions related to **file formats, image compression, and space science**.
- Indicates heavy discussions around **GIF, JPEG, and BMP formats** in the 1990s.

### **3. Sentiment Analysis by Newsgroup**
![Sentiment Analysis](https://github.com/user-attachments/assets/a7ed280c-fadd-454d-8973-3330dcad0a95)
- Visualizes the emotional tone across the three analyzed newsgroups.
- Findings:
  - **comp.graphics** has a more positive tone.
  - **sci.space** maintains a neutral sentiment.
  - **talk.politics.misc** leans toward a negative sentiment, reflecting debate-driven discussions.

### **4. Average Sentiment by Newsgroup**
![Average Sentiment](https://github.com/user-attachments/assets/3bf5aae9-de5f-485b-a57b-6fedd5487435)
- Focuses on **talk.politics.misc**, highlighting a **negative sentiment trend**.
- The bar lengths indicate the **strength of sentiment**, where longer bars reflect stronger emotional expressions.

### **5. N-Gram Analysis**
![N-Gram Analysis](https://github.com/user-attachments/assets/9a486fc6-4f52-44ae-932a-979daa785cb5)
- Reveals **the most frequently used bigrams (two-word sequences)** across different newsgroups.
- Provides insights into common discussion themes and linguistic patterns.

## Conclusion
Through this project, I explored **how technology, science, and politics were discussed in the 1990s**. The analysis revealed:
- **Technology-focused discussions** (comp.graphics) were neutral and highly technical.
- **Space discussions** (sci.space) maintained a balanced tone, with excitement around NASA and space exploration.
- **Political discussions** (talk.politics.misc) carried a more negative sentiment, reflecting debate-driven conversations.

Additionally, the presence of **frequent "tech talk"** across all groups showed that even in the 1990s, discussions about technology's future were widespread. 

This study reinforced how **language patterns, human interactions, and topics evolve over time**, but certain themes—like **technology's role in society**—remain just as relevant today as they were back then.

---
### Repository Contents:
✔️ **Data processing scripts**
✔️ **Analysis reports**
✔️ **Visualization outputs**
✔️ **Final conclusions and insights**

For any suggestions or discussions, feel free to open an **issue** or contribute via **pull requests**! 🚀
```

