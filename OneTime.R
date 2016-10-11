home <- getwd()

setwd("processedData")


#### One Time run file
map1 = data.frame(Latitude = numeric(0), Longitude = numeric(0), Population= numeric(0))
country1 = t(matches$country1)
country2 = t(matches$country2)
country = cbind(country1, country2)
countryfull <- countrycode(country, "iso3c", "country.name")
table1 = count((countryfull))
table1$Population = table1$freq
table1 <-na.omit(table1)

#table1$Population = (table1$freq-min(table1$freq))/(max(table1$freq)-min(table1$freq))

for (i in 1:nrow(table1)){
    table1$Longitude[i]  = as.numeric(geocode(as.character(table1$x[i]))[1])
    table1$Latitude[i]  = as.numeric(geocode(as.character(table1$x[i]))[2])
}


Population1 = data.frame(table1$x, table1$Latitude, table1$Longitude, as.numeric(table1$Population))
colnames(Population1) = c("Country","Latitude", "Longitude", "Matches_Played")
Population1[1,2] = as.numeric(-63.61667)
Population1[1,2] = as.numeric(-38.4161)

saveRDS(Population1, "Population.rds")


