##
## Date Created: 2022-02-01
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: Time to code: 110 min :/
##        
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday")

#Load necessary packages
library(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)
library(showtext)

#Go! Get! Your! Data!
breed_traits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_traits.csv') %>%
  mutate(Breed = str_squish(Breed))
breed_rank_all <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_rank.csv') %>%
  mutate(Breed = str_squish(Breed)) 

font_add_google(name = "Bebas Neue", family = "bebas")
showtext_auto()


breed_rank_all %>%
  mutate(sum_rank = rowSums(across(where(is.numeric)))) %>%
  filter(sum_rank <= 50) %>%
  left_join(breed_traits, by = "Breed") %>%
  select(-'Coat Type') %>%
  select(-'Coat Length') %>%
  pivot_longer(cols = 'Affectionate With Family':'Mental Stimulation Needs', names_to = 'Category', values_to = 'Value') %>%
  ggplot(aes(x="", y=Value, fill=Category)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  facet_wrap(~Breed)+
  labs(fill = "Breed Traits",
       title="Which Dog breed Should My Family adopt?",
       subtitle = "Top Ranked Dog Breeds from 2013-2020 and Their Best Traits (from 1 to 5)",
       caption= "Data: American Kennel Club | Viz: @rachel_roday",
       x="",
       y="") +
  theme(plot.background = element_rect(fill = "#D7BAAA", colour="#D7BAAA"),
        panel.background = element_rect(fill = "#D7BAAA", colour="#D7BAAA"),
        legend.background = element_rect(fill = "#D7BAAA", colour="#D7BAAA"),
        legend.position = "right",
        plot.title = element_text(colour = 'white', family="bebas", face = "bold", size=30),
        plot.subtitle = element_text(colour = 'white', family="bebas", size=15),
        plot.caption = element_text(colour = '#717370', family="bebas", size=15),
        legend.text = element_text(colour = 'black', family="bebas", size=10), 
        legend.title = element_text(colour = 'black', family="bebas", size=20),
        strip.background =element_rect(fill="#D7BAAA"),
        strip.text = element_text(colour = 'black', family="bebas", size=20),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        axis.text =  element_text(colour = 'black', family="bebas", size=10))

