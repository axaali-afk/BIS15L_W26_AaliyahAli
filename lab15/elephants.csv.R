library(tidyverse)
library(janitor)
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title="The Range of Age and Height of Elephants by Sex"),
  dashboardSidebar(
    selectInput("y",
                "Select Elephant Variable",
                choices = c("age",
                            "height"),
                selected = "age")
  ),
  
  dashboardBody(
    plotOutput("plot", width="600px", height= "500px")
    
  )
  
  
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    
    elephants %>% 
      filter(sex!="NA") %>% 
      ggplot(aes(x = sex,
                 y = .data[[input$y]],
                 fill = sex))+
      geom_boxplot(alpha=0.75)+
      labs(title="Elephant Variables by Sex",
           x="Sex",
           fill="Sex")+
      theme_minimal()
  })
}

shinyApp(ui, server)
