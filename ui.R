library(htmltools)
library(shiny)
library(leaflet)
library(dplyr)
library(zipcode)

# Get data
print(getwd())
weed <- readRDS("data/weedData.rds")
weed <- weed[complete.cases(weed) & weed$Zip > 10000, ]

# Create UI
ui <- bootstrapPage(
        tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
        leafletOutput("map", width = "100%", height = "100%"),
        absolutePanel(top = 15, right = 50,
                      sliderInput("range", "Choose a date range:", min(weed$Date), max(weed$Date),
                                  value = range(weed$Date), step = 0.1, timeFormat = "%b-%d-%Y"
                      )
        )
)