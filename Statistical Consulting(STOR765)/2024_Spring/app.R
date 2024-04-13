#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(tidyverse)
library(shiny)
library(SiZer)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Density Estimation Function"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput('column',
                        'Column',
                        choices = c('Experimental_1',
                                    'Experimental_2',
                                    'Experimental_3',
                                    'Experimental_4',
                                    'Experimental_5',
                                    'Model_1',
                                    'Model_2',
                                    'Model_3',
                                    'Model_4',
                                    'Model_5')
                        ),
          
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 100,
                        value = 30
                        )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
           br(),
           plotOutput('SIZer')
        )
    )
)

data <- read.csv('data/division_times.csv')


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate width based on sliderInput
        col_name    <- input$column
        width <- input$bins
        
        col_data_booloon <- data[,col_name] %>% is.na
        col_data <- data[,col_name]
        col_data_revised <- col_data[!col_data_booloon]
        
        # draw the desity estimation plot
        den <- density(col_data_revised, kernel = c('gaussian'),width = width)
        plot(den, main = 'Desity Estimation Function')
      
        
    })
    
    output$SIZer <- renderPlot({
      # generate width based on sliderInput
      col_name    <- input$column
      width <- input$bins
      
      col_data_booloon <- data[,col_name] %>% is.na
      col_data <- data[,col_name]
      col_data_revised <- col_data[!col_data_booloon]
      
      # draw the desity estimation plot
      den <- density(col_data_revised, kernel = c('gaussian'),width = width)
      
      SiZer.1 <- SiZer(den$x, den$y, h=c(.5,100), degree=1, derv=1, grid.length=21)
      plot(SiZer.1)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)


