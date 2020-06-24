#assessment 3
library(Lahman)
Teams <- Teams %>% filter(yearID %in% 1961:2001)

#What is the correlation coefficient between number of runs per game and number of at bats per game?
Teams %>% summarize(r = cor(R/G,AB/G)) %>% pull(r)

#What is the correlation coefficient between win rate (number of wins per game) and number of errors per game?
Teams %>% summarise(r = cor(W/G,E/G)) %>% pull(r)

#What is the correlation coefficient between doubles (X2B) per game and triples (X3B) per game?

Teams %>% summarise(r = cor(X2B/G,X3B/G)) %>% pull(r)
install.packages()