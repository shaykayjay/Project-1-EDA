plot.new()
library(sqldf)
library(ggplot2)
library(datasets)

## read txt file into df for 2007-02-01 to 2007-02-02
df <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date IN ('1/2/2007', '2/2/2007') ", sep = ";")
closeAllConnections()

## merge Date and Time column
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, format ="%d/%m/%Y %H:%M:%S")

## plot submetering columns 1, 2 & 3
with(df, {
    plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", 
              ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)))
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", lty = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1   ", "Sub_metering_2   ", "Sub_metering_3   "),
           cex=0.70)
})

dev.copy(png, width=480, height=480, file = "plot3.png")

dev.off()