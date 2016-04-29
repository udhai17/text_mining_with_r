# Script: tfidf.R
# 
# A script written and distributed as a teaching
# aid for demonstrating how to perform corpus
# stemming in R.  The script reads files from
# an identified directory into a corpus and then
# creates a normalized TF-IDF matrix.
#
# Copyright Carl G Stahmer
#
# This work is licensed under a Creative Commons 
# Attribution-ShareAlike 4.0 International License.
#
# see http://creativecommons.org/licenses/by-sa/4.0/

# install.packages("tm")

library(tm)

###################################
#         configuration           #
###################################

# set working directory
setwd("~/Documents/rstudio_workspace/digitalmethods/text_mining/")

# define the input directory for the texts to
# be analyzed
input.dir <- "~/Documents/rstudio_workspace/digitalmethods/text_mining/data/plainText"

###################################
#      function declarations      #
###################################

# A callable function that writes out the contents
# of a vector in human readable form.
show.vector <- function(file.name.v) {
  for(i in 1:length(file.name.v)) { 
    cat(i, file.name.v[i], "\n", sep=" ")
  } 
}

###################################
#        Operational Code         #
###################################

# create a tm corpus
termMatrix.corpus <- VCorpus(DirSource(directory = input.dir), readerControl = list(language = "en"))

# create the tdm from the corpus
stemmed.tdm <- TermDocumentMatrix(termMatrix.corpus,
                                  control = list(removePunctuation = TRUE,
                                                 stopwords = TRUE,
                                                 stripWhitespace = TRUE,
                                                 stemming = TRUE))
# create tf-idf matrix
tfidf.matrix <- weightTfIdf(stemmed.tdm, normalize = TRUE)

# print the stats of the tfdif matrix
tfidf.matrix

# get the number of rows in the tfidf
numrows <- nrow(tfidf.matrix)

# get the number of columns in the tfidf
numcols <- ncol(tfidf.matrix)

# loop throught the matrix by column
for (document in 1:numcols) {
  
  print(paste("Document:", document))
  inspect(tfidf.matrix[500:550, document])
}

