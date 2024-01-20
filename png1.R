library(dplyr)

png1 <- function() {
  householdElectric <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?") 

  names(householdElectric) <- householdElectric[1,]

  householdElectric <- householdElectric[2:2075260,] %>%    
    filter(Date == "1/2/2007" | Date == "2/2/2007")  
    
  householdElectric <- mutate(householdElectric, datetime = paste(householdElectric$Date, householdElectric$Time, sep = " "))
    
  householdElectric <- mutate(householdElectric, datetime = strptime(householdElectric$datetime, "%d/%m/%Y %H:%M:%S"))

  png1 <- png("png1.png")
  hist(as.numeric(householdElectric$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
  dev.off()
}