library(shiny)

#Define UI
shinyUI(
  pageWithSidebar(
    headerPanel("Fuel Efficiency prediction"),
    
    sidebarPanel(    
      helpText("Calculate vehicle fuel efficiency by entering vehicle weight, transmission type, and quarter-mile time."),
      
      selectInput("transmission", label = h3("Transmission"),
                  choices = list("Automatic" = 0, "Manual" = 1)),
      
      numericInput("weight",
                   min = 0,
                   max = 36000,
                   value = 1500,
                   step = 500,
                   label = h3("Weight (kg)")),
      
      numericInput("qsec", 
                   min = 0,
                   max = 100,
                   value = 10,
                   step = 0.5,
                   label = h3("Quarter Mile Time (s)"))      
      ),
    
    mainPanel(
      h3('Results of prediction'),
      h4('You entered'),
      textOutput("inputwt"),
      textOutput("inputtrans"),
      textOutput("inputqsec"),
      h4('Which resulted in a prediction of '),
      textOutput("prediction")
      )
    
    ))