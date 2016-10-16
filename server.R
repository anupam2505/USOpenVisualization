# Assignment 2 
# Anupam Panwar
# Date: Oct 1, 2016
#Completed one and submitted 

# server.R

#===============================================================================
#                               SHINYSERVER                                    #
#===============================================================================


shinyServer(function(input, output, session) {
  
  #===============================================================================
  #                        DASHBOARD SERVER FUNCTIONS                            #
  #===============================================================================
  # Total MAtches played
  output$usViBox <- renderValueBox({
    current <- matches
    valueBox(
      paste0(nrow(current)), paste( "Total Number of matches "), 
      icon = icon("signing"), color = "blue"
    )
  })
  
  # Total players
  output$highestViBox <- renderValueBox({
    
    current <- matches
    n1 = nrow(unique(cbind(unique(matches$player1), unique(matches$player2))))
    current <- currentState[ which(currentState$State == "United States"), ]
    valueBox(
      paste0(n1), paste( "Total Number of players "), 
      icon = icon("group"), color = "green"
    )
  })
  
  # Total Countries
  output$usAnnualBox <- renderValueBox({
    current <- matches
    n2 = nrow(unique(cbind(unique(matches$country1), unique(matches$country2))))
    valueBox(
      paste0(n2), paste( "Total Number of countries "), icon = icon("bar-chart"), color = "red"
    )
  })
  
  # Map Homepage
  output$gvis <- renderGvis({
    polygons.plot <- as.data.frame(population)
    gvisGeoChart(polygons.plot, locationvar= "Country", colorvar ="Matches_Played",options=list( title="Matches played by countries in US open",colors="['Blue', 'red']"))  
  })
  
  #
  ## Top 10 Players
  output$top10 <- renderGvis({
    top10 = matches
    PlayersAll = top10$player1
    m1 = count(PlayersAll)
    colnames(m1) <- c( "Player",   "Wins")
    m1 = m1[order(-m1[,2]), ]
    gvisTable(m1,options=list(page='enable', pageSize=15, width=550))
  }) 
  
  ## Better servers countries
  output$topserverCountries <- renderGvis({
    topserver <- matches
    topserver$SPS1 <- topserver$ace1-topserver$double1
    topserver$SPS2 <- topserver$ace2-topserver$double2
    m1 <- aggregate( SPS1 ~ country1, topserver, mean )
    colnames(m1) <- c("Country", "SPS")
    m2 <- aggregate( SPS2 ~ country2, topserver, mean )
    colnames(m2) <- c("Country", "SPS")
    m <- rbind(m1,m2)
    finalm <- aggregate( SPS ~ Country, m, mean )
    finalm$Country <- countrycode(finalm$Country, "iso3c", "country.name")
    finalm <- as.data.frame(finalm)
    gvisGeoChart(finalm, locationvar= "Country", colorvar ="SPS",options=list( title="Serve Precision Score(SPS) = Average Aces by country - Average double faults by country",colors="['Blue', 'red']"))  
  })
  
  ## Top 10 Players based on SPS
  output$top10SPS <- renderGvis({
    topserve <- matches
    topserve$SPS1 <- topserve$ace1-topserve$double1
    topserve$SPS2 <- topserve$ace2-topserve$double2
    
    ms1 <- aggregate( SPS1 ~ player1, topserve, mean )
    colnames(ms1) <- c("Player", "SPS")
    ms2 <- aggregate( SPS2 ~ player2, topserve, mean )
    colnames(ms2) <- c("Player", "SPS")
    ms <- rbind(ms1,ms2)
    finalm <- aggregate( SPS ~ Player, ms, mean )
    finalm = finalm[order(-finalm[,2]), ]
    gvisTable(finalm,options=list(page='enable', pageSize=15, width=550))
  }) 
 
  ## Select Country 1
  output$country1Query4Ui <- renderUI({
    country1 = unique(sort(unique(rbind(matches$country1, matches$country2))))
    # country1 = sort(unique(matches$country1))
    selectInput("countryinput1", label = "Select Country A:", choices = c(Choose='', as.character(country1)), selectize = FALSE)
  }) 
  
  ## Select Country 2
  output$country2Query4Ui <- renderUI({
    country2 = unique(sort(unique(rbind(matches$country1, matches$country2))))
    # country2 = sort(unique(matches$country2))
    selectInput("countryinput2", label = "Select Country B:", choices = c(Choose='', as.character(country2)), selectize = FALSE)
  }) 
  

  
  # Get country1 win data
  screencountry1winData <-eventReactive(input$query1,{
    # Get Deta
    xyz = input$countryinput1
    matchesCountry1 = matches[matches$country1==xyz,]
    matchesCountry1 = matchesCountry1$year
    
    count1 = count(matchesCountry1)
    
    colnames(count1) <- c( "year", "Freq")
    count1$country <- rep(xyz,nrow(count1))
    return(count1)
  }, ignoreNULL = FALSE)
  
  
  # Get country2 win data
  screencountry2winData <-eventReactive(input$query1, {
    in2 = input$countryinput2
    matchesCountry2 = matches[matches$country1==in2,]
    matchesCountry2 = matchesCountry2$year
    
    count2 = count(matchesCountry2)
    
    colnames(count2) <- c( "year", "Freq")
    count2$country <- rep(in2,nrow(count2))
    return(count2)
  }, ignoreNULL = FALSE)
  
  
  ## Loss Data
  
  # Get country1 loss data
  screencountry1lossData <-eventReactive(input$query1,{
    # Get Deta
    xyz = input$countryinput1
    matchesCountry1 = matches[matches$country2==xyz,]
    matchesCountry1 = matchesCountry1$year
    
    count1 = count(matchesCountry1)
    
    colnames(count1) <- c( "year", "Freq")
    count1$country <- rep(xyz,nrow(count1))
    return(count1)
  }, ignoreNULL = FALSE)
  
  
  # Get country2 loss data
  screencountry2lossData <-eventReactive(input$query1, {
    in2 = input$countryinput2
    matchesCountry2 = matches[matches$country2==in2,]
    matchesCountry2 = matchesCountry2$year
    
    count2 = count(matchesCountry2)
    
    colnames(count2) <- c( "year", "Freq")
    count2$country <- rep(in2,nrow(count2))
    return(count2)
  }, ignoreNULL = FALSE)
  
  ## Top 3 for Country A
  output$top3tableA <- renderGvis({
    inputTop3A = input$countryinput1
    top3countryA = matches[matches$country1==inputTop3A,]
    PlayersA = top3countryA$player1
    countA = count(PlayersA)
    
    colnames(countA) <- c( "Player", "Wins")
    countA = countA[order(-countA[,2]), ]
    countA$country <- rep(inputTop3A,nrow(countA))
    gvisTable(countA,options=list(page='enable', pageSize=3, width=550))
  }) 
  
  # Top 3 for Country B
  output$top3tableB <- renderGvis({
    inputTop3B = input$countryinput2
    top3countryB = matches[matches$country1==inputTop3B,]
    PlayersB = top3countryB$player1
    countB = count(PlayersB)
    
    colnames(countB) <- c( "Player", "Wins")
    countB = countB[order(-countB[,2]), ]
    countB$country <- rep(inputTop3B,nrow(countB))
    gvisTable(countB,options=list(page='enable', pageSize=3, width=550))
  }) 

  
  ## Loss over years
  output$lossbyyear <- renderChart({
    
    withProgress(message = "Rendering number of losses over years", {
      
      d1 = screencountry1lossData()
      d2 = screencountry2lossData()
      # Subset into top results
      d = rbind(d1,d2)
      p <- nPlot(Freq ~ year, group = 'country', type = 'lineChart', id = 'chart', dom = "lossbyyear", data = d, height = 400, width = 450)
      p$chart(color = c('blue', 'red'))
      p$yAxis( axisLabel = "Loss" )
      p$xAxis( axisLabel = "Year" )
      
      return(p)
    })
  })
  
  
  ##win over years
  output$winbyyear <- renderChart({
    
    withProgress(message = "Rendering number of wins over years", {
      
      d1 = screencountry1winData()
      d2 = screencountry2winData()
      # Subset into top results
      d = rbind(d1,d2)
      p <- nPlot(Freq ~ year, group = 'country', type = 'lineChart', id = 'chart', dom = "winbyyear", data = d, height = 400, width = 450)
      p$chart(color = c('blue', 'red'))
      p$yAxis( axisLabel = "Wins" )
      p$xAxis( axisLabel = "Year" )
      return(p)
    })
  })
  
  
  output$firstspeedbyyear <- renderChart({
    
    withProgress(message = "Rendering First Average Speed", {
      speed1in = input$countryinput1
      matchesCountry1 = matches[matches$country1==speed1in  | matches$country2==speed1in  ,]
      matchesCountry1 = cbind(matchesCountry1$year,matchesCountry1$avgFirstServe1 )
      
      matchesCountry1 = na.omit(matchesCountry1)
      matchesCountry1 = aggregate(matchesCountry1[,2], list(matchesCountry1[,1]), mean)
      colnames(matchesCountry1) <- c( "year", "Average_Speed")
      matchesCountry1$country <- rep(speed1in ,nrow(matchesCountry1))
      
      
      speed2in = input$countryinput2
      matchesCountry2 = matches[matches$country1==speed2in| matches$country2==speed2in,]
      matchesCountry2 = cbind(matchesCountry2$year,matchesCountry2$avgFirstServe1 )
      
      matchesCountry2 = na.omit(matchesCountry2)
      matchesCountry2 = aggregate(matchesCountry2[,2], list(matchesCountry2[,1]), mean)
      colnames(matchesCountry2) <- c( "year", "Average_Speed")
      matchesCountry2$country <- rep(speed2in,nrow(matchesCountry2))
      
      
      dFirstServe = data.frame(rbind(matchesCountry1,matchesCountry2))
      p <- nPlot(Average_Speed ~ year, group = 'country', type = 'scatterChart', id = 'chart', dom = "firstspeedbyyear", data = dFirstServe, height = 400, width = 450)
      p$chart(color = c('blue', 'red'))
      p$yAxis( axisLabel = "Speed (in KPH)" )
      p$xAxis( axisLabel = "Year" )
    })
    p
  })
  
  output$secondspeedbyyear <- renderChart({
    
    withProgress(message = "Rendering First Average Speed", {
      speed1in = input$countryinput1
      matchesCountry12 = matches[matches$country1==speed1in | matches$country2==speed1in ,]
      matchesCountry12 = cbind(matchesCountry12$year,matchesCountry12$avgFirstServe2 )
      
      matchesCountry12 = na.omit(matchesCountry12)
      matchesCountry12 = aggregate(matchesCountry12[,2], list(matchesCountry12[,1]), mean)
      colnames(matchesCountry12) <- c( "year", "Average_Speed")
      matchesCountry12$country <- rep(speed1in,nrow(matchesCountry12))
      
      
      speed2in = input$countryinput2
      matchesCountry22 = matches[matches$country1==speed2in| matches$country2==speed2in,]
      matchesCountry22 = cbind(matchesCountry22$year,matchesCountry22$avgFirstServe2 )
      
      matchesCountry22 = na.omit(matchesCountry22)
      matchesCountry22 = aggregate(matchesCountry22[,2], list(matchesCountry22[,1]), mean)
      colnames(matchesCountry22) <- c( "year", "Average_Speed")
      matchesCountry22$country <- rep(speed2in,nrow(matchesCountry22))
      
      
      dFirstServe1 = data.frame(rbind(matchesCountry12,matchesCountry22))
      p1 <- nPlot(Average_Speed ~ year, group = 'country', type = 'scatterChart', id = 'chart', dom = "secondspeedbyyear", data = dFirstServe1, height = 400, width = 450)
      p1$chart(color = c('blue', 'red'))
      p1$yAxis( axisLabel = "Speed (in KPH)" )
      p1$xAxis( axisLabel = "Year" )
    })
    p1
  })

 
  })