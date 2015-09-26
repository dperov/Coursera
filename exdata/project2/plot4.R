# 4. Across the United States, 
# how have emissions from coal combustion-related 
# sources changed from 1999–2008?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# use regular expression to select categories related to coal combustion
sccSet <- subset(SCC, grepl("^Fuel Comb.+Coal$", EI.Sector))$SCC

## select only coal related emission sources
coalSources <- NEI[NEI$SCC %in% sccSet,]

# summarize emission by year
summaryData <- xtabs(Emissions~year,data=coalSources)

# convert xtabs object into dataset
df <- as.data.frame(summaryData)

# convert year from categorical to numerical
df$year <- as.numeric(as.character(df$year))

png(file="plot4.png")

plot(x = df$year, y = df$Freq, type = "l", col = "red",
     main = "Emissions from coal combustion-related sources 1999–2008",
     ylab = "Amount of PM2.5 emitted, in tons", 
     xlab = "Year")

dev.off()
