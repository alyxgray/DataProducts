library(shiny)

data(mtcars)
mpg <- mtcars$mpg
model<- lm(mpg ~ ., data=mtcars)
best_model <- step (model, direction="both")


shinyServer(
  function(input, output) {
      output$inputwt <- renderText({
        paste("Weight: ", 
              round(input$weight, digits = 0),
              " kg (",
              round((input$weight / 0.45359237), digits = 0),
              " pounds)"
              )
        })
      
      output$inputqsec <- renderText({paste("Quarter Mile Time: ", input$qsec, " seconds")})
      output$inputtrans <- renderText({
        if(input$transmission == 0){
          paste("Transmission Type: ", "Automatic")
        } else if (input$transmission == 1){
          paste("Transmission Type: ", "Manual")
        }
      })
    output$prediction <- renderText({
      inputs <- data.frame(wt = (input$weight / 1000 * 2.2), qsec = input$qsec, am = as.numeric(input$transmission))
      if (round(predict(best_model, inputs), digits = 1) > 0){
        paste(
          round(235.214583 / predict(best_model, inputs), digits = 1),
          " L/100 KM ",
          "(",
          round(predict(best_model, inputs), digits = 1),
          " MPG)"
          )
        
      }else {
        "ERROR: MPG must be positive"
      }
    })    
  }
)