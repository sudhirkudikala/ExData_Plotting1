
rm(list=ls())
# the data file should be in working directory
# there are nulls in file. Set class to characters to import
power <- read.table("household_power_consumption.txt",header = TRUE,sep = ";", colClasses = "character")

power[,1] <- as.Date(power$Date, "%d/%m/%Y")
psub <- subset(power, power$Date %in% as.Date(c("2007-02-01","2007-02-02")))

# modify second column to suit POSIXct format, date and time
psub[,2] <- as.POSIXct(paste(psub$Date, psub$Time), format = "%Y-%m-%d %T")

# set the required column classes to numeric
psub[,3] <- as.numeric(psub[,3])
psub[,4] <- as.numeric(psub[,4])
psub[,5] <- as.numeric(psub[,5])
psub[,7] <- as.numeric(psub[,7])
psub[,8] <- as.numeric(psub[,8])
psub[,9] <- as.numeric(psub[,9])

par(mfrow = c(2,2))
# plot global active power
plot(psub$Time, psub[,3], type = "l", xlab = "", ylab = "Global Active Power")
# plot voltage
plot(psub$Time, psub[,5], type = "l", xlab = "datetime", ylab = "Voltage")
# plot sub meters
plot(psub$Time, psub[,7], type = "l", xlab = "", ylab = "Energy sub metering")
lines(psub[,2], psub[,8], col = "Red")
lines(psub[,2], psub[,9], col = "Blue")
# bty: the box type around legend, o/n
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("Black","Red","Blue"), lwd = 1, pt.cex = 0.2, cex = 0.9, bty = "n")

# plot global reactive power
plot(psub$Time, psub[,4], type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# set width and height to 480 pixels
dev.copy(png, file = "figure/plot4.png", width = 480, height = 480, units = "px")
dev.off()
