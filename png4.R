library(dplyr)

png4 <- function() {
  householdElectric <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?") 

  names(householdElectric) <- householdElectric[1,]

  householdElectric <- householdElectric[2:2075260,] %>%    
    filter(Date == "1/2/2007" | Date == "2/2/2007")  
    
  householdElectric <- mutate(householdElectric, datetime = paste(householdElectric$Date, householdElectric$Time, sep = " "))
    
  householdElectric <- mutate(householdElectric, datetime = strptime(householdElectric$datetime, "%d/%m/%Y %H:%M:%S"))

  sm1 <- as.numeric(householdElectric$Sub_metering_1)
  sm2 <- as.numeric(householdElectric$Sub_metering_2)
  sm3 <- as.numeric(householdElectric$Sub_metering_3)

  dt <- householdElectric$datetime
  
  png4 <- png("png4.png")
  par(mfrow = c(2, 2))

#top-left
  plot(householdElectric$datetime, 
      as.numeric(householdElectric$Global_active_power), type = "l",
      ylab = "Global Active Power", xlab = "")
 
#top-right
  plot(householdElectric$datetime, 
      as.numeric(householdElectric$Voltage), type = "l", 
      ylab = "Voltage", xlab = "datetime")
 
#bottom-left
  plot(c(dt, dt, dt), c(sm1, sm2, sm3), type = "n", 
      ylab = "Energy sub metering", xlab = "")
  points(dt, sm1, type = "l")
  points(dt, sm2, type = "l", col = "red")
  points(dt, sm3, type = "l", col = "blue")
  legend("topright",
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
      col = c("black", "red", "blue"), lty = 1)

#bottom-right
  plot(householdElectric$datetime, 
      as.numeric(householdElectric$Global_reactive_power),
      type = "l", xlab = "datetime", ylab = "Global_reactive_power")

  dev.off()
}