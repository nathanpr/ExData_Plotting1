
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
png(file="plot1.png", bg="white", width = 480, height = 480)

#plot it
hist(as.numeric(levels(powerDays$Global_active_power))[powerDays$Global_active_power],
     xlab="Global Active Power (kilowatts)" , ylab = "Frequency", main="Global Active Power",
     col = "red")

dev.off()

