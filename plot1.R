### Exploratory Data Analaysis exdata-015

### Project 1 - part 1

### Dataset - Electric power consumption 
### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
### Only using date Feb 1, 2007 and Feb 2, 2007 per assignment.
### In this dataset, those are in Date field as 1/2/2007 and 2/2/2007 

### Plot histogram of Global Active Power to match 

### Use sqldf package
require(sqldf)

plot1 <- function() {

    ## read in data - use sqldf package so can subset on the read (although behind the scenes
    ## the sqldf package does do more
    hpc <- read.csv2.sql("household_power_consumption.txt", header=TRUE, na.strings="?", sql = "select * from file where Date in ('1/2/2007','2/2/2007')")

    ## Setup graphics device - using defaults
    ## (even 480x480 pixels is default but i like t specify some things just for anality)
    ## My getoption("bitmapType") shows cairo 
    png(filename = "plot1.png",
        width = 480, height = 480, units = "px",
        bg = "white")

    ## Create histogram
    hist(hpc$Global_active_power,main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

    ## Close the graphics device
    dev.off()

}
