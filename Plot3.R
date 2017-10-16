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
# Make a linegraph of the three sub meterings with three colors, including a legend. 

### Output
# Plot3.png


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

# Make plot
plot(df_plot$Sub_metering_1,type = "S", ylab = "Energy sub metering", xaxt='n') 
lines(df_plot$Sub_metering_2, col="red")
lines(df_plot$Sub_metering_3, col="blue")
axis(side=1, at=c(0,1441,2881), labels=unique(df_plot$weekday))
legend("topright",
       lty=1,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.8)

# Write plot
dev.copy(png,'Plot3.png')
dev.off()

### Set old working directory
setwd(Oldwd)
