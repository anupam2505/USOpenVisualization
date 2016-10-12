# Author Anupam Panwar
# Date 2 Oct 2016

## Assignment 2
## Changes required in this file


dashboardPage(skin = "green",
              dashboardHeader(title = "US Open Dashboard"),
              dashboardSidebar(
                sidebarMenu(id = "sbm",
                            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                            menuItem("Explorer", tabName = "explorer", icon = icon("search")),
                            menuItem("About Project", tabName = "About", icon = icon("book"))
                            
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
                                       title = "US Open Analytics",
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
                                         tags$li("Analytics realted to all countries on", span("Dashboard page.", style = "color:white")),
                                         tags$li("Ccomparison between two countries on", span("Explorer page.", style = "color:white"))
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
                                       title = "Serve Precision Score (SPS) of country = Average aces by country - Average double faults by country",
                                       status = "primary",
                                       width = 7,
                                       height = 450,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       htmlOutput("topserverCountries")
                                     ), #End of Box
                              # end of column
                            
                                     box(
                                       title = "Top Players based on SPS (Average aces - Average double faults)",
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

                                            )
                                     )
                                     
                                   )
                            )
                          ) # End of fluidPage
                  ), # End of tabItem 
                  tabItem(tabName = "About",
                          fluidPage(title = "About Project",
                          column(width = 12,
                                 box(
                                   title = "US Open Analytics ",
                                   width = 12,
                                   height = 1000,
                                   background = "green",
                                   solidHeader = FALSE,
                                   collapsible = FALSE,
                                   collapsed = FALSE,
                                   
                                   h2("Best Performing Countries in US Open"),
                                   h3("Introduction:"),
                                   h4("Tennis is a famous racket sport that is played individually against a single opponent (singles) 
                                           or between two teams of two players each (doubles). Objective of the game is to play the ball in 
                                           such a way that the opponent is not able to play a valid return. Player who is  not nable to return
                                           the ball will loose the point, while the opposite player will get the point."),
                                   h3("Data Analysis:"),
                                   h4("For the data analysis part, I compared different countries on the basis of matches palyed, won or lost over the years in US
                                            Open.I visualized the results on the world map as it make more sense when you are comparing different countries.
                                            Specifically, for analysing the serve I studied different serve patterns on the last 10 years of US
                                           Open matches. After examining further I found that a server can be categorized as good or bad on the basis of two features: 
                                           Aces and Double Faults.Serve precision score (SPS) was calculated on the basis of these two features. SPS of a player is
                                           directly proportional to number of aces and indirectly proportional to the number of double faults
                                           in the match. In terms of linear equation, it can be expressed as:"),
                                   h4(tags$strong("Serve Precision Score (SPS) = C1* Average no. of aces - C2* Average number of double faults")),
                                   h4("where C1 and C2 are constants"),
                                   h4("For the purpose of easiness, we assumed C1=1 and C2=1. I calculated the average SPS score for each country participated
                                      in the US open in last 11 years. As the part of analysis, I found top player in terms of SPS as well."),
                                   h3("Story and Visualization:"),
                                   h4("Dashboard in the web application is showing the matches played by different countries. If you hover on 
                                      any country in the map, it will show the exact number. On the right side of maps, there are two tables 
                                      showing the top players in terms of wins and SPS score. Three value boxes on the top showing the total US Open
                                      matches played, total number of players and total number of countries in last 11 years "),
                                   h4("Explorer page in web application is showing the comparison between the two countries in terms of wins, losses, average first serve speed, average Second
                                      serve speed. Explorer is also showing the top players for both countries."),
                                   h3("Effectiveness:"),
                                   h4("The main goal of this visualization is to show the number of wins, SPS for each country in map.Since we are also comparing different 
                                        countries, it is always a good idea to show it on choropleth maps to define the numbers for each country.
                                        In the same row, I have also showed the top players in term of wins and SPS score. Exact number can be checked by hovering
                                        over the country. Color maps have values from “Blue” to “Red” so that user can easily identify even small difference in the values of wins and SPS"),
                                   h4(".")
                                     )#end of box
                                     )#end of column
                          
                                     )#end tabItem
                  )
          ) # end of tabITems
    )# end of dashboard body
)# end of dashboard page