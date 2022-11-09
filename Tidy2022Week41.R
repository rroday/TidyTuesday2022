library(tidytuesdayR)
library(ggplot2)
library(dplyr)
library(wordcloud)
library(tm)

tuesdata <- tidytuesdayR::tt_load('2022-10-11')

df<-tuesdata$yarn

head(df)

Sweater <- df %>% 
  filter(c(machine_washable == TRUE),
         (rating_average > 4.90),
         (rating_count > 50),
         (discontinued == FALSE),
         (texture_clean == "plied"))

unique(Sweater$name)

#Create string of text from yarn name column 
text <- Sweater$name 

# Create a corpus  
docs <- Corpus(VectorSource(text))

dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
data <- data.frame(word = names(words),freq=words)

wordcloud(words = data$word, freq = data$freq, min.freq = 1,  
          max.words=400, random.order=FALSE, rot.per=0.35,   
          colors=brewer.pal(8, "Spectral")) 
         