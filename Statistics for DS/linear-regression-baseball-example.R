#linear regression for baseball data

install.packages("Lahman")
library(Lahman)
library(tidyverse)
library(dslabs)
ds_theme_set()

#plot relation between Homeruns and runs per game respectively  

Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR_per_game = HR / G, R_per_game = R / G) %>%
  ggplot(aes(HR_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

#plot relation between stolen bases and the runs per game respectively

Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(SB_per_game = SB / G, R_per_game = R / G) %>%
  ggplot(aes(SB_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

#plot relation between bases one balls and runs per game respectively

Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(BB_per_game = BB / G, R_per_game = R / G) %>%
  ggplot(aes(BB_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

#what is geom() geometric graph
?geom_point() #used to select which graph to be used according to the variables provided
Teams
#what is ggplot(aes(x,y)) aes argument provides the variables to plot
?ggplot


#find the relation between at-bats and runs

Teams %>% filter(yearID %in% 1961:2001) %>% 
  mutate(AB_per_game = AB/G,R_per_game = R/G) %>%
  ggplot(aes(AB_per_game,R_per_game)) +geom_point(alpha = 0.5)

#find the relation between win rate and fielding errors per game
str(Teams)
Teams %>% filter(yearID %in% 1961:2001) %>% mutate(Win_rate = W/G , fielding_error_rate = E/G) %>% 
  ggplot(aes(Win_rate,fielding_error_rate))+geom_point(alpha=0.5)

#find the relation between triples per game vs doubles
Teams <- Teams %>% filter(yearID %in% 1961:2001) %>% mutate(triple_rate =X3B/G, double_rate = X2B/G) %>%
  ggplot(aes(triple_rate,double_rate))+ geom_point(alpha=0.5) 
data(Teams)
corc(Teams$triple_rate,Teams$double_rate)

