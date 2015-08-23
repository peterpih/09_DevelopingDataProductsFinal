library(shiny)
library(datasets)
library(UsingR)

#
# Define server logic required to summarize and view the selected dataset
#
shinyServer(function(input, output, session) {
    
    #
    # Which supplement did the user choose
    #
    chooseTreatment <- reactive({
        switch(input$chooseSupp,
               "Vitamin C" = 1,
               "Orange Juice" = 2,
               "Both" = 3
               )
    })
    
    useColor <- function(x){
        t <- unique(x)
        
        col <- as.character()
        if ("OJ" %in% t) { col <- c(col, "orange") }
        if ("VC" %in% t) { col <- c(col, "black")}
        
        useColor <- col
    }
    #
    # Determine if the user wants a subet of the dataset
    #
    useData <- reactive({

        x <- ToothGrowth[order(ToothGrowth$supp),]
        #
        # Filter chosen dosage (these are OR conditions since it's a group of checkboxes)
        #
        x <- data.frame()
        for (i in as.numeric(input$chooseDose)){
            t <- subset(ToothGrowth, dose == i)
            x <- rbind(x, t)
        }
        #
        # Filter chosen supplement
        #
        if (chooseTreatment() == 1){
            x <- subset(x, supp == "VC")
            
        } else if (chooseTreatment() == 2){
            x <- subset(x, supp == "OJ")
        }
        
        x$supp <- factor(x$supp)    # refactor sonce only 1 treatment may have been chosen
        
        useData <- x
    })
    #
    # Which x axis did the user choose?
    #
    plotParams <- reactive({
        
        if (length(input$check1) == 1){
            if (input$check1 == "1"){
                len~dose
            } else if (input$check1 == "2"){
                len~supp
            }
        } else {
            len~supp*dose
        }
    })
    
    jitParams <- reactive({
        
        if (length(input$check1) == 1){
            if (input$check1 == "1"){
                len~jitter(dose, jitAmt())
            } else if (input$check1 == "2"){
                len~jitter(as.numeric(supp), jitAmt())
            }
        } else {
            len~jitter(as.numeric(supp)*dose, jitAmt())
        }
    })
    #
    # Get the user amount of jitter to use in scatterplots
    #
    jitAmt <- reactive ({
        input$jit
    })
    
    x_axis_label <- function(){
        if (length(input$check1) == 1){
            if (input$check1 == "1"){
                "Dose"
            } else if (input$check1 == "2"){
                "Supplement"
            }
        } else {
            "Supplement Dosage"
        }
    }
    #
    # Show the user specified graph
    #
    output$main_plot <- renderPlot({
        
        if (input$chartType == "Box"){
            boxplot(plotParams(), data=useData(), xlab=x_axis_label(), ylab="Tooth Length")
            
        } else if (input$chartType == "Bar") {
            barchart(plotParams(), data=useData())
            
        } else if (input$chartType == "Scatter") {
            plot(jitParams(), data=useData(), ylab="Tooth Length", col=supp, xlab=x_axis_label())
        }
    })
    #
    # Show a summary table of the selected data, always useful to have
    #
    output$summary <- renderPrint({
        summary(useData())
    })
    
    output$check1 <- renderPrint({
        input$check1
    })
    
    #
    # Show some of the data, user can specify how many lines to show
    #
    output$view <- renderTable({
        head(useData(), n = input$obs)
    })
})