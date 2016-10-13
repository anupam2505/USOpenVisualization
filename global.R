# global.R

###############################################################################
#                         LOAD PACKAGES AND MODULES                          #
###############################################################################
require(rCharts)
options(RCHART_LIB = 'polycharts')
library(datasets)
library(dplyr)
library(forecast)
library(ggplot2)
library(plotly)
library(plyr)
library(rCharts)
library(reshape)
library(shiny)
library(shinydashboard)
library(TTR)
library(xlsx)
library(shinyGlobe)
library(ggmap)
library(DT)
library(googleVis)
library(countrycode)

###############################################################################
#                               LOAD DATA                                     #
###############################################################################
#Delete the following line before deploying this to shiny.io
home <- getwd()

setwd("processedData")

##Data
matches   = read.csv("Matches.csv", header = TRUE, stringsAsFactors = FALSE)
population <- readRDS("Population.rds")



#Set directory back to project home directory
setwd(home)