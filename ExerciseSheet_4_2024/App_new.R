library(shiny)
library(ggplot2)

# Function to generate correlated data
generate_correlated_data <- function(correlation, n) {
  alpha <- correlation
  beta <- sqrt(1 - correlation^2)
  
  x1 <- runif(n)
  x2 <- runif(n)
  
  x_correlated <- alpha * x1 + beta * x2
  
  return(data.frame(x1, x2 = x_correlated))
}

# Leaderboard data
leaderboard <- data.frame(
  Player = character(),
  Guess = numeric(),
  Difference = numeric(),
  stringsAsFactors = FALSE
)

# Define UI
ui <- fluidPage(
  titlePanel("Jacob & Jan’s Shiny App"),
  
  tags$style(HTML("
    .great-guess {
      color: green;
      font-weight: bold;
    }
    .bad-guess {
      color: red;
      font-weight: bold;
    }
  ")),
  
  tabsetPanel(
    tabPanel(
      "Scatter Plot",
      textInput("playerName", "Enter your name:", ""),
      textOutput("currentPlayer"),
      plotOutput("scatterPlot"),
      numericInput("guess", "Enter your guess for the correlation:", value = 0, min = -1, max = 1, step = 0.01),
      actionButton("newPlot", "Generate New Plot"),
      actionButton("submitGuess", "Submit Guess")
    ),
    
    tabPanel(
      "Solution",
      verbatimTextOutput("correlationOutput"),
      verbatimTextOutput("guessDifference"),
      verbatimTextOutput("correlationInterpretation"),
      verbatimTextOutput("hintOutput"),
      verbatimTextOutput("congratulatoryMessage")
    ),
    
    tabPanel(
      "Leaderboard",
      tableOutput("leaderboardTable")
    ),
    
    tabPanel(
      "Sandbox",
      sliderInput("correlationSlider", "Correlation Coefficient:", min = -1, max = 1, value = 0),
      numericInput("numObservations", "Number of Observations:", value = 100, min = 10, max = 1000),
      actionButton("updatePlot", "Update Plot"),
      plotOutput("sandboxPlot")
    )
  )
)

# Define server
server <- function(input, output, session) {
  correlation <- reactiveVal(runif(1, -1, 1))
  
  df <- reactive({
    generate_correlated_data(correlation = correlation(), n = 100)
  })
  
  output$currentPlayer <- renderText({
    paste("Currently playing:", input$playerName)
  })
  
  output$scatterPlot <- renderPlot({
    ggplot(df(), aes(x = x1, y = x2)) +
      geom_point() +
      labs(x = "x1", y = "x2") +
      theme_minimal()
  })
  
  output$correlationOutput <- renderPrint({
    cor(df()$x1, df()$x2)
  })
  
  output$guessDifference <- renderPrint({
    diff <- abs(cor(df()$x1, df()$x2) - input$guess)
    if (diff < 0.1) {
      return(paste("Great Guess! The difference is:", diff))
    } else {
      return(paste("The difference is:", diff))
    }
  })
  
  output$correlationInterpretation <- renderPrint({
    actual_correlation <- cor(df()$x1, df()$x2)
    direction <- ifelse(actual_correlation > 0, "positive", "negative")
    magnitude <- ifelse(abs(actual_correlation) < 0.3, "weak",
                        ifelse(abs(actual_correlation) < 0.7, "moderate", "strong"))
    paste("Direction:", direction, "| Magnitude:", magnitude)
  })
  
  output$hintOutput <- renderPrint({
    actual_correlation <- cor(df()$x1, df()$x2)
    diff <- abs(actual_correlation - input$guess)
    if (diff > 0.5) {
      if (actual_correlation > input$guess) {
        return("Hint: The actual correlation is higher than your guess.")
      } else {
        return("Hint: The actual correlation is lower than your guess.")
      }
    } else {
      return("No hint needed.")
    }
  })
  
  output$congratulatoryMessage <- renderPrint({
    actual_correlation <- cor(df()$x1, df()$x2)
    if (abs(actual_correlation - input$guess) < 0.01) {
      return("Congratulations! Your guess is almost perfect!")
    } else {
      return("")
    }
  })
  
  observeEvent(input$newPlot, {
    correlation(runif(1, -1, 1))
  })
  
  observeEvent(input$submitGuess, {
    diff <- abs(cor(df()$x1, df()$x2) - input$guess)
    new_entry <- data.frame(
      Player = input$playerName,
      Guess = input$guess,
      Difference = diff
    )
    leaderboard <<- rbind(leaderboard, new_entry)
    output$leaderboardTable <- renderTable({
      leaderboard
    })
  })
  
  observeEvent(input$updatePlot, {
    df_sandbox <- generate_correlated_data(correlation = input$correlationSlider, n = input$numObservations)
    
    output$sandboxPlot <- renderPlot({
      ggplot(df_sandbox, aes(x = x1, y = x2)) +
        geom_point() +
        labs(x = "x1", y = "x2") +
        theme_minimal()
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
