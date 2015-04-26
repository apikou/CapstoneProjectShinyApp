library(shiny)
shinyUI(
  pageWithSidebar(
  titlePanel("Next Word Prediction Application"),
  
  sidebarPanel(
    p('This App will try to predict the next word and propose the next
       2 choices.If the phrase length is more than 3 words, the 
       prediction will be based on the phrase last three words only.'),
    p('The application algorithm is based on N-grams statistical
       Language Models. ')
  ),
       
  mainPanel(
    h4('Please type your phrase in the box below'),
    textInput("userText", "",""),
    h4("Firstchoice:"),
    span(h4(textOutput("firstchoice")) , style ="color:red"),
    h4("Other choices:"),
    span(h4(textOutput("secondchoice")), style ="color:green"),
    span(h4(textOutput("thirdchoice")) , style ="color:green")
      )
))