# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

data <- subset(NEI, fips == "24510" )

r <- sapply(split(data, data$year), function(x) sum(x$Emission))
summaryData <- data.frame(year = as.numeric(names(r)), Emission = as.vector(r))

png(file="plot2.png")
plot(summaryData$year, summaryData$Emission, type = "l", col = "red",
     xlab = "Year", ylab = "Amount of PM2.5 emitted, in tons",
     main = "Total emissions from PM2.5 in the Baltimore City 1999-2008")
dev.off()




