##EDA Project 1
##Plot 2
library(data.table)

## Loading the data
DT<-fread("household_power_consumption.txt",";", header=TRUE, colClasses=c(Date="character",Time="character",Global_active_power="numeric",Global_reactive_power="numeric",Voltage="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric"), na.strings=c("?"))

filtered<-subset(DT,DT[,Date] %in% c("1/2/2007","2/2/2007")) ## Subset of two days

## Conversion of classes
filtered$Date<-as.Date(filtered$Date, "%d/%m/%Y")
filtered$Global_active_power<-as.numeric(filtered$Global_active_power)

datetime<-paste(filtered$Date, filtered$Time) ## Combining date and time
dates<- strptime(as.character(datetime), format="%Y-%m-%d %H:%M:%S") ## Converting to POSIXct

filtered<-data.frame(Timestamp=dates,filtered) ##merging data sets to incoporate the timestamp

rm(datetime) ## Clearing memory
rm(dates) ## Clearing memory

png(filename="plot2.png")
plot(filtered$Timestamp,filtered$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()