

========================================================
 Coursera/JHU University/Swiftkey
 
 Data Science Specialisation

 Capstone Project.

         Next Word Prediction Using
         N-gram Lamguage Model
         A shiny Application

author: A. ESSODEGUI  
date:   04/25/2015

         My thanks to Coursera JHU and you fellow students for making it happen.

=======================================================

INTRODUCTION:
* N-gram Models Concept: The goal of a probalistic language modeling is to
compute the probability of a sentence or a sequence of words P(W)=P(w1,w2,w3,w4,w5...wn).

* The task in this project is related to this type of modeling.Predicting an upcoming word Wn is based on calculating the probabilty P(Wn|W1..Wn-1), and the model that computes either P(W) or P(wn|w1,w2.wn-1) is called a language model.

* How to estimate these probalities:by the Maxinmum Liklihood Estimate(MLE): P(wi | wi-1) = count(wi-1,wi )/count(wi-1) .Not all counts are available,some words are not in the training data ,and P(wi|Wi-1) will be indefined which requires smoothing.Fore more go [here](https://www.coursera.org/course/nlp).

=====================================================================

 Building the N-gram Model: 
 * The corpus comes from media files(blogs-news-twitter) a file of size 548MB ,with around 4.3 millions lines and 102 milions words and an average of 6 characters/word.
 * Corpus Cleaning : no ASCCI characters removed, lower cases,no numbers and and stopwords,no urls among others.
 * Due to the limited ressources and the shiny App requirement a random samlping was used. Vocabulary was reduced to aroud 43700 words covering 97.5% of total occurences.
 * 4 n-grams were created (unigrams-bigrams-trigrams and 4-grams) using RWeka , unique unigrams were calculated and saved.
 
======================================================================
 
 * bigrams,trigrams and 4-grams were split into two components : lastWord and firstWords (from 1 to 3).Then by using ddply() function ,the frequency tables of all n-grams were calculated and rbinded to get a unique table i called ngramFreqTable and saved.
 
 * Algorithm and the Shiny Application:
 
 * The App takes the input phrase typed by the user and cleans it the same way the corpus was.
 
 * Split the phrase into words, reduce it to 3 and check for unkown words.
 * Creates the phrase n-grams, and match them with the firsWord in the combined ngramFrequencyTabe and come up with the most frequent lastWord.
 
===========================================================================
 This way the next word , if it exists ,will be in either one of the ngrams whichever is the top order.The App looks in 4-grams,3-grams,2-grams and cover the smoothing problem if it occurs.Details are [here](https://github.com/apikou/CapstoneProjectShinyApp.git).If no match is found the aggregate function would detect a 0 nrow ,i choose to return an NA as a prediction i could have choosen the top ungram word. App code is here.The App returns the Next Word and 2 other choices.
 * I was really limited by my 4 GB ram ,i had to keep the sample very low,
 which affects the algorithm precision ,more need to be done like stemming words tagging.
 * Take a look at my shiny App [here](https://apikou.shinyapps.io/SwiftKeyShinyApp/) .  
 
           
