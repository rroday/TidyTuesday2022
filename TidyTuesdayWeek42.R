library(tidytuesdayR)
library(ggplot2)
library(dplyr)
library(emojifont)

tuesdata <- tidytuesdayR::tt_load('2022-10-25')

bakers<- tuesdata$bakers

cake<- emoji(search_emoji('cake'))[3]

ggplot(data=bakers, aes(x=age,y=technical_winner,label=cake, color=age))+
  geom_text(family="EmojiOne", size = 5)+
  scale_color_gradientn(colours = colorspace::heat_hcl(7)) +
  theme_bw()+
  labs(title="Age of Techincal Winners (Series 1-8)", x = "Age (yr)",
       y = "Number of Technical Wins", caption= "Data Vis by @higuerima_fish & @rachel_roday") +
  theme(legend.position = "none")

