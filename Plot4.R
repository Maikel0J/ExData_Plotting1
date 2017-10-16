###### BACKGROUND INFORMATION ######
### Author comment 
# Initial script by Maikel Jonkers (14-09-2017) as part of course 4 'Exploratory Data Analysis' of 'Data Science Specialization'
# created by John Hopkins University, offered by Coursera. This script is a elaboration of the Peer-graded Assignment of week 1 (plot 1
# of 4). There is no description added about the dataset or the process, because the assignment focusses on exploratory analysis. All the 
# conclusions or other elements are noted in the code as comments. 

###### FILE DESCRIPTION ######
### Input
# ATTENTION:    In the 'Initiation' the working directory is set! Here the file needs to be available. 
#               The code is made on a OS with Dutch time settings. The code corrects this, but this may be different for others. 
# Source:       https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1
# Dataset:      Electric power consumption [20Mb]
# Description:  Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
#               Different electrical quantities and some sub-metering values are available.

### Goal
# Make multiple graphs in one plot. From top to bottom, left to right:
# Plot 1: A linegraph of the Global active power with the weekday in the x axis.
# Plot 2: A linegraph of the Voltage.
# Plot 3: Make a linegraph of the three sub meterings with three colors, including a legend. 
# Plot 4: A linegraph of the Global reactive power.

### Output
# Plot4.png


###### CODE ######

#### Initiation
gc()                # Clear memory R
rm(list=ls())       # Clear data
# Set Working directory
Oldwd <- getwd()
wd <- 'D:/NoBackup/R/ExData_Plotting1-master'
setwd(wd)
# Variable for filename
filename <- 'household_power_consumption.txt'

### Read data
classes=c("character", "character", rep("numeric", 7))
header <- read.table(filename, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
df_plot <- read.table(filename, sep=';', header=FALSE, skip=66637, nrows=2881, colClasses = classes)
colnames(df_plot) <- unlist(header)

### Make graphics
# Add column with weekday to dataframe
df_plot$Datetotal <-strptime(paste(df_plot$Date, df_plot$Time), format="%d/%m/%Y %H:%M:%S")
Sys.setlocale("LC_TIME","English")
df_plot$weekday <- weekdays(df_plot$Datetotal, abbreviate=TRUE)
Sys.setlocale("LC_TIME","Dutch_Netherlands.1252")

# get default graphic settings
defaultpar <- par(no.readonly = TRUE) 

# Set margings
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

#make plot
plot(df_plot$Global_active_power,type = "S", ylab = "Global active power", xlab="", xaxt='n') 
axis(side=1, at=c(0,1441,2881), labels=unique(df_plot$weekday))

plot(df_plot$Voltage,type = "S", ylab = "Voltage",xlab="datetime", xaxt='n') 
axis(side=1, at=c(0,1441,2881), labels=unique(df_plot$weekday))

plot(df_plot$Sub_metering_1,type = "S", ylab = "Energy sub metering", xlab="", xaxt='n') 
lines(df_plot$Sub_metering_2, col="red")
lines(df_plot$Sub_metering_3, col="blue")
axis(side=1, at=c(0,1441,2881), labels=unique(df_plot$weekday))
legend("topright",
       lty=1,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.7,
       bty='n')

plot(df_plot$Global_reactive_power, type= "S", ylab = "Global_reactive_power", xlab="datetime", xaxt='n') 
axis(side=1, at=c(0,1441,2881), labels=unique(df_plot$weekday))

# Write plot
dev.copy(png,'Plot4.png')
dev.off()

# reset to default graphic settings
par(defaultpar)    

### Set old working directory
setwd(Oldwd)