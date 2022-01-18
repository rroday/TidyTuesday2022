## ---------------------------
##
## Script name: Tidy2022Week3
##
## Author: Rachel Roday
##
## Date Created: 2022-01-17
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: New laptop, all packages needed to be re installed
##        Time to code: 55 minutes
##        
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday")

#Load necessary packages
library(tidytuesdayR)
library(ggplot2)

#Go! Get! Your! Data!
tuesdata <- tidytuesdayR::tt_load('2022-01-18')
chocolate <- tuesdata$chocolate

#Get rid of that pesky "%" sign and turn column into numeric
chocolate$cocoa_percent <- as.character(chocolate$cocoa_percent)
chocolate$cocoa_percent<-gsub("%", "", chocolate$cocoa_percent)
chocolate$cocoa_percent<- as.numeric(chocolate$cocoa_percent)

#Plot that graph
ggplot(data=chocolate, aes(x=cocoa_percent, y=rating))+
  geom_point(color= "#5b2e1b")+
  scale_y_continuous(limits=c(0,5), name="Rating")+
  stat_smooth( fill="#29533c", colour="#29533c", 
              size=1, alpha = 0.2)+
  labs(
    x="Percent Cocoa",
    title= "Chocolate Ratings",
    subtitle = "How much cocoa is ideal?",
    caption= "Source: Flavors of Cacao | Data Viz: @Rachel_Roday")+
  theme(
    panel.background = element_rect(fill="#a4825d"),
    plot.background = element_rect(fill = "#a4825d"),
    panel.grid.major = element_line(color="#d1bf9d"),
    panel.grid.minor = element_blank(),
    axis.title = element_text(color="#5b2e1b"),
    axis.text =  element_text(color="#5b2e1b"),
    axis.ticks = element_blank(),
    axis.text.x = element_text(vjust=0.5),
    plot.caption = element_text(color="#d1bf9d"),
    plot.title = element_text(color="#5b2e1b", face = "bold", hjust=.5),
    plot.subtitle = element_text(color="#5b2e1b",hjust=.5)
  )

