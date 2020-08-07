file2 <- read.table("household_power_consumption.txt", 
                    header=TRUE, sep=";", na.strings = "?")
##check file
names(file2)

## convert the Date and Time variables to Date/Time classes 
file2$Date <- as.Date(file2$Date,"%d/%m/%Y")

## extract the specific time period from 2007-02-01 to 2007-02-02
sub <- subset(file2,Date >= as.Date("2007-02-01") & 
                Date <= as.Date("2007-02-02"))

## combine the date and time 
dateTime <- paste(sub$Date,sub$Time)
dateTime <- as.POSIXct(dateTime)
comb <- cbind(sub,dateTime)

## check and set up the appropriate margin 
par("mar")
par(mar=c(2,4,1,0.8))

## plot the graph and add the legend box
with(comb,{plot(comb$dateTime,comb$Sub_metering_1,type="l",
                xlab = " ",ylab="Energy sub metering")
  lines(comb$dateTime,comb$Sub_metering_2,col='Red')
  lines(comb$dateTime,comb$Sub_metering_3,col='Blue')
})
legend("topright",lty=1,lwd=1, cex=0.6,col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

## save to the file
dev.copy(png,"plot3.png",width=480, height=480)
dev.off()