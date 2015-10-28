# Graph number of cases by day of the week

caseDayType <- zip %>% group_by(weekdays(Date)) %>% summarize(count = n())

caseDayType <- caseDayType[c(2,6,7,5,1,3,4),]
barplot(caseDayType$count, 
        names.arg = caseDayType$`weekdays(Date)`, 
        cex.names = 0.8, 
        ylab = "Number of Calls", 
        las = 2,
        main = "Calls per Week")

# Graph number of cases by month

zip <- zip[zip$Date <= "2015-01-01 00:00:00",]
caseMonth <- zip %>% group_by(months(Date)) %>% summarize(count = n())

caseMonth <- caseMonth[c(5,4,8,1,9,7,6, 2, 12, 11, 10, 3),]
barplot(caseMonth$count, 
        names.arg = caseMonth$`months(Date)`, 
        cex.names = 0.8, 
        ylab = "Number of Calls", 
        las = 2, 
        main = "January 3, 2014 to December 31, 2014")