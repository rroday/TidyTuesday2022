## ---------------------------
##
## Script name: Tidy22Week2
##
## Author: Rachel Roday
##
## Date Created: 2022-01-10
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: 185 minutes to complete
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday/2022")

#Load libraries
library(ggplot2)
library(tidytuesdayR)
library(dplyr)
library(stringr)
library(png)

#Get Data
tuesdata <- tidytuesdayR::tt_load('2022-01-11')
colony <- tuesdata$colony
stressor <- tuesdata$stressor

#Make title and subtitle as strings
bee_title <- "'According to all known laws of aviation, there is no way that a bee should be able to fly'"
bee_subtitle <- "Average percentage of bee colonies renovated (a colony that was requeened or received a nuc or package) annually in the United States between 2015 to 2021."

#Save image. Choose 'barry' file when prompted
filename <- file.choose()
img<-readPNG(filename)

#Make plot
colony %>%
  filter(year %in% c(2015,2016,2017,2018,2019,2020,2021) & state != 'United States')%>%
  group_by(year) %>%
  #Finding average of colonies renovated by year, across states
  summarize(Avg = mean(colony_reno_pct, na.rm = TRUE)) %>%
  #ggplot
  ggplot(aes(x=year, y=Avg))+
  geom_col(aes(color="#E1AC35", fill= "#E1AC35"), width = .4)+
  scale_color_identity(aesthetics =  c("fill", "color"))+
  labs(title = str_wrap(bee_title, 60), 
       subtitle = str_wrap(bee_subtitle, 70),
       caption = "Data source: USDA | Data viz: @rachel_roday",
       x= '',
       y='')+
  theme(text = element_text(),
        panel.background = element_rect(fill = "#F3EBD4",
                                        colour = "#F3EBD4"),
        panel.grid.minor = element_blank(), 
        panel.grid.major.y = element_line(colour= "#E4B284"),
        panel.grid.major.x = element_blank(),
        panel.border = element_blank(),
        plot.background = element_rect(fill = "#F3EBD4"),
        legend.position="bottom",
        plot.caption = element_text(face = "italic", 
                                    color= "#E4B284"),
        axis.text = element_text(color= "#45211D"),
        plot.title=element_text(face="bold", size=15, 
                                color= "#45211D"),
        plot.subtitle = element_text(vjust = 2, size = 12, 
                                     color= "#45211D"),
        axis.title = element_text(color="#45211D", face="bold"),
        axis.ticks = element_blank(),
        legend.title = element_blank(),
        legend.background = element_rect(fill = "#F3EBD4"),
        legend.key = element_rect(fill = "#F3EBD4", color = NA))+
  scale_y_continuous(breaks = seq(0, 15, by = 2))+
  scale_x_continuous(breaks = seq(2015, 2021, by = 1))+
  annotation_raster(img, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf, interpolate = TRUE)

