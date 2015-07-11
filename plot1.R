# R script to construct plot 1: a histogram plot of the 
# household global minute-averaged active power (in kilowatt)
# on February 1st and 2nd in 2007 

# Read power consumption data into the R environment
data <- read.table("household_power_consumption.txt", sep = ";", dec = ".",
                   header = TRUE)

# Convert the factors in the Date column to actual Date values
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subset the dataframe to the dates of interest
df <- subset(data, Date == "2007-02-01" | Date=="2007-02-02")

# The values in the Global_active_power column loaded as factors
# Convert them to numeric values
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

# Open the png device and construct a histogram 
# of the data in the Global_active_power column
png("plot1.png", width = 480, height = 480, units = "px")
hist(df$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()