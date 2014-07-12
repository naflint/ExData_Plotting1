setInternet2(use = TRUE)


if (!file.exists("data")) {
  dir.create("data")
}

#download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl,destfile = "./data/temp", method = "auto")
hpc <- read.csv(unz("./data/temp", "household_power_consumption.txt"), sep=";", as.is = TRUE, na.strings = "?")
unlink(temp)


#select date range
#test <- as.Date(hpc[24,1], "%d/%m/%Y")
hpc1 <- hpc[which(hpc[,1]=="1/2/2007"),]
hpc2 <- hpc[which(hpc[,1]=="2/2/2007"),]
hpc3 <- rbind(hpc1,hpc2)

#convert time format
hpc5 <- strptime(paste(hpc3[,1],hpc3[,2],sep=" "), "%d/%m/%Y%H:%M:%S")
hpc6 <- cbind(hpc5,hpc3[,3:9])
names(hpc6)[1] <- "time"

#draw chart

#plot 4
png(file = "plot4.png")
par(mfrow = c(2, 2))
with(hpc6, {
  #plot 4a
  plot(hpc6[,"time"],hpc6[,"Global_active_power"], ylab = "Global Active Power", xlab = "",type = "n")
  lines(hpc6[,"time"],hpc6[,"Global_active_power"])
  #plot 4b  
  plot(hpc6[,"time"],hpc6[,"Voltage"], ylab = "Voltage", xlab = "datetime",type = "n")
  lines(hpc6[,"time"],hpc6[,"Voltage"])
  #plot 4c  
  plot(hpc6[,"time"],hpc6[,"Sub_metering_1"], ylab = "Energy sub metering", xlab = "",type = "n")
  lines(hpc6[,"time"],hpc6[,"Sub_metering_1"], col = "black")
  lines(hpc6[,"time"],hpc6[,"Sub_metering_2"], col = "red")
  lines(hpc6[,"time"],hpc6[,"Sub_metering_3"], col = "blue")
  legend(x = "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
  col = c("black", "red", "blue"), lty = c(1, 1, 1), cex = 0.8, bty = "n")
  #plot 4d
  plot(hpc6[,"time"],hpc6[,"Global_reactive_power"], ylab = "Global_reactive_power", xlab = "datetime",type = "n")
  lines(hpc6[,"time"],hpc6[,"Global_reactive_power"])  
})
dev.off()
