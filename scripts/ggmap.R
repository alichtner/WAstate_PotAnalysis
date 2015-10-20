## Plot maps with overlaid latitude and longitude points
library(ggmap)

myLocation <- c(lon = -122.113380 , lat = 47.595225)

myMap <- get_map(myLocation, source = "google", maptype = "terrain-background", color="color", zoom = 10)

p <- ggmap(myMap)

p <- p + geom_point(data=zipjoin, aes(x=longitude, y=latitude, size = shopfreq), alpha = .7, color = "dark green") + 
        scale_size(range=c(3,10))

