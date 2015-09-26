# 6. Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sccSet <- subset(SCC, grepl("Vehicle", EI.Sector))

data <- subset(NEI, (fips == "24510" | fips == "06037" ) & NEI$SCC %in% sccSet$SCC)

# summarizing emissions by year and region
summaryData <- xtabs(Emissions~year+fips,data=data)
#laSummary <- xtabs(Emissions~year,data=laData)

# convert xtabs object into dataset
df <- as.data.frame(summaryData)

# convert year from categorical to numerical
df$year <- as.numeric(as.character(df$year))

# create location columns based on fips value
df$location <- ifelse(df$fips == "24510", "Baltimore", "LA")


# plotting
library(ggplot2)

png(file="plot6.png")

qplot(year, Freq, data = df, color = location) + geom_line() +
  ggtitle("Emissions from motor vehicle sources\n in Baltimore City and Los Angeles County 1999-2008")  +
  ylab("Amount of PM2.5 emitted, in tons") +
  xlab("Year")

dev.off()

