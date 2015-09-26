# 6. Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


sccSet <- subset(SCC, grepl("Vehicle", EI.Sector))


baltimorData <- subset(NEI, fips == "24510" & NEI$SCC %in% sccSet$SCC)
laData <- subset(NEI, fips == "06037" & NEI$SCC %in% sccSet$SCC)


baltimorSummary <- xtabs(Emissions~year,data=baltimorData)
laSummary <- xtabs(Emissions~year,data=laData)


plot(as.numeric(names(baltimorSummary)), baltimorSummary, type = "l", 
     ylab = "Emission", xlab = "Year", col = "red", ylim = c(0, 5000))

lines(as.numeric(names(laSummary)), laSummary, col="green")




legend("topright", col = c("red", "green"), 
       legend = c("Baltimor", "Los Angeles County"), 
       lty = 1)
