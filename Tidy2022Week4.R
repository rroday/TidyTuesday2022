##
## Date Created: 2022-01-25
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: New laptop, most packages needed to be re installed
##        Time to code: 95 minutes. oof me
##        
##
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday")

#Load necessary packages
library(tidytuesdayR)
library(dplyr)
library(ggplot2)
library(treemapify)
library(showtext)
library(ggsci)

#Go! Get! Your! Data!
tuesdata <- tidytuesdayR::tt_load('2022-01-25')
ratings <- tuesdata$ratings
details <- tuesdata$details

# Join data frames
df<- ratings %>% 
  full_join(details, by = "id") %>%
  group_by(name) %>%
  arrange(desc(yearpublished))%>%
  filter(yearpublished == 2022) 

#Oh boy what am I looking at
summary(df$average)

#Add fonts pls
font_add_google(name = "Bebas Neue", family = "bebas")
showtext_auto()

#Graph that bish
ggplot(data = df, aes (area= users_rated, fill= average, label = name))+
  geom_treemap(color = "#D7BAAA")+
  geom_treemap_text(fontface = "italic",
                    family= "bebas",
                    colour = "black", 
                    place = "centre",
                    grow = FALSE) +
  scale_fill_gradient(low ="#e3f2da", high="#356119", name="Rating")+
  labs(title = "More than bored-games", 
       subtitle = "Average ratings of boardgames published in 2022. More users rated mediocre games rather than exception ones.",
       caption ="Source: Board Games Geek | Data Viz: @Rachel_Roday") +
  theme(plot.background = element_rect(fill = "#D7BAAA", colour="#D7BAAA"),
        panel.background = element_rect(fill = "#D7BAAA", colour="#D7BAAA"),
       legend.background = element_rect(fill = "#D7BAAA", colour="#D7BAAA"),
       legend.position = "bottom",
        plot.title = element_text(colour = 'black', family="bebas", face = "bold", size=35),
        plot.subtitle = element_text(colour = 'black', family="bebas", size=20),
       plot.caption = element_text(colour = '#717370', family="bebas", size=20),
        legend.text = element_text(colour = 'black', family="bebas", size=20), 
        legend.title = element_text(colour = 'black', family="bebas", size=20))
