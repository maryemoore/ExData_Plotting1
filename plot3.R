## R script to construct plot 3: three line plots of the 
# sub-metered active power (in watt-hour) from specific rooms/appliances
# over time from February 1st through the 2nd in 2007 

# The first 3 tasks used to construct Plot 1 
# and additional 2 tasks added to that to construct Plot 2
# are repeated here

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

#Convert all of the Sub_metering columns from factors to numeric values
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))

# Open the png device and create a line type plot of 
# the watt-hour of active energy from the kitchen
png("plot3.png", width = 480, height = 480, units = "px")
plot(x = df$date_time, y = df$Sub_metering_1, 
     ylab = "Energy sub metering", xlab = "", type = "l")

# Add a line type plot over this one that illustrates
# the watt-hour of active energy from the laundry room
lines(x = df$date_time, y = df$Sub_metering_2, col = "red")

# Add a third and final line plot over the previous two showing
# the watt-hour of active energy from
# an electric water heater and an air-conditioner
lines(x = df$date_time, y = df$Sub_metering_3, col = "blue")

# Add a legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))

# Close the png divice
dev.off()