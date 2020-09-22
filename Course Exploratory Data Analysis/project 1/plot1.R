# Read the headers
headers <- read.csv2("household_power_consumption.txt", nrows=1, header=F, as.is = T)

# Read only the data from specified dates
data <- read.csv2("household_power_consumption.txt", skip=66637, nrows=2880, header=F)

# Assign column names
colnames(data) <- headers

# Type conversions
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Open de PNG device
png("plot1.png", width=480, height=480)

# Plot creation
hist(data$Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

# Closing the PNG device
dev.off()
