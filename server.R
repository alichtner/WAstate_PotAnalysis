library(htmltools)
library(shiny)
library(leaflet)
library(dplyr)
library(zipcode)

#Get data
print(getwd())
weed <- readRDS("data/weedData.rds")
weed <- weed[complete.cases(weed) & weed$Zip > 10000, ]

shops <- readRDS("data/shopData.rds")
shops <- shops[complete.cases(shops),]


server <- function(input, output, session) {
        
        # Plot the map
        output$map <- renderLeaflet({
                
                leaflet() %>% addProviderTiles("CartoDB.Positron") %>% 
                        setView(lng = -122.213380, lat = 47.595225, zoom = 10) %>%
                        addLayersControl(overlayGroups = c("Recreational Shops", "Marijuana-Related Calls"),
                                         position = c("bottomright"),
                                         options = layersControlOptions(collapsed = FALSE))
                
        })
        
        # Reactive expression for the data subsetted to what the user selected
        
        filteredData <- reactive({ 
                df <- weed[weed$Date >= input$range[1] & weed$Date <= input$range[2],] %>% 
                        group_by(Zip) %>% 
                        summarize(count = n(), paste("Number of cases: ", "<b>", count, "</b>"))
                names(df) <- c("zip", "count", "numCases") 
                df <- join(df, zipcode[,c(1,4,5)], by = "zip")
                return(df)
        })
        
        filteredShopData <- reactive({ 
                df <- shops[shops$opening >= input$range[1] & shops$opening <= input$range[2],] %>% 
                        group_by(zip) %>% 
                        summarize(count = n(), paste("<b>", name, "</b>", collapse = "<br/>"))
                names(df) <- c("zip", "count", "name") 
                df <- join(df, zipcode[,c(1,4,5)], by = "zip")
                return(df)
        })
        
        # Plot pot shops
        observe({
                if (nrow(filteredShopData()) == 0) {leafletProxy("map") %>% clearShapes()} 
                else {
                        leafletProxy("map", data = filteredShopData()) %>%
                                clearShapes() %>%
                                addCircles(~longitude, ~latitude, 
                                           weight = 1, radius = ~500*sqrt(count), 
                                           color = "black", fillOpacity = 0.5, 
                                           popup = ~name, group = "Recreational Shops")
                }
                
        })
        
        # Plot calls in WA state
        observe({
                if (nrow(filteredData()) == 0) {leafletProxy("map") %>% clearShapes()} 
                else {
                        leafletProxy("map", data = filteredData()) %>%
                                clearMarkers() %>%
                                addCircles(~longitude, ~latitude, 
                                           weight = 1, radius = ~700*sqrt(count), 
                                           color = "red", fillOpacity = 0.35,
                                           popup = ~numCases, group = "Marijuana-Related Calls"
                                ) 
                }
                
        })
        
}