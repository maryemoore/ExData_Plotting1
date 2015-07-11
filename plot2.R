## R script to construct plot 2: a line plot of the 
# household global minute-averaged active power (in kilowatt)
# over time from February 1st through the 2nd in 2007 

# The first 3 tasks used to construct Plot 1 are repeated here
# Read power consumption data into the R environment
data <- read.table("household_power_consumption.txt", sep = ";", dec = ".",
                   header = TRUE)

# Convert the factors in the Date column to actual Date values
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subset the dataframe to the dates of interest
df <- subset(data, Date == "2007-02-01" | Date=="2007-02-02")

# Convert the time variables from factors to characters
df$Time <- as.character(df$Time)

# Add a column to the dataframe that contains 
# both date and time time information
# that can be recognized in R
library(dplyr)
library(lubridate)
df <- mutate(df, date_time = paste(Date, Time))
df$date_time <-ymd_hms(df$date_time)

# Open the png device and construct an empty plot
# with date and time on the x-axis and energy usage on the y-axis.
# Fill the plot with a line conecting all of the values for 
# energy usage over time.
png("plot2.png", width = 480, height = 480, units = "px")
plot(x = df$date_time, y = df$Global_active_power, type="n",
     ylab = "Global Active Power (kilowatts)", xlab = " ")
lines(x = df$date_time, y = df$Global_active_power)
dev.off()