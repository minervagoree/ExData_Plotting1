#Author: Minerva Goree Date: 7/12/2014 Plot #4 - Four Different Plots in one Graph.
#Download Data for Coursera's Exploratory Data Project 1.  The data is a huge file
#that can be found at https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#First read the file into R
myURL<- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip" #assigns the web address to myURL
download.file(myURL,"./householdPowerConsumption.zip") #downloads the file into my local computer directory
unzip("./householdPowerConsumption.zip") #unzips the folder and creates a .txt file in my local computer directory
Unlink(myURL) #Close myURL connection
date_downloaded <- date() #assigns the current date to a variable
date_downloaded # [1] "Sat Jul 12 11:19:58 2014" 

#Now with the data in my local computer directory I can read data into R
#although this was slow, I opted to use table.read over using fread
powCon <- table.read("./household_power_consumption.txt", sep=";",header=TRUE, na.strings="?") 
powCon <- na.omit(powCon) #Make sure to omit all of the data that is NA
powConDate <- (powCon$Date) #creates a local variable that takes Date from our data
powConDate <- as.Date(as.character(powConDate),"%d/%m/%Y") #turns our date string into date format
#Extract a chunk of data between the dates 2/1/2007 and 2/2/2007 into a test set.
powTestSet <- subset(powCon,powConDate>=as.Date("2007/02/01") & powConDate<=as.Date("2007/02/02"))
head(powTestSet) #checks the first few lines to make sure the right data is being read
tail(powTestSet) #checks the last few lines to make sure the right dates are at the end of our data
Sys.setlocale('LC_TIME','C') # makes sure the computer is in the right timezone

#Variables prepared for plot creation
powGAP <- (powTestSet$Global_active_power) # Global Active Power
head(powConDate) #checks the right dates are being returned
powConTime <- (powTestSet$Time) # assigns a local variable for the Time column in our data
head(powConTime) # checks to make sure we are getting the right time
powDateTime <- paste(powConDate,powConTime) #combines the date and time columns into one
head(powDateTime) #checks to make sure the right date and time combination is being returned
powDateTime <- strptime(powDateTime, "%d/ %m/ %Y %H: %M: %S") # the date/time variable is set up in the correct date/time format
head(powDateTime) #checks to make sure we got the correct output
subMet1 <- (powTestSet$Sub_metering_1)# variable for plot creation Sub Metering 1
subMet2 <- (powTestSet$Sub_metering_2) # variable for plot creation Sub Metering 2
subMet3 <- (powTestSet$Sub_metering_3) # variable for plot creation Sub Metering 3
powGRP <- (powTestSet$Global_reactive_power)# variable for plot creation Global Reactive Power
powVoltage <- (powTestSet$Voltage) # variable for plot creation Voltage

#### PLOT 4 CREATION ##### on screen
#### Creates Plot 4 where we have four different plots in one Graph
attach(powTestSet)
par(mfrow=c(2,2)) #builds a graph area for a 2 rows of 2 graphs 
with(powTestSet,plot(powDateTime,powGAP,type="l",xlab="", ylab="Global Active Power")) #Plot 1
with(powTestSet,plot(powDateTime,powVoltage,type="l",xlab="", ylab="Voltage")) #Plot 2
with(powTestSet,plot(powDateTime,subMet1,type="l",xlab="", ylab="Energy sub metering")) #Plot3
with(powTestSet,lines(powDateTime,subMet2,type="l",col="red"))
with(powTestSet,lines(powDateTime,subMet3,type="l",col="blue"))
legend("topright", bty="n", lty=1, col=c("black","red", "blue"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(powTestSet,plot(powDateTime,powGRP,type="l",xlab="", ylab="Global_reactive_power")) #Plot 4


#### PLOT 4 CREATION ##### Print off a PNG copy in the local computer directory
#### Creates Plot 4 PNG file where we we have four different plots in one Graph
png(file ="Plot4.png")
attach(powTestSet)
par(mfrow=c(2,2)) #builds a graph area for a 2 rows of 2 graphs
with(powTestSet,plot(powDateTime,powGAP,type="l",xlab="", ylab="Global Active Power")) #Plot 1
with(powTestSet,plot(powDateTime,powVoltage,type="l",xlab="", ylab="Voltage")) #Plot 2
with(powTestSet,plot(powDateTime,subMet1,type="l",xlab="", ylab="Energy sub metering")) #Plot3
with(powTestSet,lines(powDateTime,subMet2,type="l",col="red"))
with(powTestSet,lines(powDateTime,subMet3,type="l",col="blue"))
legend("topright", bty="n", lty=1, col=c("black","red", "blue"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(powTestSet,plot(powDateTime,powGRP,type="l",xlab="", ylab="Global_reactive_power")) #Plot 4
dev.off() #close the PNG device