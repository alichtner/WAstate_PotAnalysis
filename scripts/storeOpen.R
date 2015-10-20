storeOpen <- function() {
        storeRaw <- read.csv("KING County Recreational Pot Shops - as of 8-21-2015 - Sheet1.csv", sep=",")
        storeClean <- sapply(storeRaw$Opening, as.POSIXct(format = "%m-%d-%y"))
        head(storeClean)
}
