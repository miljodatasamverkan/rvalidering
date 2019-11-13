#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
# 
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # App title ----
  titlePanel("SMHI - Please select a file to validate"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("file1", "Choose CSV File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Select separator ----
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = "\t"),
      
      # Input: Select quotes ----
       radioButtons("quote", "Quote",
                    choices = c(None = "",
                                "Double Quote" = '"',
                                "Single Quote" = "'"),
                    selected = '"'),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Select rows to display all or only failed ----
      radioButtons("disp", "Display",
                   choices = c(Failed = "fails",
                               All = "all"),
                   selected = "all")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(

      tableOutput("station_match")
      
    )
    
  )
)
)
