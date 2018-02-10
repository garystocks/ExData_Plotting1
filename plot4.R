## Produce 4 plots (2x2) using the data from 2007-02-01 to 2007-02-02
## for the electric power consumption data set from the UCI Machine Learning Database.
## The first plot is a line graph of Global Active Power over the 2 days
## The second plot is a line graph of Voltage by datetime
## The third plot shows 3 line graphs for energy sub metering 1/2/3 over the 2 days
## The fourth plot shows Global_reactive power by datetime

## Download data set
setwd("D:/Users/Gary.stocks/Desktop/Coursera/Course 4 Project")
if (!file.exists("data")) {
  dir.create("data")
  setwd("D:/Users/Gary.stocks/Desktop/Coursera/Course 4 Project/data")
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "dataset.zip")
}
setwd("D:/Users/Gary.stocks/Desktop/Coursera/Course 4 Project/data")

## Load the data into R
## initial <- read.table(unz("dataset.zip", "household_power_consumption.txt"), nrows = 100)
classes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.table(unz("dataset.zip", "household_power_consumption.txt"), 
                   header = TRUE, sep = ";", na.strings = "?", colClasses = classes)

## Convert the Date and Time variables to Date/Time classes
## Use strptime() and as.Date() functions
x <- paste(data$Date, data$Time)
x <- strptime(x, "%d/%m/%Y %H:%M:%S", tz = "")
data$Time <- x
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Subset the data for the dates 2007-02-01 to 2007-02-02
plotdata <- subset(data, Date >= as.Date("2007-02-01"))
plotdata <- subset(plotdata, Date <= as.Date("2007-02-02"))

## Create the png file
png(filename = "plot4.png")

## Create the 2x2 plot area
par(mfrow = c(2,2))

## Produce the first plot, a line graph of Global Active Power over the 2 days
with(plotdata, plot(Time, Global_active_power, type = "l",
                    xlab = "", ylab = "Global Active Power"))

## Produce the second plot, a line graph of Voltage over the datetime
with(plotdata, plot(Time, Voltage, type = "l", 
                    xlab = "datetime", ylab = "Voltage"))

## Produce the third plot, Energy sub metering for each of the 3 sub meters over the 2 days
## First create the blank plot
## Add lines Sub_metering_1/2/3
with(plotdata, {
  plot(Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(Time, Sub_metering_1, col = "black")
  lines(Time, Sub_metering_2, col = "red")
  lines(Time, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), lwd = 2, 
   legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), xjust = 1, cex = 0.35, bty = "n")
})

## Create the fourth plot, Global_reactive_power over datetime
with(plotdata, plot(Time, Global_reactive_power, type = "l",
                    xlab = "datetime", ylab = "Global_reactive_power"))

## Close the device
dev.off()