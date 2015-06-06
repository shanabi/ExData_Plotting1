### Exploratory Data Analaysis exdata-015

### Project 1 - part 4

### Dataset - Electric power consumption 
### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
### Only using date Feb 1, 2007 and Feb 2, 2007 per assignment.
### In this dataset, those are in Date field as 1/2/2007 and 2/2/2007 

### Plot multi char 2 x 2 with
### line chart of Global Active Power vs the date/time
### line chart of Voltage vs the date/time
### line chart of Energy sub metering 1, 2, 3 vs the date/time
### line chart of Global reactive power vs the date/time

### Use sqldf package
require(sqldf)

### line chart of Global Active Power vs the date/time
sub1 <- function(hpc) {

    ## Create line plot (type="l")
    plot(x=hpc$datetime,y=hpc$Global_active_power,xlab="",ylab="Global Active Power",type="l")    

}

### line chart of Voltage vs the date/time
sub2 <- function(hpc) {
    plot(x=hpc$datetime,y=hpc$Voltage,xlab="datetime",ylab="Voltage",type="l")    

}

### line chart of Energy sub metering 1, 2, 3 vs the date/time
sub3 <- function(hpc) {

    ## create line multiplot for each of the Sub_metering vars
    with(hpc, {
        plot(x=datetime,y=Sub_metering_1,xlab="",ylab="Energy sub metering",type="l", col="black")
        lines(x=datetime,y=Sub_metering_2, col="red")
        lines(x=datetime,y=Sub_metering_3, col="blue")
    })

    ## Give it a legend, parameter "lty=1" means use solid line, 2 is dashed and so on.
    ## No boundary around legend this time
    legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1",
                            "Sub_metering_2", "Sub_metering_3"))

    
}

### line chart of Global reactive power vs the date/time
sub4 <- function(hpc) {
    plot(x=hpc$datetime,y=hpc$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",
         type="l")    
}


### Main function, 
plot4 <- function() {

    ## read in data - use sqldf package so can subset on the read (although behind the scenes
    ## the sqldf package does do more)
    hpc <- read.csv2.sql("household_power_consumption.txt", header=TRUE, na.strings="?", sql = "select * from file where Date in ('1/2/2007','2/2/2007')")

    ## Create new datetime column with from the separate date and time columns
    hpc$datetime <- with(hpc, as.POSIXlt(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))
    
    ## Setup graphics device - using defaults
    ## (even 480x480 pixels is default but i like to specify some things)
    ## My getoption("bitmapType") shows cairo 
    png(filename = "plot4.png",
        width = 480, height = 480, units = "px",
        bg = "white")

    ## Setup so have 2 by 2 plots, order by rows
    par(mfrow=c(2,2))
    sub1(hpc)
    sub2(hpc)
    sub3(hpc)
    sub4(hpc)
    
    
    ## Close the graphics device
    dev.off()

}
