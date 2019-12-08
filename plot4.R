## This script works with the UCI "Individual household electric power consumption Data Set"
## that can be found here: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
## As input it assumes the file from the above is unzipped and the resulting
## "exdata_data_household_power_consumption" directory containing the data file is placed in the working directory.

## The output of this script is four plots of data from the dataset for two days: Feb 1 and Feb 2, 2007:
## (1) Global Active Power and Date/Time
## (2) Voltage and Date/Time
## (3) Energy Sub Metering (for 3 sub-meters) and Date/Time
## (4) Global Reactive Power and Date/Time
## The plots are output to a file "plot4.png"

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

## Draw 4 plots
par(mfrow=c(2,2))

with(data, {
        ## First plot in upper left is Global Active Power by Date/Time
        plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power")
       
        ## Second plot in upper right is Voltate by Date/Time
        plot(Time, Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        ## Third plot in lower left is Energy sub metering for 3 sub-meters by Date/Time with Legend
        plot(Time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
        lines(Time, Sub_metering_1, col="black")
        lines(Time, Sub_metering_2, col="red")
        lines(Time, Sub_metering_3, col="blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty="solid", bty="n")

        ## Fourth plot in lower right is Global Reactive Power by Date/Time
        plot(Time, Global_reactive_power, type="l", xlab="datetime")
})


## Save to PNG file
dev.copy(png, width=480, height=480, unit="px", file="plot4.png")
dev.off()

## Clean up
par(mfrow=c(1,1))



