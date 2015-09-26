# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 
# 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filtering emission sources for Baltimore city
baltimoreData <- subset(NEI, fips == "24510" )

# summarize emmision by year and by type
summaryData <- xtabs(Emissions ~ year + type, data = baltimoreData)

# convert xtabs object into dataset
summaryDF <- as.data.frame(summaryData)

# convert year from categorical to numerical
summaryDF$year <- as.numeric(as.character(summaryDF$year))

# plotting
library(ggplot2)

png(file="plot3.png")

qplot(year, Freq, data = summaryDF, color = type) + geom_line() +
ggtitle("Emissions of differnt source types\n for Baltimore City 1999-2008")  +
  ylab("Amount of PM2.5 emitted, in tons") +
  xlab("Year")

dev.off()