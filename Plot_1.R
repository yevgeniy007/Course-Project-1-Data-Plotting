# ===================================================================================
# Course Project 1 - Exploratory Data Analysis
# Student Yevgeniy Samuyshkin


rm(list=ls())

# Your working directory should contain txt datafile and code 

setwd("C:/Users/ys906826/Documents/04. Training/07. Coursera III (Exploratory Analysis)/Course Project 1")

# Read data file, it is a table with 9 columns (variables) separated by semicolon
# Variable names (column headings) are in the 1st row of the table 

# Check memory here programmatically - outstanding 

library(lubridate)
library(base)
library(dplyr)
library(grDevices)

mydata<-read.table("household_power_consumption.txt", header=TRUE, sep = ";")

# We will only be using data from the dates 2007-02-01 and 2007-02-02
	
mydata1<-select(mydata, Date, Time, Global_active_power, Global_reactive_power, Sub_metering_1, Sub_metering_2, Sub_metering_3)



mydata1$Date1 <- as.Date(mydata1$Date,"%d/%m/%Y")
mydata1$Time1 <- as.character(mydata1$Time)

rm(mydata)

mydata1$Year<-year(mydata1$Date1)
mydata1$Month<-month(mydata1$Date1)
mydata1$Day<-day(mydata1$Date1)

# Selected data for charting 
mydata2<-filter(mydata1, Year==2007 & Month==2 & Day<=2)

mydata2$Time2 <- strptime(mydata2$Time1, format="%H:%M")

rm(mydata1)

mydata2$Global_active_power<-as.numeric(as.character(mydata2$Global_active_power))
mydata2$Global_reactive_power<-as.numeric(as.character(mydata2$Global_reactive_power))
mydata2$Sub_metering_1<-as.numeric(as.character(mydata2$Sub_metering_1))
mydata2$Sub_metering_2<-as.numeric(as.character(mydata2$Sub_metering_2))
mydata2$Sub_metering_3<-as.numeric(as.character(mydata2$Sub_metering_3))

## Histogram 1

png(filename = "Myplot1.png", width = 480, height = 480, units = "px")
hist(mydata2$Global_active_power, ylab="Frequency", xlab="Global Active Power (kilowatts)", col="red", breaks=20, main="Global Active Power")
## dev.copy(png, file = "cgrap1.png")

dev.off()


# rm(mydata)

 


