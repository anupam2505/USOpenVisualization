# Author Anupam Panwar
# Date 2 Oct 2016

## Assignment 2
## Changes required in this file


dashboardPage(skin = "green",
              dashboardHeader(title = "US Open Dashboard"),
              dashboardSidebar(
                sidebarMenu(id = "sbm",
                            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                            menuItem("Explorer", tabName = "explorer", icon = icon("search"))
                            
                            
                )# end of sidebarMenu
              ),#end of dashboardSidebar
              
              dashboardBody(
                includeCSS("www/custom.css"),
                tabItems(
                  tabItem(tabName = "dashboard",
                          fluidPage(
                            title = "Dashboard",
                            fluidRow(
                              column(width = 12,
                                     valueBoxOutput("usViBox", width = 4),
                                     valueBoxOutput("highestViBox", width = 4),
                                     valueBoxOutput("usAnnualBox", width = 4)
                              )#end of column
                            ),# end of row
                            fluidRow(
                              column(width = 12,
                                     box(
                                       title = "Analytics for the Real Estate Market",
                                       width = 12,
                                       height = 250,
                                       background = "orange",
                                       solidHeader = FALSE,
                                       collapsible = FALSE,
                                       collapsed = FALSE,
                                       h3("Welcome to US Open Analytics"),
                                       p(
                                         paste("Here, we will discuss the different comarisons on 11 year US Open data:")),
                                       tags$ul(
                                         tags$li("Analytics realted to all countries", span("Dashboard page,", style = "color:white")),
                                         tags$li("Ccomparison between two countries.", span("Explorer,", style = "color:white"))
                                         ),
                                       p("Enjoy!")
                                         )# end of box
                                       ),# end of column
                              column(width = 12,
                                     box(
                                       title = "Total Matches played by each country",
                                       status = "primary",
                                       width = 7,
                                       height = 450,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       htmlOutput("gvis")
                                     ),
                                     box(
                                       title = "Top Players in US Open based on wins",
                                       status = "primary",
                                       width = 5,
                                       height = 450,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       htmlOutput("top10")
                                       
                                     )
                                    
                              ) # End of column
                                     ), # End of Fluid Row
                            fluidRow(
                              column(width = 12,
                                     box(
                                       title = "Serve Precision Score(SPS) = Average Aces by country - Average double faults by country",
                                       status = "primary",
                                       width = 7,
                                       height = 450,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       htmlOutput("topserverCountries")
                                     ), #End of Box
                              # end of column
                            
                                     box(
                                       title = "Top Players based on SPS (Average Aces - Average double faults)",
                                       status = "primary",
                                       width = 5,
                                       height = 450,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       htmlOutput("top10SPS")
                                     ) #End of Box
                             
                            )
                            ) # End of fluid row
                          )
                  ), # End of tabItem
                  tabItem(tabName = "explorer",
                          fluidPage(
                            title = "Market Explorer",
                            
                            column(width = 12,
                                   box(
                                     title = "Compare Two Countries",
                                     width = 12,
                                     status = "primary",
                                     solidHeader = TRUE,
                                     background = "navy",
                                     uiOutput("country1Query4Ui"),
                                     uiOutput("country2Query4Ui"),
                                     actionButton("query1", label = "Go")
                                   ),
                                   
                                   conditionalPanel(
                                     condition = "input.query1",
                                     column(width = 12,
                                            box(
                                              title = "Data",
                                              status = "primary",
                                              width = 12,
                                              solidHeader = TRUE,
                                              collapsible = TRUE,
                                              fluidRow(
                                                column(width = 12,
                                                       box(
                                                         title = paste("Matches Won over years"),
                                                         status = "primary",
                                                         width = 6,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         showOutput("winbyyear", "nvd3")
                                                         
                                                       ),
                                                       box(
                                                         title = paste("Matches Lost over years"),
                                                         status = "primary",
                                                         width = 6,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         showOutput("lossbyyear", "nvd3")
                                                         
                                                       )
                                                )
                                              ) ,
                                              fluidRow(
                                                column(width = 12,
                                                box(
                                                  title = paste("Average First serve speed"),
                                                  status = "primary",
                                                  width = 6,
                                                  solidHeader = FALSE,
                                                  collapsible = TRUE,
                                                  showOutput("firstspeedbyyear", "nvd3")
                                                ),
                                                box(
                                                  title = paste("Average Second serve speed"),
                                                  status = "primary",
                                                  width = 6,
                                                  solidHeader = FALSE,
                                                  collapsible = TRUE,
                                                  showOutput("secondspeedbyyear", "nvd3")
                                                )
                                                )
                                              )
                                              ,
                                              fluidRow(
                                                column(width = 12,
                                                       box(
                                                         title = "Top Players Country A",
                                                         status = "primary",
                                                         width = 6,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         htmlOutput("top3tableA")
                                                         
                                                       ),
                                                       box(
                                                         title = "Top Players Country B",
                                                         status = "primary",
                                                         width = 6,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         htmlOutput("top3tableB")
                                                         
                                                       )
                                                       
                                                )
                                              )
#                                               ,
#                                               fluidRow(
#                                                 column(width = 12,
#                                                        box(
#                                                          title = paste("Average Error over years"),
#                                                          status = "primary",
#                                                          width = 6,
#                                                          solidHeader = FALSE,
#                                                          collapsible = TRUE,
#                                                          showOutput("averageError", "nvd3")
#                                                        ),
#                                                        box(
#                                                          title = paste("Average Net Points Won over years"),
#                                                          status = "primary",
#                                                          width = 6,
#                                                          solidHeader = FALSE,
#                                                          collapsible = TRUE,
#                                                          showOutput("averagenet", "nvd3")
#                                                        )
#                                                 )
#                                               )
                                            )
                                     )
                                     
                                   )
                            )
                          ) # End of fluidPage
                  ) # End of tabItem 
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  # tabItem(tabName = "helpNonSeasonal",
                  #         column(width = 4,
                  #                box(
                  #                  title = "Value Analysis",
                  #                  width = 12,
                  #                  background = "green",
                  #                  solidHeader = FALSE,
                  #                  collapsible = FALSE,
                  #                  collapsed = FALSE,
                  #                  p(
                  #                    paste("The Value Analyzer allows you to analyze home value price movements for selected markets.  
                  #                          You will be able to analyze and decompose price movements into their seasonal and non-seasonal components. ")),
                  #                  h3("Explore Non-Seasonal Home Value Time Series"),
                  #                  tags$strong("Select a Market [1:3]"),
                  #                  p(
                  #                    paste("Whereas we queried multiple markets in the Market Explorer, here you will be selecting a specific market at either the state, 
                  #                          county, city or zip code level.  Once you have selected a market, press the 'Go' button to reveal some key statistics [3] and 
                  #                          the seasonal and non-seasonal time series.")),
                  #                  tags$strong("Non-Seasonal Home Value Time Series [4]"),
                  #                  p(
                  #                    paste("A non-seasonal time series consists of a trend component and an irregular component. 
                  #                          Decomposing the time series involves the separation of the time series into these components, 
                  #                          that is, estimating the trend component and the irregular component.  Here we show the trend 
                  #                          component by calculating the simple moving average (SMA) of the time series.")),
                  #                  tags$em("Span Order"),
                  #                  p(
                  #                    paste("To conducted a SMA, you need to specify the order (span) of the simple moving average.  
                  #                          Using the Span Order slider, select a span order between 1 and 10.  Through trial-and-error, 
                  #                          you will unveil a smooth SMA showing the trend component without excessive random fluctuation. [1]")),
                  #                  tags$strong("Simple Moving Average"),
                  #                  p(
                  #                    paste("The plot shows an estimate of home value trend with a simple moving average of median home values for the market, from 2000 thru 2015. 
                  #                          A simple moving average (SMA) is a simple, or arithmetic, moving average that is calculated by adding the 
                  #                          median home value of homes in the selected market for a number of time periods and then dividing this total 
                  #                          by the number of time periods. Short-term averages respond quickly to changes in the home values of the underlying, 
                  #                          while long-term averages are slow to react. [2]"))
                  #                    )#end of box
                  #                    ),#end of column
                  #         column(width = 8,
                  #                box(
                  #                  status = "primary",
                  #                  width = 12,
                  #                  solidHeader = FALSE,
                  #                  img(src = "valueAnalyzer1.png", height = 574, width = 1020)
                  #                )# end of box
                  #         )# end of column
                  #                    ),#end tabItem
                  
                  
                  
                  
                  
          ) # end of tabITems
    )# end of dashboard body
)# end of dashboard page