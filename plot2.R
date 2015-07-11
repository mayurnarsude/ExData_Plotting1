# load the necessary libraries
if(!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr)

# setup the file path
f <- file.path("C:/Users/Mayur/Documents/Coursera/4-ExploratoryDataAnalysis",
               "courseProject1", "household_power_consumption.txt")

# read the entire dataset since I have enough RAM
energyData <- read.table(f, header = TRUE, sep = ";", na.strings = "?", 
                         stringsAsFactors = FALSE)
energyData$Date <- as.Date(energyData$Date, format = "%d/%m/%Y")

# filter out dates of interest
doi <- as.Date(c("01/02/2007", "02/02/2007"), format = "%d/%m/%Y")
filtData <- filter(energyData, Date %in% doi)

# combine date and time
datetime <- strptime(paste(filtData$Date, filtData$Time), "%Y-%m-%d %H:%M:%S")

# plot the figure
png("plot2.png", width = 504, height = 504, units = "px", bg = "transparent")
with(filtData, plot(datetime, Global_active_power, 
                    type = "l", 
                    xlab="", 
                    ylab = "Global Active Power (kilowatts)"))
dev.off()