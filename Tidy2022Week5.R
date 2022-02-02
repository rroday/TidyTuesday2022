##
## Date Created: 2022-02-01
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: Time to code: 45 min :/
##        
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday")

#Load necessary packages
library(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(tidyr)

#Go! Get! Your! Data!
breed_traits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_traits.csv')
trait_description <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/trait_description.csv')
breed_rank_all <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_rank.csv')

# Im tired and dont know why left_join isnt working
breed_rank_all %>%
  mutate(sum_rank = rowSums(across(where(is.numeric)))) %>%
  filter(sum_rank <= 50) %>%
  left_join(breed_traits, by = "Breed") %>%
  select(-starts_with('Coat')) %>%
  pivot_longer(cols = 'Affectionate With Family':'Mental Stimulation Needs', names_to = 'Category', values_to = 'Value') %>%
  ggplot(aes(x=Breed, y=Value, colour = Category))+
  geom_point(position=position_dodge(width=.3), alpha=.5)+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, vjust=.5))+
  labs(title="Top Ranked Dog Breeds from 2013-2020 and Their Best Qualities",
       caption= "Data: American Kennel Club | Viz: @rachel_roday")

