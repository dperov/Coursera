# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


data <- subset(NEI, fips == "24510" )

summaryData <- xtabs(type+year~Emissions,data=data)

str(summaryData)



plot(as.numeric(names(summaryData[1,])), summaryData[1,], type = "n", 
     ylab = "Emission", xlab = "Year", ylim = c(0, 2200))

lines(as.numeric(names(summaryData[1,])), summaryData[1,], col="black")
lines(as.numeric(names(summaryData[2,])), summaryData[2,], col="red")
lines(as.numeric(names(summaryData[3,])), summaryData[3,], col="green")
lines(as.numeric(names(summaryData[4,])), summaryData[4,], col="yellow")

legend("topright", col = c("black", "red", "green", "yellow"), 
       legend = dimnames(summaryData)$type, 
       lty = 1)
