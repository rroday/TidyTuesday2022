##
## Date Created: 2022-02-08
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: an hour ish. I dont like this graph.
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday")

#Load necessary packages
library(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(showtext)
library(geofacet)
library(cowplot)

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
         state = ifelse(state == 'Unk', 'Other', state)) %>%
  subset(state!='Other') %>%
ggplot(aes(x =pilot_type)) +
  geom_bar() +
  labs(x = "Pilot Type", 
       y= "Frequency", 
       title ="Types of US Pilots in the Tuskegee Airmen",
       caption = "Source: Commemorative Air Force| Viz: @rachel_roday") +
  facet_geo(~ state) +
  coord_flip()+
  theme(plot.background = element_rect(fill = "#f5ecdf", colour="#f5ecdf"),
        panel.background = element_rect(fill = "#f5ecdf", colour="#f5ecdf"),
        legend.background = element_rect(fill = "#f5ecdf", colour="#f5ecdf"),
        legend.position = "none",
        plot.title = element_text(colour = 'black', family="bebas", face = "bold", size=30),
        plot.subtitle = element_text(colour = 'black', family="bebas", size=15),
        plot.caption = element_text(colour = '#717370', family="bebas", size=15),
        legend.text = element_text(colour = 'black', family="bebas", size=10), 
        legend.title = element_text(colour = 'black', family="bebas", size=20),
        strip.background =element_rect(fill="#f5ecdf"),
        strip.text = element_text(colour = 'black', family="bebas", size=20),
        axis.text =  element_text(colour = 'black', family="bebas", size=14),
        axis.title = element_text(color='black', family= 'bebas', size = 20))
