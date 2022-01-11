getwd()
setwd("C:/Users/casti/OneDrive/Desktop/2ndminiproject/Plots/specdata")

# reads and access the household power consumption data file
plot_data<-read.table("./household_power_consumption_data/household_power_consumption.txt",sep=";",header=TRUE, na.strings="?")

# changes the format of the date
plot_data$Date<-as.Date(plot_data$Date, format="%d/%m/%Y")

# limits the data to the specific date
plot_data<-plot_data[plot_data$Date=="2007-02-02"|plot_data$Date=="2007-02-01",]

# changed the format of the time to date with the time
plot_data$Time<-paste(plot_data$Date,plot_data$Time,sep=" ")

plot_data$Time<-strptime(plot_data$Time, format="%Y-%m-%d %H:%M:%S")

#plot1

#plots the specific data needed
plot_data$Global_active_power<-as.numeric(plot_data$Global_active_power)

plot_data$Global_active_power<-as.numeric(plot_data$Global_active_power*2/1000)

#makes histogram for the given dataset
hist(plot_data$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",main= "Global Active Power",col="red")

#saves the plot
dev.copy(png,'plot1.png')
#clears the field
dev.off() 


#plot2

#accessed the data and makes graph for the data
plot(plot_data$Time,plot_data$Global_active_power,ylab="Global Active Power (kilowatts)",xlab=" ",type="l")

dev.copy(png,'plot2.png')
dev.off()

#plot3
plot_data$Sub_metering_1<-as.numeric(plot_data$Sub_metering_1)

plot_data$Sub_metering_2<-as.numeric(plot_data$Sub_metering_2)

plot_data$Sub_metering_3<-as.numeric(plot_data$Sub_metering_3)

plot(plot_data$Time,plot_data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" ",col="black")

lines(plot_data$Time,plot_data$Sub_metering_2,type="l",col="red")

lines(plot_data$Time,plot_data$Sub_metering_3,type="l",col="blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

dev.copy(png,'plot3.png')

dev.off()

#plot4

par(mfcol=c(2,2))

##top left plot
plot(plot_data$Time,plot_data$Global_active_power,ylab="Global Active Power (kilowatts)",xlab=" ",type="l")

##bottom left plot
plot(plot_data$Time, plot_data$Sub_metering_1, type="l", xlab = " ", ylab = "Energy sub metering")
lines(plot_data$Time, plot_data$Sub_metering_2, type="l", col = "red")
lines(plot_data$Time, plot_data$Sub_metering_3, type="l", col = "blue")
legend("topright", legend = c(names(plot_data)[7:9]), col = c("black", "red", "blue"), lty=1, cex=0.8, bty = "n")

##top right plot
plot(plot_data$Time, plot_data$Voltage, type="l", xlab = "Time", ylab = "Voltage")

##bottom right plot
plot(plot_data$Time, plot_data$Global_reactive_power, type="l", xlab = "Time", ylab = "Global_reactive_power")


dev.copy(png,'plot4.png')

dev.off()
