## Create a line graph of Energy sub-metering from 2007-02-01 to 2007-02-02
## for the electric power consumption data set from the UCI Machine Learning Database

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

## Produce the line graph and publish to plot3.png
## First create the blank plot
with(plotdata, plot(Time, Sub_metering_1, type = "n",
                    xlab = "", ylab = "Energy sub metering"))

## Add a line in black for Sub_metering_1
with(plotdata, lines(Time, Sub_metering_1, col = "black"))

## Add a line for Sub_metering_2 in red
with(plotdata, lines(Time, Sub_metering_2, col = "red"))

## Add a line for Sub_metering_3 in blue
with(plotdata, lines(Time, Sub_metering_3, col = "blue"))

## Add a legend in the top right corner
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1),  
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Publish to plot3.png
dev.copy(png, file = "plot3.png")
dev.off()