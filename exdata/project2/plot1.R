# Have total emissions from PM2.5 decreased in the 
# United States from 1999 to 2008? 
# Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

# calculate totals by year 
r <- sapply(split(NEI, NEI$year), function(x) sum(x$Emission))

# put result im data frame
df <- data.frame(year = as.numeric(names(r)), Emission = as.vector(r))

png(file="plot1.png", width = 480, height = 480)
plot(x = df$year, y = df$Emission, type = "l", col = "red",
     xlab = "Year", ylab = "Amount of PM2.5 emitted, in tons",
     main = "Total emissions from PM2.5 in the United States 1999-2008")
dev.off()