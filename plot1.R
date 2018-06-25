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

## Ploting the histogram
hist(filter_data1$Global_active_power, main = "Global Activev Power", xlab = "Global Active Power (Kilowatts)", ylab = "Frequency", col = "Red")

## Printing the histogram to the file

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
