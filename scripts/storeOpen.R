# Function to open shop data

storeOpen <- function() {
        storeClean <- read.csv("King County Pot Shops - as of 9-11-15 - Sheet1.csv", sep=",")
        storeClean$Opening <- as.POSIXct(storeClean$Opening, format = "%m/%d/%y")
        storeClean
}
