#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
options(shiny.maxRequestSize=30*1024^2, encoding='WINDOWS-1252')
source('valfun.R')

server <- function(input, output) {
  
  #Sync with stationregister
    validation_data<-"./stn_reg/Stationsregistret_export.txt"
    df_two <- read.csv(validation_data,
                         header = TRUE,
                         sep = '\t',
                         quote = '"')
     # for test
     #out_data<-df_two
     #
     output$station_match<-renderTable({
       
     # read data for validation
     req(input$file1)
 
     # when reading semicolon separated files,
     # having a comma separator causes `read.csv` to error
     tryCatch(
       {
          df <- read.csv(input$file1$datapath,
                         sep = input$sep,
                         quote = input$quote)

       },
       error = function(e) {
         # return a safeError if a parsing error occurs
         stop(safeError(e))
       }
     )
     out_data<-stn_match_fun(df, df_two)
    if(input$disp == "fails") {
      ind_col<-which(colnames(out_data)=='difference')
      index<-which(out_data[,ind_col] != "0")
      out_data<-out_data[index,]
     return(out_data)
   }else{
     return(out_data)
   }
   
   }, # end renderDataTable
     striped = TRUE) # options for renderDataTable

}
