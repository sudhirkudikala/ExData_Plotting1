
rm(list=ls())
# the data file should be in working directory
# there are nulls in file. Set class to characters to import
power <- read.table("household_power_consumption.txt",header = TRUE,sep = ";", colClasses = "character")

power[,1] <- as.Date(power$Date, "%d/%m/%Y")
psub <- subset(power, power$Date %in% as.Date(c("2007-02-01","2007-02-02")))

psub[,2] <- as.POSIXct(paste(psub$Date, psub$Time), format = "%Y-%m-%d %T")

# set the column class of 'Global_active_power' to numeric
psub[,3] <- as.numeric(psub[,3])

plot(psub$Time, psub[,3], type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "figure/plot2.png", width = 480, height = 480, units = "px")
dev.off()
