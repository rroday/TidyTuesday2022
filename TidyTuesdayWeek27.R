
library(tidytuesdayR)
library(ggplot2)
library(dplyr)
tuesdata <- tidytuesdayR::tt_load(2022, week = 37)

bigfoot <- tuesdata$bigfoot

head(bigfoot)
colorpal <- c("#37647a", "#3a653a","#b6864b","#8dbdbf","#92b070")

df<- bigfoot %>%
  group_by(season) %>%
  summarise(obs=n())
ggplot(df, aes(x=" ", y=obs, fill=season)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  theme_void()+
  scale_fill_manual(values=colorpal) + 
  labs(title = "Bigfoot sightings by season" , 
       caption = "Data viz = @rachel_roday")

