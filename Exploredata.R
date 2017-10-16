###### BACKGROUND INFORMATION ######
### Author comment 
# Initial script by Maikel Jonkers (14-09-2017) as part of course 4 'Exploratory Data Analysis' of 'Data Science Specialization'
# created by John Hopkins University, offered by Coursera. This script is a elaboration of the Peer-graded Assignment of week 1 (explore data set 
# before working on plots. There is no description added about the dataset or the process, because the assignment focusses on exploratory analysis. 
# All the conclusions or other elements are noted in the code as comments. 

###### FILE DESCRIPTION ######
### Input
# ATTENTION:    In the 'Initiation' the working directory is set! Here the file needs to be available. 
# Source:       https://www.coursera.org/learn/exploratory-data-analysis/peer/ylVFo/course-project-1
# Dataset:      Electric power consumption [20Mb]
# Description:  Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
#               Different electrical quantities and some sub-metering values are available.

### Goal
# Explore dataset to determine memory needed, number of rows to read, etc. 

### Output
# Eventually to get a short code to read the right dataset. 


###### CODE ######

#### Initiation
gc()                # Clear memory R
rm(list=ls())       # Clear data
# Set Working directory
Oldwd <- getwd()
wd <- 'D:/NoBackup/R/ExData_Plotting1-master'
setwd(wd)
# Load packages for this assignment
library(pryr) # to use function 'object_size'
# Variable for filename
filename <- 'household_power_consumption.txt'

### Exploratory analysis of dataset before loading
# Determine memory needed to load data
object_size(2075259:9) # (rows:colums) memory needed to load data -> 8.3 MB
# Explore data before reading data to determine subset and class
classes=c("character", "character", rep("numeric", 7))
df_test <- read.table(filename, sep=';', header=TRUE, nrows=10, colClasses = classes)
# First date = 16-12-2006
# First time 17:24
df_test$Datetotal <-strptime(paste(df_test$Date, df_test$Time), format="%d/%m/%Y %H:%M:%S")
# Calculate number of rows to skip and number of rows to read
Startdate = as.POSIXlt('2007-02-01T00:00:00.000',format="%Y-%m-%dT%H:%M:%S")
Firstdate <- df_test[1,10]
NoSkip <- difftime(Startdate, df_test[1,10], units = "mins")+1
NoRows <- 2*24*60+1 # two days, 24 hours, 60 minutes per hour
# Read right dataset from file
header <- read.table(filename, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
df_plot <- read.table(filename, sep=';', header=FALSE, skip=NoSkip, nrows=NoRows, colClasses = classes)
colnames(df_plot) <- unlist(header)
NoSkip

### Code for plotting scripts:
classes=c("character", "character", rep("numeric", 7))
header <- read.table(filename, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
df_plot <- read.table(filename, sep=';', header=FALSE, skip=66637, nrows=2881, colClasses = classes)
colnames(df_plot) <- unlist(header)

### Set old working directory
setwd(Oldwd)