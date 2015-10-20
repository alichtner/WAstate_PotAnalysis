# Graphing abilities
# Be able to graph heat map of Seattle with circles reprsenting number of cases in zip code and 
# color representing severity, change by age, demographics?

# Relationship of cases with time and overlay of shop openings in region

analyzePot <- function(arg1) {
        library(plyr)
        
       
        cleanData <- cleanDataFnct(potData)
        
        
        print(head(cleanData))
        patAge(cleanData,arg1)
        
        
        #plot(cleanData[,1], cleanData[,6], xlab = "Date", ylab = "Cumulative Marijuana Related Calls", 
        #    main = "Chronological WA State Calls 2014", bty = "n", pch = 19, col="#00000030") 

        # Loop through city by city and show their normalized marijuana cases over time
}

patAge <- function(data, more) {
        j <- 1
        ageData <- matrix(nrow = length(data$patAge), ncol = 6)
        for (i in 1:length(data)) {
                if (data[i,4] > more) {
                        ageData[j,] <- data[i,]
                        j <- j + 1
                }
        ageData$cases <- c(1:length(ageData$PatAge))
        }
        plot(ageData[,4], ageData[,6])
        
}


cleanDataFnct <- function(rawData) {
        columns <- c(8,9,6,7)
        colNames <- c("Date", "City", "County", "Age", "AgeUnit", "Cumulative Cases")
        
        timestamp <- c(as.POSIXct(rawData$StartDate, format = "%m/%e/%y %H:%M"))   # Parse timestamps
        cases <- 1:length(timestamp)
        cleaning <- cbind(timestamp,rawData[,columns])                         # Create clean df with necessary columns
        cleaning$CallerCounty <- tolower(cleaning$CallerCounty)         # Make Caller Counties all lowercase
        cleaning$PatAgeUnit <- tolower(cleaning$PatAgeUnit)
        
        for (i in 1:length(cleaning$PatAgeUnit)) {
                if (cleaning$PatAgeUnit[i] == "months") {
                        cleaning$PatAge[i] <- (cleaning$PatAge[i]/12)
        }
        
        }
        
        cleaning <- cleaning[order(cleaning$timestamp),]
        cleaning<- cbind(cleaning, cases)
        #colnames(cleaning) <- colNames
        
}