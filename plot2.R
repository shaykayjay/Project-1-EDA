library(sqldf)
library(ggplot2)
library(datasets)

## read txt file into df for 2007-02-01 to 2007-02-02
df <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date IN ('1/2/2007', '2/2/2007') ", sep = ";")
closeAllConnections()

## merge Date and Time column
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, format ="%d/%m/%Y %H:%M:%S")

## plot global active power
with(df, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)"))

dev.copy(png, width=480, height=480, file = "plot2.png")

dev.off()