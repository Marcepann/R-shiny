# Kaja Lucka

# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyr)
library(dplyr)
library(readr)

# Define server logic required to draw a histogram
function(input, output, session){
  # Convert TPMs_table_100genes.csv to long format 
  TPM_long <- reactive({
      read_csv("work_files/TPMs_table_100genes.csv") %>%
      pivot_longer(cols = matches("Control|Treated"), names_to = "Sample", values_to = "TPMs") %>% 
      separate(Sample, into = c("Condition", "Replicate"), sep = "_", remove = FALSE)
  })
  
  observe({updateSelectInput(session, "chosen_gene", choices = unique(TPM_long()$GeneID))})
  
  # Generate a plot
  output$hist <- renderPlot({
    TPM_filtered <- TPM_long() %>%
      filter(GeneID == input$chosen_gene)
    
    ggplot(TPM_filtered, aes(x = Sample, y = TPMs)) +
      geom_col(aes(fill=Condition)) +
      labs(
        title = paste("Expression of gene", input$chosen_gene),
        x = "Sample",
        y = "TPMs"
      ) +
      theme(
        axis.text.x = element_text(angle=45, vjust = 0.5, hjust=0.5),
        text = element_text(size = 18)  # Bigger text
      )+
      facet_wrap(~Condition, scales = "free_x")  # Divide into 2 plots
  })
}