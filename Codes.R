#readfile
tx <- read.csv("Speech.csv")
head(tx)
class(tx$Speech)

#converttocharacter
tx$Speech <- as.character(tx$Speech)

#inspecthead
head(tx$Speech, 3)

#load libraries
library(tm)
library(SnowballC)
library(wordcloud)

#convert to corpus and check content
corp <- Corpus(VectorSource(tx$Speech))
corp[[1]]$content

#convert to lowercase
corp <- tm_map(corp, content_transformer(tolower))

#remove punctuation
corp <- tm_map(corp, removePunctuation)

#remove stop words
corp <- tm_map(corp, removeWords, stopwords("english"))

#reduce terms to stems
corp <- tm_map(corp, stemDocument, "english")

#strip whitespace
corp <- tm_map(corp, stripWhitespace)

#re-inspecting corpus
corp[[1]]$content

#create wordcloud
wordcloud( words= corp, max.words = 100,scale = c(3,0.5), colors = "blue")


#politeness checking
library(politeness)

#politeness function
polite <- politeness(tx$Speech)

#politeness table
polite[1:10,1:5]
tail(polite)

#plotting of first 5 columns of politeness table
#to check the useage of various criterias of politness
matrix <- as.matrix(polite[1:50,1:5])
barplot(matrix, cex.names = 0.55, main = "Politeness Criteria Plot",
        ylab = "Usage Count" , xlab = "Criteria" , col = "blue")

#for politeness plot ggplot2 is required
library(ggplot2)

#politeness plotting based on the use of hedges
#hedges are words, sounds or constructions used to lessen the impact of utterance
#due to constraints between speaker and addressee i.e. politeness
pol <- polite[1:50,2:10]

politeness::politenessPlot(pol,
                           split=polite[1:50,]$Hedges,
                           split_levels = c("High","Low"),
                           split_name = "Hedges")










