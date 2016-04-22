
shinyUI(
  navbarPage("Next Word Predictor",
             tabPanel("Main",
                      fluidRow(
                        column(4,
                               #textInput("inputs", label = "Input Some Words", value = ""),
                               tags$textarea(id="inputs", rows=8, cols=50, label = "Input Some Words", value = ""),
                               textOutput("words")),
                        column(2, numericInput("num", "Number of Predictions", 15, min = 1))
                        )),
             navbarMenu("About", tabPanel("What is this?", includeMarkdown("about.Rmd")),
                                  tabPanel("How does it work?", includeMarkdown("finalReport.Rmd")))
             )
  )

