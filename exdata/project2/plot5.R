# 5. How have emissions from motor vehicle 
# sources changed from 1999–2008 in Baltimore City?


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find emission source categories related to emissions from motor vehicle 
sccSet <- subset(SCC, grepl("Vehicle", EI.Sector))$SCC

vehicleSources <- subset(NEI, fips == "24510" & SCC %in% sccSet)

summaryData <- xtabs(Emissions ~ year, data = vehicleSources)

# convert xtabs object into dataframe
df <- as.data.frame(summaryData)

# convert year from categorical to numerical
df$year <- as.numeric(as.character(df$year))

library(ggplot2)

png(file="plot5.png")


qplot(year, Freq, data = df) + geom_line() +
  ggtitle("Emissions from motor vehicle sources in Baltimore City 1999–2008")  +
  ylab("Amount of PM2.5 emitted, in tons") +
  xlab("Year")


dev.off()
