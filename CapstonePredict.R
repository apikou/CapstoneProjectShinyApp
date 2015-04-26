library(data.table)
library(tm)
load("ngramsFreqTable.rds")
load("uniqueWords.rds")

# clean: cleaning function

clean <- function(x){
  # cleans out no ASCII characters
  x <- lapply(x,function(row) iconv(row,"latin1","ASCII",sub=""))
  # alphabetic only keep apostrophes (')     
  x <- gsub("[^[:alpha:][:space:]']","",x)
  # lower case
  x <- tolower(x)                              
  x <- removeWords(x,stopwords("english"))
  # remove URLs 
  x <- gsub("f|ht)tp(s?)://(.*)[.][a-z]+","",x)
  # remove twitter accounts
  x <- gsub("@[^\\s]+","",x,perl=TRUE) 
  # printable characters only
  x <- gsub("[^:[:print:]]","",x)
  # returns string w/o leading spaces
  x <- sub("^\\s+","",x)
  # remove extra spaces
  x <- stripWhitespace(x)
  # remove characters repeted 3 or more times 
  x <- gsub("(.)\\1{2,}","\\1\\1",x)  
  return(unlist(x))
}
     
# ngram firstWords and lastWord :

# firstWords:this function takes an ngram name and converts it
# into words and returns  the ngram first  Words(1,2 or 3).
# lastWord  : this function returns the ngram last word. 

firstWords <- function(x){
  
  y <- unlist(strsplit(x, " "))
  return(paste(y[1:length(y)-1], collapse=" "))
  
}

lastWord <- function(x){
  
  y <- unlist(strsplit(x, " "))
  return(y[length(y)])                
  
}

# Remove unkown words:  
# remove unkown words (may add them later) this function split the
# the inputPhrase into words and remove the unkown words.

noUnknownWords <- function(phrase){
  z <- c()
  phraseWordS <- unlist(strsplit(phrase," "))
  for(i in 1:length(phraseWordS)){
    z[i] <-  phraseWordS[i] %in% uniqueWords
  }   
  return(phraseWordS[z])
}


# Adjust the phrase length and keep the last 3 words. 
# I am assuming here that the phrase last word prediction will be
# based on the  preceeding 3 words(Markov 1st,2th and 3th order),any 
# phrase longer than 3 words willbe cut to its 3 tail words.

phraseLength <-function(inputPhrase){ 
  
  phraseLength <- length(inputPhrase)
  if (phraseLength == 1){
    return(inputPhrase)
  }
  if (phraseLength == 2){
    return(inputPhrase)
  }
  if (phraseLength >= 3){
    return(tail(inputPhrase,3))
  }
}


# Phrase ngrams: trigram-bigram-unigram (W1W2W3- W2W3-  W3)

phraseNgrams <- function(thePhrase){
  theNgrams <- c()
  thePhraseLength <- length(thePhrase)
  for(i in 1:thePhraseLength){
    theNgrams <- c(theNgrams, paste(thePhrase[i:thePhraseLength],collapse=" "))
  }
  return(theNgrams)
}

# Find the top words

topWords <- function(thengrams,FreqTable ,n){
  
      theWords <- FreqTable[FreqTable$firstWords %in% thengrams,]
      if( nrow(theWords) == 0){
        return("NA")
      }      
      aggWords <- aggregate(V1 ~ lastWord, data=theWords, sum)
      aggWords <- aggWords[with(aggWords, order(-V1)),]
      return(head(aggWords$lastWord, n))
}

# Predict the last word :

lastWordsPredict <- function(inputPhrase){
  
    prediction <- clean(inputPhrase)
    prediction <- noUnknownWords(prediction)
    prediction <- phraseLength(prediction)
    prediction <- phraseNgrams(prediction)
    prediction <- topWords(prediction,ngramsFreqTable , 4)
    
  return(prediction)
}  
    
