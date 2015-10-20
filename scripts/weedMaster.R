weedMaster <- function() {
        library(htmlwidgets)
        library(zipcode)
        data(zipcode)
        
        weed <- cleanDataFnct()
        zip <- weed[complete.cases(weed) & weed$Zip > 10000, 4]
        caseCount <- count(zip, "zip")
        caseCount <- join(caseCount, zipcode[,c(1,4,5)], by = "zip")

        
        library(leaflet)
        
        # map call-in data

        m <- leaflet() %>%
                addProviderTiles("CartoDB.Positron") %>% 
                setView(lng = -122.213380, lat = 47.595225, zoom = 10) %>% 
                addCircles(caseCount$longitude, caseCount$latitude, weight = 1, radius = 700 * sqrt(caseCount$freq), color = "red")
                
        m  # Print the map
        saveWidget(m, file="m.html")

        
        
        
}
