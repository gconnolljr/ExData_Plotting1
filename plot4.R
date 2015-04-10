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

#plot 4 code
png(filename="data/plot4.png")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))
#topleft is plot 2
plot(plotdata$datetime, plotdata$gap, type="n",ylab="Global Active Power",xlab="")
lines(plotdata$datetime, plotdata$gap,type="l")
#topright is voltage plot
plot(plotdata$datetime,plotdata$volts,type="n",ylab="Voltage",xlab="datetime")
lines(plotdata$datetime,plotdata$volts, type="l")
#bottom left is plot 3
plot(plotdata$datetime, plotdata$sm1,type="n",ylab="Energy sub metering",xlab="")
lines(plotdata$datetime, plotdata$sm1,type="l")
lines(plotdata$datetime, plotdata$sm2,type="l",col="red")
lines(plotdata$datetime, plotdata$sm3,type="l",col="blue")
legend("topright", col=c("black","red","blue"),legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))
#bottom right is new GRP plot
plot(plotdata$datetime,plotdata$grp,type="n",ylab="Global_reactive_power",xlab="datetime");lines(plotdata$datetime,plotdata$grp, type="l")
dev.off()