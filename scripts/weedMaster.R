weedMaster <- function() {
        library(htmltools)
        library(dplyr)
        library(zipcode)
        library(leaflet)
        data(zipcode)
        
        # Creates df of cases, grouped by zipcode and matched with lat and long coord.
        weed <- cleanDataFnct()
        zip <- weed[complete.cases(weed) & weed$Zip > 10000, ]
        
        caseCount <- zip %>% group_by(Zip) %>% summarize(count = n(), paste("Number of cases: ", "<b>", count, "</b>"))
        names(caseCount) <- c("zip", "count", "numCases") 
        caseCount <- join(caseCount, zipcode[,c(1,4,5)], by = "zip")
        
        # Creates df of shops, grouped by zipcode and matched with lat and long coord.
        shops <- storeOpen()
        shops <- shops[complete.cases(shops),]

        shopCount <- shops %>% group_by(zip) %>% summarize(count = n(), paste("<b>", name, "</b>", collapse = "<br/>"))
        names(shopCount) <- c("zip", "count", "name") 
        shopCount <- join(shopCount, zipcode[,c(1,4,5)], by = "zip")
        
        # map call-in data
        
        # Should put popout data on the number of stores and their names / perhaps opening date as well
        # How many cases were within easy driving distance of a store
        # Can we show the number of cases growing with time?
        # Need a legend

        m <- leaflet() %>%
                addProviderTiles("CartoDB.Positron") %>% 
                setView(lng = -122.213380, lat = 47.595225, zoom = 10) %>% 
         
                addCircles(caseCount$longitude, 
                           caseCount$latitude, 
                           weight = 1, 
                           radius = 700 * sqrt(caseCount$count), 
                           color = "blue", 
                           fillOpacity = 0.25,
                           popup = caseCount$numCases, 
                           options = popupOptions(zoomAnimation = TRUE))  %>%
                addCircles(shopCount$longitude, 
                           shopCount$latitude, 
                           weight = 1, 
                           radius = 500 * sqrt(shopCount$count), 
                           color = "black", 
                           fillOpacity = 0.5, 
                           popup = shopCount$name)
              
                
        print(m)  # Print the map
}




