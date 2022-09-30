# Authors : Mariana Rivera-Higueras and Rachel Roday
# University of Texas at Austin Marine Science Institute
# Date created: 9/28/22
# Last modified: 9/30/22
# Copy right: MRH and RER



library(tidyverse)
library("tidytuesdayR")
library(geofacet)


tuesday09.28.22<-tidytuesdayR::tt_load('2022-09-27')
df<-tuesday09.28.22$artist
View(df)


mean.Wxhr<- df %>% 
  group_by(state, race) %>% 
  na.omit() %>% 
  summarise(M.all.work=sum(all_workers_n),
            M.all.artist=sum(artists_n)) %>% 
  mutate(Percent.artist.work= (M.all.artist/M.all.work) *100)
view(mean.Wxhr)

bar.graph1<- ggplot(mean.Wxhr, aes(x=race, y=Percent.artist.work, fill=race)) +
  geom_bar(stat = "identity") + facet_geo(~state, grid = "us_state_grid2") + 
  theme_bw() + 
  theme(axis.text.x =element_blank(),
        panel.border = element_blank(),
        axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
        strip.text.x = element_text(size = 8),
        strip.background = element_rect(fill="lightblue", colour="black",
                                        size=1)) +
  scale_fill_brewer(palette = "Accent") +
  ggtitle("Proportional artist per worker in the US") +
  labs(caption = "Data vis by: Mariana R.-Higueras and Rachel Roday")

bar.graph1


RColorBrewer::display.brewer.all()