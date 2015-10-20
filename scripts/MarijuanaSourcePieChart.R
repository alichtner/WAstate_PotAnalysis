library(RColorBrewer)

cols <- brewer.pal(6,"Greens")          # Creates Color Palette
pie(table(weedData$MainSource), col = cols, main = "Source of Exposures (King County)")