# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


data <- subset(NEI, fips == "24510" )

r <- sapply(split(data, data$year), function(x) sum(x$Emission))

summaryData <- data.frame(year = as.numeric(names(r)), Emission = as.vector(r))

plot(summaryData$year, summaryData$Emission, type = "n")
lines(summaryData$year, summaryData$Emission)




