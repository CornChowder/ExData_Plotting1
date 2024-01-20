library(dplyr)

png2 <- function() {
  householdElectric <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?")

  names(householdElectric) <- householdElectric[1,]

  householdElectric <- householdElectric[2:2075260,] %>%  
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(datetime = paste(Date, Time, sep = " ")) %>%
    mutate(datetime = strptime(datetime, "%d/%m/%Y %H:%M:%S")) 

  png2 <- png("png2.png")
  plot(householdElectric$datetime, as.numeric(householdElectric$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  dev.off()
}