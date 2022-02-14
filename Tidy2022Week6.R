##
## Date Created: 2022-02-08
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: an hour ish. +15 min for WEB DB aesthetics
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday")

#Load necessary packages
library(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(showtext)
library(geofacet)

## Loading Google fonts (https://fonts.google.com/)
##  font-family: 'Teko', sans-serif;
font_add_google("Teko", "teko")

## Automatically use showtext to render text
showtext_auto()

#Go! Get! Your! Data!
tuesdata <- tidytuesdayR::tt_load('2022-02-08')
airmen <- tuesdata$airmen

airmen %>%
  mutate(state = ifelse(state == 'Haiti', 'Other', state),
         state = ifelse(state == 'HT', 'Other', state),
         state = ifelse(state == 'CN', 'Other', state),
         state = ifelse(state == 'VI', 'Other', state),
         state = ifelse(state == 'KN', 'Other', state),
         state = ifelse(state == 'TD', 'Other', state),
         state = ifelse(state == 'Unk', 'Other', state),
         pilot_type = ifelse(pilot_type =="Liason pilot",'Liaison pilot', pilot_type)) %>%
  subset(state!='Other') %>%
ggplot(aes(x =pilot_type)) +
  geom_bar() +
  labs(x = "Pilot Type", 
       y= "Frequency", 
       title ="Types of US Pilots in the Tuskegee Airmen",
       caption = "Source: Commemorative Air Force| Viz: @rachel_roday") +
  facet_geo(~ state) +
  coord_flip()+
  theme(text = element_text(family="teko"),
                panel.background = element_rect(fill = "#e7ccb0",
                                                colour = "#e7ccb0"),
        strip.background =element_rect(fill="#e7ccb0"),
                panel.grid.major = element_line(colour="#dda58c"), 
                panel.grid.minor = element_blank(),
                plot.background = element_rect(fill = "#e7ccb0"),
                panel.border = element_rect(colour="black", fill=NA),
                legend.position="bottom",
                plot.title=element_text(size=25, hjust = .5),
                axis.ticks = element_blank(),
                legend.background = element_rect(fill = "#e7ccb0"),
                axis.text.x = element_text(size=8),
                axis.text.y = element_text(size=13, hjust=.5),
                axis.title = element_blank(),
                legend.key = element_rect(fill = "#e7ccb0", color = NA))
    
