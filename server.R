library(shiny)
library(lubridate)
library(quantmod)

queryFunction <- function(ticker) {getSymbols(ticker, src = "google", auto.assign = FALSE)}

calcFunction <- function(ticker, dateInput, movingRange, calcInput) {
        if (movingRange == "10 DAY") {
                if (calcInput == "MEAN") {
                        return(mean(queryFunction(ticker)[
                                paste(as.Date(dateInput) - 10, sep="/", as.Date(dateInput)), 4
                        ]))
                }
                if (calcInput == "MAXIMUM") {
                        return(max(queryFunction(ticker)[
                                paste(as.Date(dateInput) - 10, sep="/", as.Date(dateInput)), 4
                                ]))
                }
                if (calcInput == "MINIMUM") {
                        return(min(queryFunction(ticker)[
                                paste(as.Date(dateInput) - 10, sep="/", as.Date(dateInput)), 4
                                ]))
                }
                if (calcInput == "VARIANCE") {
                        return(var(queryFunction(ticker)[
                                paste(as.Date(dateInput) - 10, sep="/", as.Date(dateInput)), 4
                                ]))
                }
        }
        if (movingRange == "1 MONTH") {
                if (calcInput == "MEAN") {
                        return(mean(queryFunction(ticker)[
                                paste(as.Date(dateInput) - months(1), sep="/", as.Date(dateInput)), 4
                        ]))
                }
                if (calcInput == "MAXIMUM") {
                        return(max(queryFunction(ticker)[
                                paste(as.Date(dateInput) - months(1), sep="/", as.Date(dateInput)), 4
                        ]))
                }
                if (calcInput == "MINIMUM") {
                        return(min(queryFunction(ticker)[
                                paste(as.Date(dateInput) - months(1), sep="/", as.Date(dateInput)), 4
                        ]))
                }
                if (calcInput == "VARIANCE") {
                        return(var(queryFunction(ticker)[
                                paste(as.Date(dateInput) - months(1), sep="/", as.Date(dateInput)), 4
                        ]))
                }
        }
        if (movingRange == "1 YEAR") {
                if (calcInput == "MEAN") {
                        return(mean(queryFunction(ticker)[
                                paste(as.Date(dateInput) - years(1), sep="/", as.Date(dateInput)), 4
                        ]))
                }
                if (calcInput == "MAXIMUM") {
                        return(max(queryFunction(ticker)[
                                paste(as.Date(dateInput) - years(1), sep="/", as.Date(dateInput)), 4
                        ]))
                }
                if (calcInput == "MINIMUM") {
                        return(min(queryFunction(ticker)[
                                paste(as.Date(dateInput) - years(1), sep="/", as.Date(dateInput)), 4
                        ]))
                }
                if (calcInput == "VARIANCE") {
                        return(var(queryFunction(ticker)[
                                paste(as.Date(dateInput) - years(1), sep="/", as.Date(dateInput)), 4
                        ]))
                }
        }
        if (movingRange == "MAX") {
                if (calcInput == "MEAN") {
                        return(mean(queryFunction(ticker)[, 4]))
                }
                if (calcInput == "MAXIMUM") {
                        return(max(queryFunction(ticker)[, 4]))
                }
                if (calcInput == "MINIMUM") {
                        return(min(queryFunction(ticker)[, 4]))
                }
                if (calcInput == "VARIANCE") {
                        return(var(queryFunction(ticker)[, 4]))
                }
        }
}

chartFunction <- function(ticker, dateInput, movingRange) {
        if (movingRange == "10 DAY") {
                return(chartSeries(queryFunction(ticker)
                                   [paste(as.Date(dateInput) - 10, sep="/", as.Date(dateInput))]
                                   , theme=chartTheme("white")
                                   , type="line"
                                   , TA = NULL
                                   , name = as.character(ticker))
                )
        }
        if (movingRange == "1 MONTH") {
                return(chartSeries(queryFunction(ticker)
                                   [paste(as.Date(dateInput) - months(1), sep="/", as.Date(dateInput))]
                                   , theme=chartTheme("white")
                                   , type="line"
                                   , TA = NULL
                                   , name = as.character(ticker))
                )
        }
        if (movingRange == "1 YEAR") {
                return(chartSeries(queryFunction(ticker)
                                   [paste(as.Date(dateInput) - years(1), sep="/", as.Date(dateInput))]
                                   , theme = chartTheme("white")
                                   , type="line"
                                   , TA = NULL
                                   , name = as.character(ticker))
                )
        }
        if (movingRange == "MAX") {
                return(chartSeries(queryFunction(ticker)
                                   , theme = chartTheme("white")
                                   , type="line"
                                   , TA = NULL
                                   , name = as.character(ticker))
                )
        }
}

shinyServer(
        function(input, output) {
                output$calcResult <- renderText(
                        calcFunction(input$ticker, input$date, input$movingRange, input$calcInput)
                )
                output$plot <- renderPlot(
                        chartFunction(input$ticker, input$date, input$movingRange)
                )
        }
)