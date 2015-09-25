## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

s <- split(NEI, NEI$year)
r <- sapply(s, function(x) sum(x$Emission))

emission_year <- data.frame(year = as.numeric(names(r)), Emission = as.vector(r))
plot(emission_year$year, emission_year$Emission, type = "n")
lines(emission_year$year, emission_year$Emission)