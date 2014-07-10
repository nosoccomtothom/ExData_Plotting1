##EDA Project 1
##Plot 3
library(data.table)

## Loading the data
DT<-fread("household_power_consumption.txt",";", header=TRUE, colClasses=c(Date="character",Time="character",Global_active_power="numeric",Global_reactive_power="numeric",Voltage="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric"), na.strings=c("?"))

filtered<-subset(DT,DT[,Date] %in% c("1/2/2007","2/2/2007")) ## Subset of two days

## Conversion of classes
filtered$Date<-as.Date(filtered$Date, "%d/%m/%Y")
filtered$Global_active_power<-as.numeric(filtered$Global_active_power)
filtered$Sub_metering_1<-as.numeric(filtered$Sub_metering_1)
filtered$Sub_metering_2<-as.numeric(filtered$Sub_metering_2)
filtered$Sub_metering_3<-as.numeric(filtered$Sub_metering_3)
filtered$Voltage<-as.numeric(filtered$Voltage)
filtered$Global_reactive_power<-as.numeric(filtered$Global_reactive_power)


datetime<-paste(filtered$Date, filtered$Time) ## Combining date and time
dates<- strptime(as.character(datetime), format="%Y-%m-%d %H:%M:%S") ## Converting to POSIXct

filtered<-data.frame(Timestamp=dates,filtered) ##merging data sets to incoporate the timestamp

rm(datetime) ## Clearing memory
rm(dates) ## Clearing memory

png(filename="plot4.png") ## PNG device

par(mfrow=c(2,2)) ## Four graphs

## Plot 1
plot(filtered$Timestamp,filtered$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Plot 2
plot(filtered$Timestamp,filtered$Voltage, type="l", xlab="datetime", ylab="Voltage")

## Plot 3
plot(filtered$Timestamp,filtered$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(filtered$Timestamp,filtered$Sub_metering_2, type="l", col="red")
lines(filtered$Timestamp,filtered$Sub_metering_3, type="l", col="blue")
legend("topright", bty = "n", pch = NA, lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Plot 4
plot(filtered$Timestamp,filtered$Global_reactive_power, type="l", xlab="datetime", ylab="Global_rective_power")

dev.off()