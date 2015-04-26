library(shiny)
source("CapstonePredict.R")

shinyServer(
  function(input,output){
    
    wordsPediction <- reactive({lastWordsPredict(input$userText)})
    
    output$firstchoice    <- renderText({
      wordsPediction()[1]
    })
    output$secondchoice  <- renderText({
      wordsPediction()[2]
    })
    output$thirdchoice   <- renderText({
      wordsPediction()[3]
    })
 }
)
