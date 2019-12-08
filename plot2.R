## This script works with the UCI "Individual household electric power consumption Data Set"
## that can be found here: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
## As input it assumes the file from the above is unzipped and the resulting
## "exdata_data_household_power_consumption" directory containing the data file is placed in the working directory.

## The output of this script is a plot of Global Active Power and Date/Time data from the dataset
## for two days: Feb 1 and Feb 2, 2007. 
## The plot is output to a file "plot2.png"

## Load necessary libraries
library(data.table)

## Read the data from the provided file
filename<-"exdata_data_household_power_consumption/household_power_consumption.txt"
data<-fread(filename, na.strings="?")

## Subset only the two relevant dates
data<-data[data$Date=="1/2/2007" | data$Date=="2/2/2007"]

## Convert the Date and Time columns to Date and POSIXct classes
## Time column will also include Date
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
data$Time<-as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

## Draw plot of Global Active Power by Date/Time
with(data, plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

## Save to PNG file
dev.copy(png, width=480, height=480, unit="px", file="plot2.png")
dev.off()



