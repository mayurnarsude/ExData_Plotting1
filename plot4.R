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

# Plot the figure
png("plot4.png", width = 504, height = 504, units = "px", bg = "transparent")

# multifigure plot
par("mfcol" = c(2,2))

## subplot 1
with(filtData, plot(datetime, Global_active_power, 
                    type = "l", 
                    xlab="", 
                    ylab = "Global Active Power"))

## subplot 2
with(filtData, plot(datetime, Sub_metering_1, 
                    type = "l", 
                    xlab = "",
                    ylab = "Energy sub metering"))

with(filtData,lines(datetime, Sub_metering_2,
                    col = "red", 
                    xlab = ""))

with(filtData,lines(datetime, Sub_metering_3,
                    col = "blue", 
                    xlab = ""))

legend("topright", 
       legend = names(filtData[7:9]), 
       lty = 1, 
       col = c("black", "red", "blue"),
       bty = "n")

## subplot 3
with(filtData, plot(datetime, Voltage, 
                    type = "l"))

## subplot 4
with(filtData, plot(datetime, Global_reactive_power, 
                    type = "l"))

dev.off()