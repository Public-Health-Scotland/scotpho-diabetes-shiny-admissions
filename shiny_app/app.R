##ScotPHO - website updates
##Code to create interactive chart for Diabetes Secondary Care Section
## https://www.scotpho.org.uk/health-conditions/diabetes/data/secondary-care/


#Instructions:
#Generate new year's data using the Diabetes.R script in the scotpho-website-updates repo
#Copy the data output into the data folder in your local version of the scotpho-diabetes-shiny repo


############################.
## Global ----
############################.

#Packages 
library(dplyr) #data manipulation
library(highcharter) #plots
library(phsstyles) #for chart colors
library(shiny) #shiny app
library(readr) #for reading in data
library(shinymanager) #for adding password protection

#Read in data
data <- readRDS("data/secondary_care.rds")

############################.
## UI ----
############################.
#Height and widths set as percentages to allow responsiveness

ui <- fluidPage(style = "width:650px; height:500px;",
                div(style = "width:100%", #Div containing all 5 filters at top of page
                    h4("Chart 1. Hospital Admissions in Scotland due to Diabetes"), #Chart title
                    div(style = "width:50%; float: left;", #first two dropdowns take up half screen each
                        selectInput("adm_type", label = "Select an admission type:",
                                    choices = c("Main Diagnosis", "Any Diagnosis", "Diabetic Ketoacidosis"),
                                    selected = "Main Diagnosis")),
                    div(style = "width:50%; float: left;", 
                        selectInput("measure", label = "Select rate or numerator:",
                                    choices = c("Rate", "Numerator"),
                                    selected = "Rate")),
                    div(style = "width:31.3%; float: left;  margin-right: 2%;", #last three dropdowns all take up 1/3 of the screen
                        selectizeInput("diabetes_type", label = "Select diabetes types:",
                                    choices = c("Type 1", "Type 2", "Other Diabetes"),
                                    selected = "Type 1", multiple = TRUE)),
                    div(style = "width:31.3%; float: left;  margin-right: 2%;", 
                          selectizeInput("sex", label = "Select sex:",
                                      choices = c("Males", "Females", "All"),
                                      selected = "All", multiple = TRUE)),
                    div(style = "width:31.3%; float: left;  margin-right: 2%;", 
                          selectizeInput("age_group", label = "Select age groups:",
                                      choices = c("0-24", "25-44", "45-64", "65+", "All Ages"),
                                      selected = "All Ages", multiple = TRUE))
                    ), #close div with dropdowns in 
                div(style = "width:100%; float: left;", #main panel with chart in
                    highchartOutput("line-chart") 
                    
                    ) #close main panel div
                ) #close fluidPage



############################.
## Server ----
############################.

server <- function(input, output){

shinyApp(ui = ui, server = server)


