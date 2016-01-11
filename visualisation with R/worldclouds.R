#this file generates a worldcloud for the twitter words in the sentiment dictionary

library("wordcloud")
library("RColorBrewer")
library("plyr")

data1 <- read.csv("freq1.csv", sep=",", header = FALSE)
data2 <- read.csv("freq2.csv", sep=",", header = FALSE)
data3 <- read.csv("freq3.csv", sep=",", header = FALSE)

data12 <- rbind(data1,data2)
data <- rbind(data12, data3)


names(data) <- c("word", "freq")
data <- aggregate(freq~word,data,FUN=sum)

data$word <- as.character(data$word)
head(data)
set.seed(1234)
wordcloud(words = data$word, freq = data$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))



set.seed(1234)
pal <- brewer.pal(6,"Dark2")
pal <- pal[-(1)]
wordcloud(data$word,data$freq,c(8,.3),2,,TRUE,TRUE,.15,pal)
png("freq_NYE_words.png", bg = "white", width = 400, height = 400)
wordcloud(words = data$word, freq = data$freq, min.freq = 1,
          scale=c(8,.2),
          max.words=800, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
dev.off()

set.seed(1344)

wordcloud(words = data$word, freq = data$freq, min.freq = 1,
          scale=c(8,.2),
          max.words=800, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


