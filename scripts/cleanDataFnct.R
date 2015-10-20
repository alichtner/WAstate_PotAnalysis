#---------------------------------------------------------------------------------------
# Function to read in a csv from the Washington State Poison Center, clean the data and
# ready it for analysis and plotting
#---------------------------------------------------------------------------------------
cleanDataFnct <- function() {
        
        library(plyr)
        
        #---------------------------------------------------------------------------------------
        # Read in data, columns are columns to be read into "cleaning" dataframe
        #---------------------------------------------------------------------------------------
        
        rawData <- read.csv("MarijaunaExposureData.csv", sep=",")          
        columns <- c(9,8,11,6,7,10,3,4)
        
        #---------------------------------------------------------------------------------------
        # Parse timestamp data into as.POSIXct objects
        #---------------------------------------------------------------------------------------
        
        timestamp <- c(as.POSIXct(rawData$StartDate, format = "%m/%e/%y %H:%M"))   
        
        #---------------------------------------------------------------------------------------
        # Clean dataset 
        #---------------------------------------------------------------------------------------
        
        severity <- rep(NA, length(timestamp))                                  # Create blank columns 
        notFollowed <- rep(0, length(timestamp))
        cleaning <- cbind(timestamp,rawData[,columns], severity, notFollowed)   # Column bind df with necessary columns
        cleaning[,c(2,3,6,8,9)] <- lapply(cleaning[,c(2,3,6,8,9)], tolower)             # Makes County, City, AgeUnit lowercase
        cleaning[,8] <- paste(cleaning[,8], cleaning[,9], sep = " ")
        cleaning[,9] <- NULL
        
        #---------------------------------------------------------------------------------------
        # Converts month ages to years, assigns severity to cases, assigns "1" to "NotFollowed" 
        # if it wasn't severe, "2" to "unable to follow"
        #---------------------------------------------------------------------------------------
        
        for (i in 1:length(cleaning$PatAgeUnit)) {
                if (cleaning$PatAgeUnit[i] == "months") {
                        cleaning$PatAge[i] <- round((cleaning$PatAge[i]/12), digits = 1)
                }
                if (cleaning$MedicalOutcome[i] == "No effect") {
                        cleaning$severity[i] = 0
                }
                if (cleaning$MedicalOutcome[i] == "Minor effect") {
                        cleaning$severity[i] = 1
                }
                if (cleaning$MedicalOutcome[i] == "Moderate effect") {
                        cleaning$severity[i] = 2
                }
                if (cleaning$MedicalOutcome[i] == "Major effect") {
                        cleaning$severity[i] = 3
                }
                if (cleaning$MedicalOutcome[i] == "Not followed, minimal clinical effects possible (no more than minor effect possible)") {
                        cleaning$notFollowed[i] = 1
                }
                if (cleaning$MedicalOutcome[i] == "Unable to follow, judged as a potentially toxic exposure") {
                        cleaning$notFollowed[i] = 2
                }
        }
        
        #---------------------------------------------------------------------------------------
        # Produce and return final "clean" dataframe and order by date
        #---------------------------------------------------------------------------------------
        
        clean <- cleaning[,c(1:5,8,9,10)] 
        clean <- clean[order(clean$timestamp),]
        clean <- marijuanaSource(clean)
        columnNames <- c("Date", "County", "City", "Zip", "Age", "Source", "Severity", "NotFollowed", "MainSource")
        colnames(clean) <- columnNames
        return(clean)
}

marijuanaSource <- function(data) {
        
        working <- data
        
        for(i in 1:length(data[,1])) {
                if (grepl("candy", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Candy"
                        i <- i + 1
                }
                if (grepl("chocolate", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Candy"
                        i <- i + 1
                }
                if (grepl("chews", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Candy"
                        i <- i + 1
                }
                if (grepl("oil", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Hash Oil"
                        i <- i + 1
                }
                if (grepl("dab", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Hash Oil"
                        i <- i + 1
                }
                if (grepl("extract", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Hash Oil"
                        i <- i + 1
                }
                if (grepl("drink", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Drinks"
                        i <- i + 1
                }
                if (grepl("beverage", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Drinks"
                        i <- i + 1
                }
                if (grepl("brownie", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Brownies"
                        i <- i + 1
                }
                if (grepl("cookie", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Cookies"
                        i <- i + 1
                }
                if (grepl("edible", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Other Food"
                        i <- i + 1
                }
                if (grepl("wax", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Misc"
                        i <- i + 1
                }
                if (grepl("food", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Other Food"
                        i <- i + 1
                }
                if (grepl("thc", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "thc"
                        i <- i + 1
                }
                if (grepl("cannabis", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Marijuana Plant"
                        i <- i + 1
                }
                if (grepl("pot", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Marijuana Plant"
                        i <- i + 1
                }
                if (grepl("marijuana", working[i,6], ignore.case = TRUE)) {
                        working[i,9] = "Marijuana Plant"
                        i <- i + 1
                }
                else {
                        working[i,9] = "Misc"
                }
        }
        return(working)
}
