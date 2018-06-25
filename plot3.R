library(dplyr)

## Download the file

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip dataSet to /data directory

unzip(zipfile="./data/Dataset.zip",exdir="./data_exploratory")

## Setting the current working directory
setwd("~/data_exploratory")

## Reading the household power consumption data

data <- read.table("household_power_consumption.txt", header = TRUE,  sep = ";", na.strings = "?")

## filtering the Data for 1/2/2017 to 2/2/2017

filter_data1 <- filter(data,Date %in% c("1/2/2007","2/2/2007"))

## Formatting the Date

filter_data1$Date <- as.Date(filter_data1$Date, format = "%d/%m/%Y")

## Combining date and time values
dateTime <- paste(as.Date(filter_data1$Date),filter_data1$Time)

## Adding a new column dateTime to filter_data1
filter_data1$dateTime <- as.POSIXct(dateTime)

## Plotting the graph
with(filter_data1, {
  plot(Sub_metering_1 ~ dateTime, type="l",
       ylab="Energy sub metering", xlab="")})
  lines(filter_data1$Sub_metering_2 ~ filter_data1$dateTime,col='Red')
  lines(filter_data1$Sub_metering_3 ~ filter_data1$dateTime,col='Blue')

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Printing the plot to the device
dev.copy(png,"plot3.png",width = 480, height = 480)
dev.off()
