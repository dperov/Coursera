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


# normalize data in order to show only changes
# set 1999 emission level as "1" (100%)
level1999Balt = df[df$year == 1999 & df$location == "Baltimore",]$Freq
level1999La = df[df$year == 1999 & df$location == "LA",]$Freq


df$Freq <- ifelse(df$location == "Baltimore", df$Freq / level1999Balt, df$Freq / level1999La)

# plotting
library(ggplot2)
library(scales)

png(file="plot6.png")

qplot(year, Freq, data = df, color = location) + geom_line() +
  ggtitle("Change of the total emissions from motor vehicle\n in Baltimore City and Los Angeles County in  1999-2008\n1999 emission level is 100%")  +
  ylab("Emission of PM2.5 relative to 1999") +
  xlab("Year") +
  scale_y_continuous(labels = percent_format())
dev.off()

