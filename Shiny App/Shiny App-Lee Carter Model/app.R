# design user interactive webpage for Lee Carter model for death rates

library(shiny)

ui = fluidPage(
  h1("Lee-Carter Model for death rates"),
  p(style = "font-family: Impact", "See oterh apps and codes in",
    a("Lei's GitHub", 
      href = "https://github.com/fang-lei/R-Shiny-App")),
  tags$hr(),
  headerPanel("Model Setting"),
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