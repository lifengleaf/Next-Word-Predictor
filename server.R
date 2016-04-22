
library(data.table)
uniGram<- fread("data/uniGram.csv", drop = 1)
biGram<- fread("data/biGram.csv", drop = 1)
triGram<- fread("data/triGram.csv", drop = 1)

uniGramDT<- fread("data/uniGramDT.csv", drop = 1)
dict<- 1:nrow(uniGramDT)
names(dict) <- uniGramDT$Uni
n<- length(dict)

source("global.R")

shinyServer(
  function(input, output, session) {
    #read the input text
    inputs<- reactive({
      input$inputs
    })
    
    num<- reactive({
      input$num
    })
    
    #predict possible next words
    predWords<- reactive(predict(inputs(), num()))
    
    output$words<- renderText({
      words<- predWords()
    })
  }
)
