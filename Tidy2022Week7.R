##
## Date Created: 2022-02-08
##
## Copyright (c) Rachel Roday, 2022
## Email: roday@utexas.edu
##
## ---------------------------
##
## Notes: https://github.com/ajstarks/dubois-data-portraits/blob/master/challenge/2022/challenge06/original-plate-14.jpg
## Challenge 7
## start time 11:40-12:10 12:20-1:26 1:50-2:00 3:10-3:50
## Total time: ~2.5 hours
## ---------------------------

setwd("C:/Users/RER/Desktop/TidyTuesday")

#Load necessary packages
library(tidytuesdayR)
library(dplyr)
library(tidyr)
library(ggplot2)
library(showtext)
library(forcats)
library(patchwork)


## Loading Google fonts (https://fonts.google.com/)
##  font-family: 'Teko', sans-serif;
font_add_google("Teko", "teko")

## Automatically use showtext to render text
showtext_auto()

#Go! Get! Your! Data!
df <- read.csv("WEBDuBois2022.csv")

#Color scheme
WEB <- c("#3f8a64","#c21537","#235fa3")

#plot plot plot plot plot
Female <- df %>%
  filter(!Gender == "Male") %>%
  gather(Status, Percent, -c(Gender, Group)) %>%
  mutate(Status = factor(Status,levels=c("Widowed","Married","Single"))) %>%
  ggplot(aes(x = Percent, y= Group, fill = Status, width = 1)) +
  geom_bar(position="stack", stat="identity")+
  scale_fill_manual(values = WEB) +
  theme_void() +
  labs(y = "",
       x = "Females.") +
  scale_x_continuous(minor_breaks = seq(from = 0, to = 100, by = 2), expand =c(0,0),
                     breaks = seq(10,100,10)) +
  scale_y_discrete(expand = c(0, 0), position="right")+
  theme(legend.position = "none",
        axis.line = element_line(color="black"),
        panel.grid.major = element_line(color="black"),
        panel.grid.minor.x = element_line(color="black"),
        panel.ontop = TRUE,
        panel.grid = element_blank(),
        panel.border = element_blank(),
        axis.title.x = element_text(angle = 0, vjust = 1.1, hjust = 10))+
  annotate("text", x=30, y='15-20', label= "Single", size = 10, family = "teko", angle =-50)+
  annotate("text", x=45, y='35-45', label= "Married", size = 10, family = "teko", angle=-50)+
  annotate("text", x=85, y='55-65', label= "Widowed", size = 10, family = "teko", angle=-50)+
  annotate("text", x=50, y=9.5, label="Females.", size = 6, family ="teko", vjust=-.5) +
  annotate("text", x=5, y=1, label="CENTS.", size = 5.5, family ="teko", vjust=5) +
  coord_cartesian(clip = 'off')


Male <- df %>%
  filter(!Gender == "Female") %>%
  gather(Status, Percent, -c(Gender, Group)) %>%
  mutate(Status = factor(Status,levels=c("Widowed","Married","Single"))) %>%
  ggplot(aes(x = Percent, y= Group, fill = Status, width = 1)) +
  geom_bar(position="stack", stat="identity")+
  scale_fill_manual(values = WEB) +
  theme_void() +
  labs(y = "",
       x = "Males.") +
  scale_y_discrete(expand = c(0, 0))+
  scale_x_reverse(minor_breaks = seq(from = 0, to = 100, by = 2), expand =c(0,0),
                  breaks = seq(10,100,10))+
  theme(legend.position = "none",
        axis.line = element_line(color="black"),
        panel.grid.major = element_line(color="black"),
        panel.grid.minor.x = element_line(color="black"),
        panel.ontop = TRUE,
        panel.grid = element_blank(),
        panel.border = element_blank())+
  annotate("text", x=30, y='15-20', label= "Single", size = 10, family = "teko", angle =50)+
  annotate("text", x=45, y='35-45', label= "Married", size = 10, family = "teko", angle=50)+
  annotate("text", x=90, y='Over 65', label= "Widowed", size = 8, family = "teko", angle=50, vjust=1)+
  annotate("text", x=50, y=9.5, label="Males.", size = 6, family ="teko", vjust=-.5) +
  annotate("text", x=5, y=1, label="PER", size = 5.5, family ="teko", vjust=5) +
  coord_cartesian(clip = 'off')

#Patch the two graphs together
patch = Male + Female 
patch[[1]] = patch[[1]] + theme(axis.text = element_text(color="black",family = "teko"))
patch[[2]] = patch[[2]] + theme(axis.text= element_text(color="black",family = "teko"))
  
  
patch + plot_annotation(title = "Conjugal condition of American Negroes according to age periods.",
                subtitle = "Done by Atlanta University.", 
                #tag_levels = list(c("Males.","Females.")),
                caption = "Source: Anthony Starks (W.E.B Du Bois) | Viz: @rachel_roday",
                theme = theme(plot.title = element_text(size = 25, hjust = .5, vjust=1),
                              plot.subtitle =element_text(size = 15, hjust = .5, vjust=1),
                              axis.title.x.top = element_text(color = "black"))) & 
  theme(text = element_text('teko'),
        plot.background = element_rect(fill = "#e7ccb0",
                                       colour = "#e7ccb0"))
  
        
