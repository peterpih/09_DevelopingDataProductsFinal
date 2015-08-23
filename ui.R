library(shiny)

myguess = 69
t = 70

x_axis_label = "x=axis"

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
    
    
    headerPanel("Treatment,Dosage, Response Analyzer"),  # Application title
    
    # Sidebar with controls to provide a caption, select a dataset, and 
    # specify the number of observations to view. Note that changes made
    # to the caption in the textInput control are updated in the output
    # area immediately as you type
    sidebarPanel(
        textInput("caption", "My Caption:", "Data Summary foo"),
        
        selectInput("chooseSupp", "Supplement:", 
                    choices = c("Both", "Vitamin C", "Orange Juice")),

        checkboxGroupInput("chooseDose", "Dosage:",
                           c("0.5" = "0.5", "1.0" = "1.0", "2.0" = "2.0"), selected=c("0.5","1.0","2.0"), inline=TRUE),
        
        checkboxGroupInput("check1", "Results By:",
                 c("Dose" = "1",
                   "Supplement" = "2"), selected="1"),


        
        radioButtons("chartType", "Chart Type:",
                     list("Box", "Bar", "Scatter")),
        
        numericInput("obs", "Number of observations to view:", t, min=0, max = 100, step=2),
        
        sliderInput('jit', 'Scatterplot Jitter',value = 0, min = 0, max = 4, step = 0.05)
    ),
    
    
    # Show the caption, a summary of the dataset and an HTML table with
    # the requested number of observations
    mainPanel(
        h3(textOutput("caption")), 
        
#         code ("some code"),
        
        plotOutput('newHist'),

        verbatimTextOutput("summary"), 
        
        tableOutput("view"),
        
#         p("some ordinary text"),
        verbatimTextOutput("check1"),
        
        #verbatimTextOutput("mu2")
        # t = output$mu2,
        sidebarPanel()
    )
))
