# Read the headers
headers <- read.csv2("household_power_consumption.txt", nrows=1, header=F, as.is = T)

# Read only the data from specified dates
data <- read.csv2("household_power_consumption.txt", skip=66637, nrows=2880, header=F)

# Assign column names
colnames(data) <- headers

# Type conversions
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Change locale so the days appear in english (my default is spanish)
Sys.setlocale("LC_TIME", "C")

# Create a new column with date and time together
data$date_time <- as.POSIXct(paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S")

# Open de PNG device
png("plot4.png", width=480, height=480)

# Plot creation
par(mfrow=c(2,2))
## Subplot 1
plot(x = data$date_time, y = data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## Subplot 2
plot(x = data$date_time, y = data$Voltage, type="l", xlab="datetime", ylab="Voltage")

## Subplot 3
plot(x = data$date_time, y = data$Sub_metering_1, type="l", xlab="", ylab="Energy Sub metering")
lines(data$date_time, data$Sub_metering_2, col="red")
lines(data$date_time, data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), bty="n")

## Subplot 4
plot(x = data$date_time, y = data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power" )

# Closing the PNG device
dev.off()
