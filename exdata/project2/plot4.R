# 4. Across the United States, 
# how have emissions from coal combustion-related 
# sources changed from 1999–2008?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


sccSet <- subset(SCC, grepl("^Fuel Comb.+Coal$", EI.Sector))$SCC

## select only coal relater emission sources

coalSources <- NEI[NEI$SCC %in% sccSet,]

summaryData <- xtabs(Emissions~year,data=coalSources)

plot(as.numeric(names(summaryData)), summaryData, type = "n", 
     ylab = "Emission", xlab = "Year")

lines(as.numeric(names(summaryData)), summaryData, col="black")
