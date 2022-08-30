#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    #Output Equation formula based on inputs
    output$regEq <- renderText({
        b0input <- input$beta0Slider
        b1input <- input$beta1Slider
        b2input <- input$beta2Slider
        b3input <- input$beta3Slider
        b3term <- ifelse(b3input == 0, "",paste(toString(b3input),"x^3 + "))
        b2term <- ifelse(b2input == 0, "",paste(toString(b2input),"x^2 + "))
        b1term <- ifelse(b1input == 0, "",paste(toString(b1input),"x + "))
        b0term <- toString(b0input)
        paste(b3term,b2term,b1term,b0term)
    })
    
    #event for data simulation
    observeEvent(input$simButton, {
        
        # generate data points
        x    <- runif(input$nPointsSlider,min = -10,max = 10)
        b0 <- ifelse(runif(1,0,1) > 0.5,
                     0,
                     round(runif(1,-10,10)))
        b1 <- ifelse(runif(1,0,1) > 0.5,
                     0,
                     round(runif(1,-10,10)))
        b2 <- ifelse(runif(1,0,1) > 0.5,
                     0,
                     round(runif(1,-10,10)))
        b3 <- ifelse(runif(1,0,1) > 0.5,
                     0,
                     round(runif(1,-10,10)))
        y_noNoise <- b3*x^3 + b2*x^2 + b1*x + b0
        sd_noise <- ifelse(max(y_noNoise)>abs(min(y_noNoise)),
                           max(y_noNoise)/5 + .1,
                           abs(min(y_noNoise))/5+.1)
        y <- y_noNoise + rnorm(length(y_noNoise), sd = sd_noise)
        
        df <- data.frame(x, y)
        
        #output for plot with data and regression line
        output$regPlot <- renderPlot({
            b0input <- input$beta0Slider
            b1input <- input$beta1Slider
            b2input <- input$beta2Slider
            b3input <- input$beta3Slider
            
            polyFun <- function(x) b3input*x^3+b2input*x^2+b1input*x+b0input
            ggplot(df,aes(x = x, y = y)) + 
                geom_point(size = 3) + 
                stat_function(fun = polyFun) +
                geom_segment(aes(xend = x, yend = polyFun(x), col = "red")) +
                scale_color_manual(labels = c("residuals"), values = "red")
        })
        
        #output ssr
        output$SSR <- renderText({
            b0input <- input$beta0Slider
            b1input <- input$beta1Slider
            b2input <- input$beta2Slider
            b3input <- input$beta3Slider
            
            polyFun <- function(x) b3input*x^3+b2input*x^2+b1input*x+b0input
            toString(round(sum((y-polyFun(x))^2)))
        })
    })
    
    
})
