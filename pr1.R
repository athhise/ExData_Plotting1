#################################################################################
#
#        Exploratory data Analysis. Programming assignment No 1.
#
#################################################################################

# Estimate the memory require 
size<-object.size(data<-read.table(file="household_power_consumption.txt", header=FALSE,sep=";",na.strings="?",skip=66637, nrows=(69517-66637)))
print(size,units="Mb")


# Load the appropiate data set only. Data among ligne 69517 to 66637 

data<-read.table(file="household_power_consumption.txt", header=FALSE,sep=";",na.strings="?",skip=66637, nrows=(69517-66637), colClasses="character")
colnames(data)<-read.table(file="household_power_consumption.txt", header=FALSE,sep=";",skip=0,nrows=1, colClasses="character")

# convert the fist 2 variable to date and time format, and the others variable as numeric

data[,-c(1,2)]<-lapply(data[,-c(1,2)],as.numeric)
data$DATE<-paste(data$Date, data$Time)
data$DATE<-strptime(data$DATE, "%d/%m/%Y %H:%M:%S" )

# Make the plot
names(data)

  # plot 1
  
png("plot1.png", width=480, height=480, units="px")
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", col="Red", main= "Global Active Power")
dev.off()

  # plot 2
data$day<-as.factor(weekdays(data$DATE))

png("plot2.png", width=480, height=480, units="px")  
with(data,plot(DATE, Global_active_power,type="l", ylab="Global Active Power (kilowatts)"))
dev.off()


  # plot 3

png("plot3.png", width=480, height=480, units="px")  
with(data,{
  plot(DATE, Sub_metering_1, type="l",col="Black", ylab="Energy sub metering")
  points(DATE, Sub_metering_2, type="l",col="Red", ylab="Energy sub metering")
  points(DATE, Sub_metering_3, type="l",col="Blue", ylab="Energy sub metering")
})
legend("topright", pch="l", col=c("Black", "Red", "Blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

  # plot 4
data$day<-as.factor(weekdays(data$DATE))
png("plot4.png", width=480, height=480, units="px") 

par(mfrow=c(2,2))
with(data,{
 plot(DATE, Global_active_power,type="l", ylab="Global Active Power (kilowatts)")
 plot(DATE, Voltage,type="l")
})

with(data, {
  plot(DATE, Sub_metering_1, type="l",col="Black", ylab="Energy sub metering")
    points(DATE, Sub_metering_2, type="l",col="Red", ylab="Energy sub metering")
    points(DATE, Sub_metering_3, type="l",col="Blue", ylab="Energy sub metering")
    legend("topright", pch="l", col=c("Black", "Red", "Blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
})

with(data, plot(DATE, Global_reactive_power,type="l"))

dev.off()


