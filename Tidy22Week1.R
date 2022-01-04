## ---------------------------
##
## Script name: TidyTuesday 2022-01-04 (Week 1)
##
## Author: Rachel Roday
##
## Date Created: 2022-01-04
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: Basic code already created. Most time spent 
##        in excel processing data from iPhone notes app
##        
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday/2022")

#Load libraries
library(ggplot2)
library(readr)
library(chron)
library(tidyquant)
library(plyr)
source("https://raw.githubusercontent.com/iascchen/VisHealth/master/R/calendarHeat.R")

#Call in data
DF<-as.data.frame(read.csv("Data2022.csv"))

#Parse dates into new column
DF$Day<-parse_date(DF$Date,"%m/%d/%Y")
#Parse date into day of the week (weekday)
DF$Weekday = as.POSIXlt(DF$Day)$wday
#Label weekday as specific name
DF$Weekdayf<-factor(DF$Weekday,levels=rev(1:7),labels=rev(c("Mon","Tue","Wed","Thu","Fri","Sat","Sun")),ordered=TRUE)
#Add month of the year as new column
DF$monthf<-factor(month(DF$Day),levels=as.character(1:12),labels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"),ordered=TRUE)
#Join month and year in new column
DF$yearmonth<- factor(as.yearmon(DF$Day))
#Add number of week in the year as new column
DF$Week <- as.numeric(format(DF$Day,"%W"))
#Add number of week in the month as new colmn
DF<-ddply(DF,.(yearmonth),transform,monthweek=1+Week-min(Week)) 
#Replace unexplained "NA" in Weekdayf column with Sunday
DF$Weekdayf[is.na(DF$Weekdayf)] <- "Sun"
#Remove question marks
DF$Count<-as.numeric(DF$Count)
#Remove first column
DF<-DF[,-1]
#Remove any NA
DF<-na.omit(DF)


#Create color palette
r2g <- c("#D61818", "#FFAE63", "#FFFFBD", "#B5E384")

#Create clendar heatmap
calendarHeat(dates=DF$Day, values=DF$Count, ncolors = 11, color = "r2g",varname = "Values", date.form = "m%/d%/Y%")

