## R script to construct plot 4: Four separate line plots 
# describing energy usage over time from February 1st through the 2nd in 2007 

#The data is subseted and cleaned the same way as for the first 3 plots

# Read power consumption data into the R environment
data <- read.table("household_power_consumption.txt", sep = ";", dec = ".",
                   header = TRUE)

# Convert the factors in the Date column to actual Date values
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subset the dataframe to the dates of interest
df <- subset(data, Date == "2007-02-01" | Date=="2007-02-02")

# Add a column to the dataframe that contains 
# both date and time time information
# that can be recognized in R
library(dplyr)
library(lubridate)
df <- mutate(df, date_time = paste(Date, Time))
df$date_time <-ymd_hms(df$date_time)

# Convert all of the Sub_metering, Voltage and Global_reactive_power
# columns from factors to numeric values
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

#Construct the plots within one png file device
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
with(df, {
        #Re-construct plot 2
        plot(x = df$date_time, y = df$Global_active_power, type="n",
             ylab = "Global Active Power (kilowatts)", xlab = " ")
        lines(x = df$date_time, y = df$Global_active_power)
        
        #Make a line graph of the minute averaged voltage (in volt) over time
        plot(x = df$date_time, y = df$Voltage, 
             ylab = "Voltage", xlab = "datetime", type = "l")
        
        #Re-construct plot 3
        plot(x = df$date_time, y = df$Sub_metering_1, 
             ylab = "Energy sub metering", xlab = "", type = "l")
        lines(x = df$date_time, y = df$Sub_metering_2, col = "red")
        lines(x = df$date_time, y = df$Sub_metering_3, col = "blue")
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, col = c("black", "red", "blue"))
        
        #Make a line graph of the minute averaged global reactive power over time
        plot(x = df$date_time, y = df$Global_reactive_power, 
             ylab = "Global_reactive_power", xlab = "datetime", type = "l")
        
})
dev.off()