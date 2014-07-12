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
#plot 1
png(file = "plot1.png")
hist(hpc6[,"Global_active_power"],main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()
