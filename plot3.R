
#check for dir, and create if needed
if(!file.exists("data")){
  dir.create("data")
}

#download data if needed
if(!file.exists("data/household_power_consumption.zip")){
  download.file("http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", 
                destfile = "data/household_power_consumption.zip")
  
  unzip("data/household_power_consumption.zip", overwrite = TRUE, exdir = "data")
}

#read the data 
power <- read.csv2("data/household_power_consumption.txt", sep = ";")

#subset to just the days we care about
powerDays <- subset(power, Date ==  "1/2/2007"| Date == "2/2/2007")

#set the png device
png(file="plot3.png", bg="white", width = 480, height = 480)

metering1 <- as.numeric(levels(powerDays$Sub_metering_1))[powerDays$Sub_metering_1]
metering2 <- as.numeric(levels(powerDays$Sub_metering_2))[powerDays$Sub_metering_2]
metering3 <- as.numeric(levels(powerDays$Sub_metering_3))[powerDays$Sub_metering_3]

plot(metering1, type="n", xaxt='n', main = "",  xlab ="", ylab = "Energy Sub Metering")

points(metering1, type="o", col = "black", pch=NA)
points(metering2, type="o", col = "red", pch=NA)
points(metering3, type="o", col = "blue", pch=NA)

lsize <- length(powerDays$Global_active_power)
axis(1, at=0,labels="Thu", col.axis="black", las=0)
axis(1, at=lsize/2,labels="Fri", col.axis="black", las=0)
axis(1, at=lsize,labels="Sat", col.axis="black", las=0)

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       pch = c("_"), col=c("black","red","blue"))

dev.off()

