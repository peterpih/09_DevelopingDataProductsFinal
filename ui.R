#
# Developing Data Products Final Project (devdataprod-031)
#
# This is the Shiny user interface, it demonstrates some of the reactivity to user inputs
#The screen set up is very simple consisting of a bidebarPanel and a mainPanel
#
#
library(shiny)
#

x_axis_label = "x=axis"

# Define UI for dataset viewer application

shinyUI(pageWithSidebar(
    
    
    headerPanel("Treatment,Dosage, Response Analyzer"),  # Application title
    
    # Sidebar with controls to provide a caption, select a dataset, and 
    # specify the number of observations to view. Note that changes made
    # to the caption in the textInput control are updated in the output
    # area immediately as you type
    sidebarPanel(
        #
        # User chooses the supplement
        #
        selectInput("chooseSupp", "Supplement:", choices = c("Both", "Vitamin C", "Orange Juice")),
        #
        # Check boxes to choose the dosage, initially all are selected and laidout in a line
        #
        checkboxGroupInput("chooseDose", "Dosage:", c("0.5" = "0.5", "1.0" = "1.0", "2.0" = "2.0"),
                            selected=c("0.5","1.0","2.0"), inline=TRUE),
        #
        # Check boxes to show results by, Does is initially selected
        #
        checkboxGroupInput("check1", "Results By:", c("Dose" = "1", "Supplement" = "2"), selected="1"),
        #
        # Radio buttons to choose type of graph to display
        #
        radioButtons("chartType", "Chart Type:", list("Box", "Bar", "Scatter")),
        #
        # Slider bar to input jitter for scatter plots
        #
        sliderInput('jit', 'Scatterplot Jitter',value = 0, min = 0, max = 2, step = 0.05),
        #
        # Numeric input for number of observation to show in a table, increments of 5
        #
        numericInput("obs", "Number of observations to view:", 5, min=0, max = 60, step=5),
        #
        #
        #
        p("Instructions:"),
        p("Choose supplement from drop down"),
        p("Choose graph type from check boxes"),
        p("Jitter only works on Scatter plots"),
        p("WARNING: Since this is a generalized application, various possible combintions may result in strange results."),
        p("Try using: BOTH, with Results by: DOSE and Supplement")
    ),
    
    
    # Show the caption, a summary of the dataset and an HTML table with
    # the requested number of observations
    mainPanel(

        plotOutput('main_plot'),

        verbatimTextOutput("summary"),
        
        tableOutput("view")
        
    )
))
