library(datasets)
#Make sure the household power consumption data is in your working directory before running this script
##download a subsection of the data (up to the first date we want plus 20000 rows)
#set column names
columnNames <- c("Date","Time","Global_active_power","Global_reactive_power",
                 "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#set column classes
columnClasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
#read in table
HPC <- read.table(file="household_power_consumption.txt", col.names=columnNames, sep=";", colClasses = columnClasses, skip=1, na.strings = "?")

#Convert Date and Time columns to dates in a combines DateTime column
HPC$DateTime <- strptime(paste(HPC$Date, HPC$Time), format="%d/%m/%Y %H:%M:%S")

#filter out the dates we want
HPC_Feb <- subset(HPC, DateTime>="2007-02-01" & DateTime<"2007-02-03")

#Plot3
#setup empty plut
plot(HPC_Feb$DateTime, HPC_Feb$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
with(HPC_Feb, lines(DateTime,Sub_metering_1, col="gray50")) #add first line
with(HPC_Feb, lines(DateTime,Sub_metering_2, col="red")) #add second line
with(HPC_Feb, lines(DateTime,Sub_metering_3, col="blue")) #add third line
#create legend
legend("topright", lty=1, col=c("gray50","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#save as plot3.png
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
