# 5. How have emissions from motor vehicle 
# sources changed from 1999–2008 in Baltimore City?


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


sccSet <- subset(SCC, grepl("Vehicle", EI.Sector))

vehicleSources <- NEI[NEI$SCC %in% sccSet$SCC,]


summaryData <- xtabs(Emissions~year,data=vehicleSources)

plot(as.numeric(names(summaryData)), summaryData, type = "n", 
     ylab = "Emission", xlab = "Year")

lines(as.numeric(names(summaryData)), summaryData, col="black")
