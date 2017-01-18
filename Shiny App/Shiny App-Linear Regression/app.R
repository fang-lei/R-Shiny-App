# Linear regression with uploaded data file

library(shiny)
library(readxl)

ui = fluidPage(
  h1("Linear Regression Analysis"),
  p(style = "font-family: Impact", "See oterh apps and codes in",
    a("Lei's GitHub", 
      href = "https://github.com/fang-lei/R-Shiny-App")),
  tags$hr(),
  titlePanel("Model Setting"),
  sidebarLayout(
    sidebarPanel(
      fileInput(inputId = 'file1', 
                label = 'Choose an Excel File with Header',
                accept = c(".xlsx")
      ),
      tags$hr(),
      sliderInput(inputId = "ci",
                  label = "Confidence Interval",
                  min = 1,
                  max = 100,
                  value = 95,
                  step = 1
      ),
      actionButton(inputId = "go",
                   label = "Update"
      )
    ),
    mainPanel(
      tableOutput('contents'),
      tableOutput('parameters_estimation'),
      plotOutput('estimation')
    )
  )
)

server <- function(input, output) {
  output$contents <- renderTable({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    file.rename(inFile$datapath,
                paste(inFile$datapath, ".xlsx", sep = ""))
    read_excel(paste(inFile$datapath, ".xlsx", sep = ""), sheet = 1)
  })
  data = eventReactive(eventExpr = input$go,
               valueExpr = {read_excel(paste(inFile$datapath, ".xlsx", sep = ""), sheet = 1)})
  
}

shinyApp(ui = ui, server = server)