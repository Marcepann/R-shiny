# Kaja Lucka

# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a plot
fluidPage(
  # Application title
  titlePanel("Gene expression"),
  
  # Sidebar with a slider input for chosen gene
  sidebarLayout(
    sidebarPanel(
      selectInput(
          "chosen_gene",
          "Choose a gene:",
           choices = unique(TPM_long$GeneID)
      ),
    ),
    
    # Show the generated plot
    mainPanel(plotOutput("hist"))
  )
)
