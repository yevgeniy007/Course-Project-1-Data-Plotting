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
	
mydata <- select(mydata, Date, Time, Global_active_power, Global_reactive_power, Sub_metering_1, Sub_metering_2, Sub_metering_3)

# These transformations are needed to construct a combined date-time field for the required timeseries analysis 

mydata$Date1 <- as.Date(mydata$Date,"%d/%m/%Y")
mydata$Time1 <- as.character(mydata$Time)




# Selected data for charting 

mydata$Year<-year(mydata$Date1)
mydata$Month<-month(mydata$Date1)
mydata$Day<-day(mydata$Date1)

mydata<-filter(mydata, Year==2007 & Month==2 & Day<=2)

## IMPORTANT - note that whan imported from text, the class for Sub_metering_1 and Sub_metering_2 if "factor" whereas for Sub_metering_3 - it is numeric
## hence only 1 and 2 are transformed into numeric 

mydata$Sub_metering_1<-as.numeric(as.character(mydata$Sub_metering_1))
mydata$Sub_metering_2<-as.numeric(as.character(mydata$Sub_metering_2))
## mydata$Sub_metering_3<-as.numeric(mydata$Sub_metering_3)

# This is the key line of the code as it combines Date and Time into one timstamp value enabling us to produce time series chart
mydata$DateTime <- as.POSIXct(paste(as.Date(mydata$Date, format="%d/%m/%Y"),as.character(mydata$Time)), format="%Y-%m-%d %H:%M")

mydata$Global_active_power<-as.numeric(as.character(mydata$Global_active_power))



## Line chart

png(filename = "Myplot3.png", width = 480, height = 480, units = "px")

### With column limit 38 (rather than 40) the y-axis appear exacly as in the example from Coursera 

plot(mydata$DateTime, mydata$Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering", col="black", lwd=2, ylim=c(0,38))

lines(mydata$DateTime, mydata$Sub_metering_2, type="l", xlab=NA, ylab="Energy sub metering", col="red", lwd=2, ylim=c(0,38))

lines(mydata$DateTime, mydata$Sub_metering_3, type="l", xlab=NA, ylab="Energy sub metering", col="blue", lwd=2, ylim=c(0,38))

legend("topright", lwd=c(2,2,2), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.off()
 


