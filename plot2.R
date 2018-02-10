## Create a line graph of Global Active Power (kilowatts) from 2007-02-01 to 2007-02-02
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

## Produce the line graph and publish to plot2.png
with(plotdata, plot(Time, Global_active_power, type = "l",
                    xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()