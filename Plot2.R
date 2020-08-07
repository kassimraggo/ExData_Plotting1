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

## check and set up the margin
par("mar")
par(mar=c(4,4,4,4))

## create plot
with(comb,{plot(comb$dateTime,comb$Global_active_power, type="l",
                xlab = " ",
                ylab="Global Active Power(kilowatts)")})

## save to the file 
dev.copy(png,"plot2.png",width=480, height=480)
dev.off()