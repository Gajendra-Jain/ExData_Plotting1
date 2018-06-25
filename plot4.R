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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(filter_data1, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Energy Sub Metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global_Reactive_Power",xlab="datetime")
})

## Printing the plot to the device
dev.copy(png,"plot4.png",width = 480, height = 480)
dev.off()
