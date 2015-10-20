weedMaster <- function() {
        library(zipcode)
        library(leaflet)
        data(zipcode)
        
        weed <- cleanDataFnct()
        zip <- weed[complete.cases(weed) & weed$Zip > 10000, 4]
        caseCount <- count(zip)  # Count the occurance of cases by zipcode
        names(caseCount) <- c("zip", "count") 
        caseCount <- join(caseCount, zipcode[,c(1,4,5)], by = "zip")
        
        shops <- storeOpen()
        shopZip <- shops[complete.cases(shops), 2]
        shopCount <- count(shopZip)
        names(shopCount) <- c("zip", "count") 
        shopCount <- join(shopCount, zipcode[,c(1,4,5)], by = "zip")
        
        # map call-in data
        
        # Should put popout data on the number of stores and their names / perhaps opening date as well
        # How many cases were within easy driving distance of a store
        # Can we show the number of cases growing with time?
        # Need a legend

        m <- leaflet() %>%
                addProviderTiles("CartoDB.Positron") %>% 
                setView(lng = -122.213380, lat = 47.595225, zoom = 10) %>% 
                addCircles(shopCount$longitude, 
                           shopCount$latitude, 
                           weight = 1, 
                           radius = 700 * sqrt(shopCount$count), 
                           color = "green") %>%
                addCircles(caseCount$longitude, 
                           caseCount$latitude, 
                           weight = 1, 
                           radius = 700 * sqrt(caseCount$count), 
                           color = "red")
              
                
        print(m)  # Print the map
        saveWidget(m, file="m.html")

        
        
        
}
