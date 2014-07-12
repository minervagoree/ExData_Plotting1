#Download Data for Coursera's Exploratory Data Project 1.  The data is a huge file
#that can be found at https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip


myURL<- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(myURL,"./householdPowerConsumption.zip")
unzip("./householdPowerConsumption.zip")
Unlink(myURL)

date_downloaded <- date()
date_downloaded # [1] "Sat Jul 12 11:19:58 2014"

#read data into R
powCon <- fread("./household_power_consumption.txt", sep=";",header=TRUE, na.strings="?")
powCon <- na.omit(powCon)
powConDate <- as.Date(as.character(powConDate),"%d/%m/%Y")
powTestSet <- subset(powCon,powConDate>=as.Date("2007/02/01") & powConDate<=as.Date("2007/02/02"))
head(powTestSet)
tail(powTestSet)
powGAP <- (powTestSet$Global_active_power)




#plot1
png(file ="Plot1.png")
hist(powGAP, col= "red", main = "Global Active Power",xlab="Global Active Power (kilowatts)")
with(powTestSet,hist(powGAP, col= "red", main = "Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off() #close the PNG device


#plot2
Sys.setlocale('LC_TIME','C')
powConDate <- (powTestSet$Date)
head(powConDate)
powConTime <- (powTestSet$Time)
head(powConTime)
powDateTime <- paste(powConDate,powConTime)
head(powDateTime)
powDateTime <- strptime(powDateTime, "%d/ %m/ %Y %H: %M: %S")
head(powDateTime)
#powDays <- weekdays(powDateTime, abbreviate=TRUE) ## didn't use it but did give right day of week
#plot(powDateTime,powGAP)  ## works but used with instead
#with(powTestSet,plot(powDateTime,PowGAP)) ## testing if plot worked.  yes it worked!
with(powTestSet,plot(powDateTime,powGAP,type="l",xlab="", ylab="Global Active Power (kilowatts)", main="Global Active Power by Day between 2/1/07 and 2/2/07"))
#       #Now to send a PNG file to my local directory
png(file ="Plot2.png")
with(powTestSet,plot(powDateTime,powGAP,type="l",xlab="", ylab="Global Active Power (kilowatts)", main="Global Active Power by Day between 2/1/07 and 2/2/07"))
dev.off() #close the PNG device


#temp
> con ="./household_power_consumption.txt"
> powCon <- read.table(con, sep=";",header=TRUE, na.strings="?")
 #      #or faster but I need to practice how to use it
> powCon <- fread(con, sep=";",header=TRUE, na.strings="?")

Sys.setlocale('LC_TIME','C')
powDateTime <- paste(powConDate,powConTime)


#clear console
cat("\014") 
