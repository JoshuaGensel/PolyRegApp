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

    # Application title
    titlePanel("Manually find the Least Squares Polynomial Regression"),
    
    fluidRow(
        column(h5("This app will randomize a bunch of datapoints for you that will have an underlying pattern. 
         This pattern can be described approximately by a polynomial equation up to the 3rd degree (but it can be simpler).
         Your job is to find the coefficients in the polynomial term, so that the sum of squared residuals
         between the data points and your polynomial is lowest."), width = 10)
    ),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("nPointsSlider",
                        "Number of data points:",
                        min = 1,
                        max = 50,
                        value = 10),
            em("(Just input the number of data points you want to be simulated here.)"),
            actionButton("simButton", "Simulate some data!"),
            sliderInput("beta0Slider",
                        "β0:",
                        min = -100,
                        max = 100,
                        value = 0),
            em("(Input your coefficient for the intercept here.)"),
            sliderInput("beta1Slider",
                        "β1:",
                        min = -100,
                        max = 100,
                        value = 1),
            em("(Input your coefficient for the first coefficient here.)"),
            sliderInput("beta2Slider",
                        "β2:",
                        min = -10,
                        max = 10,
                        value = 0),
            em("(Input your coefficient for the second here.)"),
            sliderInput("beta3Slider",
                        "β3:",
                        min = -10,
                        max = 10,
                        value = 0),
            em("(Input your coefficient for the third coefficient here.)")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Your polynomial equation:"),
            textOutput("regEq"),
            h3("Plot:"),
            plotOutput("regPlot"),
            h3("SSR:"),
            textOutput("SSR"),
            em("The achieved sum of squared residuals (try to minimize this)")
        )
    )
))
