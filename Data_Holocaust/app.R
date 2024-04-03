
# Load libraries
library(shiny)
library(dplyr)
library(ggplot2)

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Holocaust Victims by Religion"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      # Checkbox group input for selecting religions
      checkboxGroupInput("religions", "Select Religions",
                         choices = c("Agnostic", "andere", "Atheist", "Believes in God", "Buddhist", "Catholic", 
                                     "Czech-Moravian", "Eastern Orthodox", "Greek Catholic", "Greek Orthodox", 
                                     "Hussite", "Jehovah's Witness", "Jew", "Muslim", "Protestant", 
                                     "Russian Orthodox", "Unaffiliated", "Unknown"),
                         selected = "Jew")
    ),
    
    # Main panel for displaying the graph and table
    mainPanel(
      # Output: Interactive plot
      plotOutput("plot"),
      
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Read data
  data <- read.csv("input_data.csv")
  
  # Define a reactive expression to filter data based on selected religions
  filtered_data <- reactive({
    filter(data, Religion %in% input$religions)
  })
  
  # Render the interactive plot
  output$plot <- renderPlot({
    ggplot(filtered_data(), aes(x = Religion)) +
      geom_bar() +
      labs(title = "Holocaust Victims by Religion",
           x = "Religion",
           y = "Number of Victims")
  })
  
  # Render the interactive table
  output$table <- renderTable({
    filtered_data()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
