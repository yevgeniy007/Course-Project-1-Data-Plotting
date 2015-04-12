# ===================================================================================
# Course Project 1 - Exploratory Data Analysis
# Student Yevgeniy Samuyshkin
# ===================================================================================
# At the end of this script there is a short discussion / interpretation of the histogram 


# Clean memory from any garbage 
rm(list=ls())

# The current working directory should contain both txt datafile and code, no subdirectories  

library(lubridate)
library(base)
library(dplyr)
library(grDevices)

# My laptop has large memory - I do not need to worry whether it has sufficient memory to updload file - I have tested that by uploadig the file into several different datasets
mydata<-read.table("household_power_consumption.txt", header=TRUE, sep = ";")

mydata<-select(mydata, Date, Time, Global_active_power)

mydata$Date1 <- as.Date(mydata$Date,"%d/%m/%Y")
### mydata$Time1 <- as.character(mydata$Time)

### This is for filtering: 
mydata$Year<-year(mydata$Date1)
mydata$Month<-month(mydata$Date1)
mydata$Day<-day(mydata$Date1)

mydata<-filter(mydata, Year==2007 & Month==2 & Day<=2)

## Active power needs to be numeric for histogram 
mydata$Global_active_power<-as.numeric(as.character(mydata$Global_active_power))

## ============== Histogram 1

# Set output device as PNG and determine the filename and size in pixels
png(filename = "Myplot1.png", width = 480, height = 480, units = "px")
hist(mydata$Global_active_power, ylab="Frequency", xlab="Global Active Power (kilowatts)", col="red", breaks=20, main="Global Active Power")

## Close the file on completon 
dev.off()


## === Interpetation ============================================
## What does this histogram tells us? - a hypothesis below
## Most frequetl observations correspond to low values of power per minute, probably corresponding to lightig  (we cannot tell this from data but can explore further)
## A peak in the histogram Bar 3 is likely due to a typical power consumptiopn of household appliances, representing a threshold
## if we produce this histogram with a higher resolution (Histogram-(scenario)-higher resolution.png), we can see clearly a discrete nature of power consumption 


# === End of script 
 


