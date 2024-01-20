library(dplyr)

png3 <- function() {
  householdElectric <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?")

  names(householdElectric) <- householdElectric[1,]

  householdElectric <- householdElectric[2:2075260,] %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(datetime = paste(Date, Time, sep = " ")) %>%
    mutate(datetime = strptime(datetime, "%d/%m/%Y %H:%M:%S"))

  sm1 <- as.numeric(householdElectric$Sub_metering_1)
  sm2 <- as.numeric(householdElectric$Sub_metering_2)
  sm3 <- as.numeric(householdElectric$Sub_metering_3)

  dt <- householdElectric$datetime

  png3 <- png("png3.png")
  plot(c(dt, dt, dt), c(sm1, sm2, sm3), type = "n", 
      ylab = "Energy sub metering", xlab = "")
  points(dt, sm1, type = "l")
  points(dt, sm2, type = "l", col = "red")
  points(dt, sm3, type = "l", col = "blue")
  legend("topright",
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
      col = c("black", "red", "blue"), lty = 1)
  dev.off()
}