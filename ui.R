shinyUI(
        pageWithSidebar(
                headerPanel(
                        h4("This application allows you to do basic calculations on stock prices.")
                        ),
                
                sidebarPanel(
                        textInput("ticker", "Calculate for which ticker?")
                        , dateInput("date", "Calculate for which date?")
                        , selectInput("movingRange"
                                , "Calculate for which period prior to your date?"
                                , c("10 DAY" = "10 DAY"
                                    , "1 MONTH" = "1 MONTH"
                                    , "1 YEAR" = "1 YEAR"
                                    , "MAX" = "MAX"
                                )
                        )
                        , selectInput("calcInput"
                                , "Calculate what?"
                                , c("MEAN" = "MEAN"
                                    , "MAXIMUM" = "MAXIMUM"
                                    , "MINIMUM" = "MINIMUM"
                                    , "VARIANCE" = "VARIANCE"
                                )
                        )
        ),
                mainPanel(
                        h4("This is your calculation:")
                        , verbatimTextOutput("calcResult")
                        , h4("This is a chart of your ticker:")
                        , isolate(plotOutput("plot"))
                )
        )
)