caseCount <- count(dataKing$Zip)
shopCount <- count(potShops$Zip)
shopCount <- count(potShops$Zip)
caseCount <- count(dataKing$Zip)

colnames(shopCount) <- c("zip", "shopfreq")
colnames(caseCount) <- c("zip", "freq")
merged <- join(shopCount,caseCount, by = "zip", type = "full")    # joins two dfs together so that ALL zipcodes are kept
merged$shopfreq[is.na(merged$shopfreq)] <- 0                    # change NAs to 0s?
merged$freq[is.na(merged$freq)] <- 0
merged <- merged[order(merged$zip),]
merged <- join(merged, zipcode, by = "zip", type="left")

par(mfrow = c(2,1), mar = c(0,5,5,2))
barplot(merged$freq, col = "green", border = "white", axes = FALSE)
par(mar = c(12,5,0,2))
barplot(-merged$shopfreq, col = "dark green", border = "white", axes = FALSE)