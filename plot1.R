#Read and prepare the data for all plots
powerdata<-read.table("data/household_power_consumption.txt",sep=";",colClasses="character",header=T)
powerdata$date<-as.Date(powerdata$Date,"%d/%m/%Y")
enddate<-as.Date("2007-02-02");data1<-powerdata[powerdata$date<=enddate,]
startdate<-as.Date("2007-02-01");data2<-data1[data1$date>=startdate,]
dim(data2) # 2880 by 10. at this point, we have all the rows needed for graphing in dataframe "data2"
data2$gap<-as.numeric(data2$Global_active_power)
x<-paste(data2$Date,data2$Time)
data2$datetime<-strptime(x,"%d/%m/%Y %H:%M:%S")
data2$sm1<-as.integer(data2$Sub_metering_1)
data2$sm2<-as.integer(data2$Sub_metering_2)
data2$sm3<-as.integer(data2$Sub_metering_3)
data2$volts<-as.numeric(data2$Voltage) #nothing coerced to NA
data2$grp<-as.numeric(data2$Global_reactive_power)
plotdata<-data2

#plot 1 code
png(filename="data/plot1.png")
hist(plotdata$gap, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()