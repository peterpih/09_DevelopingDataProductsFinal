library(shiny)
library(datasets)
library(UsingR)


# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output, session) {
    
    # By declaring datasetInput as a reactive expression we ensure that:
    #
    #  1) It is only called when the inputs it depends on changes
    #  2) The computation and result are shared by all the callers (it 
    #     only executes a single time)
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
    # len
    # supp
    # dose
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
    
    my_jit <- function(){
        input$jit
    }
    
    plotParams <- reactive({
        print(c("plotParams ~", input$check1, "~"))
        
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
        print(c("jitParams ", input$check1))
        
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
    
    jitAmt <- reactive ({
        my_jit()
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
    
    output$newHist <- renderPlot({
                # hist(useData(), xlab='child height', col='lightblue',main='Histogram')
        print(c("plot type", input$chartType))
        
        if (input$chartType == "Box"){
            boxplot(plotParams(), data=useData(), xlab=x_axis_label(), ylab="Tooth Length")
            
        } else if (input$chartType == "Bar") {
            barchart(plotParams(), data=useData())
            
        } else if (input$chartType == "Scatter") {

            plot(jitParams(), data=useData(), ylab="Tooth Length", col=supp, xlab="Dosage")
            #plot(len~jitter(jitParams(),jitAmt()), data=useData(), ylab="Tooth Length", col=supp, xlab="Dosage")
            print(c("data rows", nrow(useData())))
            print(useData()[,1])
            #axis(1, at = seq(0, 2, by = 0.5))
        }
 
                # plotType(useData(), input$chartType)
        
#                 mu <- input$mu
#                 lines(c(mu, mu), c(0, 200),col="red",lwd=5)
#                 mse <- mean((galton$child - mu)^2)
#                 text(63, 150, paste("mu = ", mu))
#                 text(63, 140, paste("MSE = ", round(mse, 2)))
            })
    
#     output$plot <- renderPlot({ 
#         plotType(useData, input$chartType)
#     })
    
    
    # The output$caption is computed based on a reactive expression that
    # returns input$caption. When the user changes the "caption" field:
    #
    #  1) This expression is automatically called to recompute the output 
    #  2) The new caption is pushed back to the browser for re-display
    # 
    # Note that because the data-oriented reactive expressions below don't 
    # depend on input$caption, those expressions are NOT called when 
    # input$caption changes.
    output$caption <- renderText({
        input$caption
    })
    
    # The output$summary depends on the datasetInput reactive expression, 
    # so will be re-executed whenever datasetInput is invalidated
    # (i.e. whenever the input$dataset changes)
    output$summary <- renderPrint({
        summary(useData())
    })
    
    output$check1 <- renderPrint({
        input$check1
    })
    
    output$mu2 <- renderPrint({
        my_jit()
  })
    
    # The output$view depends on both the databaseInput reactive expression
    # and input$obs, so will be re-executed whenever input$dataset or 
    # input$obs is changed. 
    output$view <- renderTable({
        head(useData(), n = input$obs)
    })
})