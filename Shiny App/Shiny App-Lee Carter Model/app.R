# design user interactive webpage for Lee Carter model for death rates

library(shiny)

ui = fluidPage(
  headerPanel("Lee-Carter Model for death rates"),
  selectInput(inputId = "country",
              label = "Choose a country",
              choices = c("Austrilia" = "AUS",
                          "Canada" = "CAN",
                          "Denmark" = "DNK",
                          "Norway" = "NOR",
                          "United States" = "USA")),
  plotOutput("LC"))

server = function(input, output) {
  output$LC = renderPlot({
    
  })
}

shinyApp(ui = ui, server = server)