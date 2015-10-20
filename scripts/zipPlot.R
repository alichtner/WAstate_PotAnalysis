## Plot latitude and longitude coordinates of zipcodes

zipPlot <- function(ST = 'WA') {
        library(zipcode)
        library(ggplot2)
        data(zipcode)                                   # Gets zipcode data
        
        myZips <- subset(zipcode, state == ST)          # Subsets only one state
        head(myZips)

        
        ggplot(data=myZips) + geom_point(aes(x=longitude, y=latitude))  # Plots zipcode centers
        
}
        
