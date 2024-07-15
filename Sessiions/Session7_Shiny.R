install.packages("shiny")
library(shiny)
library(bslib)

###Example 1

#Hello Wolrd App

ui <- fluidPage("i love your ass")

server <- function(input, output) {
  
}

shinyApp(ui, server)

###Example 2

ui <- fluidPage("Hello World!")

server <- function(input, output) {
  
}

shinyApp(ui, server)


ui <- fluidPage(
  textInput("name", label = "Please type your name here"),
  textOutput("greeting")
  
)

server <- function(input, output) {
  output$greeting <- reactive(paste0("Hello,", input$name))
}

#oder anstatt reactive renderText

server <- function(input, output) {
  output$greeting <- renderText(paste0("Hello,", input$name))
}

shinyApp(ui, server)



#my special example

ui <- fluidPage("i love your ass")

server <- function(input, output) {
  
}

shinyApp(ui, server)
ui <- fluidPage(
  textInput("name", label = "Please love my ass too"),
  textOutput("greeting")
  
)

server <- function(input, output) {
  output$greeting <- reactive(paste0("Don´t make me sad", input$name))
}

shinyApp(ui, server)

###Example

#Basic Data viz of Gapminder variables
 install.packages("gapminder")
library(gapminder)
library(tidyverse)

 ui <- fluidPage(
   titlePanel("Gapminder Data Visualization"),
   sidebarLayout(
     sidebarPanel(selectInput("variable", label = "Select Variable", 
                              choices = names(gapminder))
  ),
  mainPanel(plotOutput("plot")
            )
  )
 )
 
 server <- function(input, output) {
   output$plot <- renderPlot(
     ggplot(data = gapminder, aes_string(x = input$variable)) +
       geom_density(fill = "lightblue") +
       labs(x= input$variable, y = "Density") +
       ggtitle(paste("Distribution of", input$variable))
   )
 }
 
 shinyApp(ui, server)
 
 
 ###Example 4
 
 ui <- fluidPage(
   selectInput("dataset", label = "Select Dataset", 
               choices = ls(package:datasets)),
   verbatimTextOutput("summary"),
   tableOutput("table")
 )
 
 server <- function(input, output) {
   dataset <- reactive(
     get(input$dataset, "package:datasets")
   )
   output$summary <- renderPrint(summary(dataset()))
   output$table <- renderTable(dataset())
 }
 
 shinyApp(ui, server)