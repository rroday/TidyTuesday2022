##
## Date Created: 2022-02-26
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: Time to code: 25 min
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday")

#Load necessary packages
library(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(showtext)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

#Go! Get! Your! Data!
tuesdata <- tidytuesdayR::tt_load('2022-02-22')
freedom <- tuesdata$freedom 
freedom <- freedom %>%  filter(year == 2020)

# Get world map
world <- ne_countries(scale = "medium", returnclass = "sf") 
class(world) 
# %>% select_admin

df <- left_join(world, freedom, by = c("admin" = "country"))

#Map
ggplot(df) +
  geom_sf(data = df, aes(fill = factor(Status)), color = "white")+
  theme_bw()+
  scale_fill_manual(values = c("seagreen3", "red", "#FFDB33","grey"), 
                    name= "Freedom Status")+
  labs(title = "2020 Freedom Status of World Countries",
       caption = "Data: Freedom House/UN| Viz: @rachel_roday")

