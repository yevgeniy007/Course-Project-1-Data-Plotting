# ===================================================================================
# Course Project 1 - Exploratory Data Analysis
# Student: Yevgeniy Samyshkin, GSK
# ===================================================================================

# Clean memory from any garbage
rm(list=ls())

# The current working directory should contain both txt datafile and code, no subdirectories  

library(lubridate)
library(base)
library(dplyr)
library(grDevices)

# My laptop has large memory - I do not need to worry whether it has sufficient memory to updload file - I have tested that by uploadig the file into several different datasets
mydata<-read.table("household_power_consumption.txt", header=TRUE, sep = ";")
	
mydata <- select(mydata, Date, Time, Global_active_power, Global_reactive_power)

# These transformations are needed to construct a combined date-time field for the required timeseries analysis 

mydata$Date1 <- as.Date(mydata$Date,"%d/%m/%Y")
mydata$Time1 <- as.character(mydata$Time)

# Selected data for charting 

mydata$Year<-year(mydata$Date1)
mydata$Month<-month(mydata$Date1)
mydata$Day<-day(mydata$Date1)

mydata<-filter(mydata, Year==2007 & Month==2 & Day<=2)

# This is the key line of the code as it combines Date and Time into one timstamp value enabling us to produce time series chart
mydata$DateTime <- as.POSIXct(paste(as.Date(mydata$Date, format="%d/%m/%Y"),as.character(mydata$Time)), format="%Y-%m-%d %H:%M")

mydata$Global_active_power<-as.numeric(as.character(mydata$Global_active_power))

## Line chart
png(filename = "Myplot2.png", width = 480, height = 480, units = "px")
plot(mydata$DateTime, mydata$Global_active_power, type="l", xlab=NA, ylab="Global Active Power (kilowatts)", lwd=2)
dev.off()
 


