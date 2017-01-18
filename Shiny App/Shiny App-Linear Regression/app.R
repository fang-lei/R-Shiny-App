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
      ),
      
      tags$hr(),
      
      helpText("This App employs ordinary least squares (OLS) to fit a linear 
               regression to the data set you upload. The data must be stored in 
               Excel file with header, and varible y is stored in the first column 
               while x is the second one.")
      
    ),
        
    mainPanel(
      tableOutput('contents'),
      plotOutput('estimation'),
      verbatimTextOutput('parameters_estimation')
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
               valueExpr = {read_excel(paste(input$file1$datapath, ".xlsx", sep = ""), sheet = 1)})
  
  output$estimation = renderPlot({
    pred.clm = predict(lm(data()[,1] ~ data()[,2]), interval = "confidence", level = input$ci/100)
    matplot(data()[,2], pred.clm, lty = c(1,2), type = "l", xlab = names(data())[2], ylab = names(data())[1])
  })
  
  output$parameters_estimation = renderPrint({
    summary(lm(data()[,1] ~ data()[,2]))
  })
}

shinyApp(ui = ui, server = server)