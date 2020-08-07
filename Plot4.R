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

## plot the graph and add the legend box
par(mfrow = c(2, 2),mar = c(4,4,1,1))
with(comb,{plot(comb$Global_active_power~comb$dateTime, type="l",
                xlab = " ", cex.lab=0.7,cex.axis=1, 
                ylab="Global Active Power ")
  plot(comb$dateTime,comb$Voltage,xlab="datetime",type="l",
       ylab="Voltage",cex.lab=0.7,cex.axis=0.6)
  plot(comb$dateTime,comb$Sub_metering_1,type="l",cex.lab=0.7,
       xlab = " ",ylab="Energy sub metering",cex.axis=0.7)
  lines(comb$dateTime,comb$Sub_metering_2,col='Red')
  lines(comb$dateTime,comb$Sub_metering_3,col='Blue')
  legend("topright",lty=1, lwd=1, bty="n",cex=0.4,col = c("black","red","blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  plot(comb$dateTime,comb$Global_reactive_power,xlab="datetime ",
       ylab="Global Rective Power",cex.lab=0.7,type="l",cex.axis=0.4)
})


## save to the file
dev.copy(png,"plot4.png",width=480, height=480)
dev.off()