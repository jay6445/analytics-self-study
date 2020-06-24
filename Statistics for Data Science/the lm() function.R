# the lm function to find the slope and the intercept of the regression line where the least squares will be minimum
    library(tidyverse)
    library(Lahman)
#finding the slope and intercept for bases on balls against runs per game
    data(Teams)
    
    #lm() function is used to calculate the intercept and the slope of line
    #lm(x ~ y,data = .) 
    
    bb_slope <- Teams %>% filter(yearID %in% 1961:2001) %>% mutate(bb_rate = BB/G,run_rate = R/G) %>% 
    lm(run_rate ~ bb_rate,data = .)

    bb_slope
    
    cor(Teams$run_rate,Teams$bb_rate) #base on balls has a strong correlation with the runs made in a match

    library(dplyr)    
    Teams %>% filter(yearID %in% 1961:2001) %>% mutate(bb_rate = BB/G, run_rate = R/G) %>%
    ggplot(aes(bb_rate,run_rate)) + geom_point(alpha=0.5) + geom_abline(slope = 0.7353, intercept = 1.9323)

#finding the slope of line for singles and runs per game
      Teams$yearID
     
      singles_slope <- Teams %>% filter(yearID %in% 1961:2001) %>% 
      mutate(single_rate = (HR-X2B-X3B)/G, run_rate = R/G) %>% lm(run_rate ~ single_rate,data = .)
      singles_slope

      Teams %>% filter(yearID %in% 1961:2001) %>% 
        mutate(single_rate = (HR-X2B-X3B)/G, run_rate = R/G) %>% ggplot(aes(single_rate,run_rate))+geom_point(alpha = 0.5) + geom_abline(intercept = 4.44182, slope = 0.09864  )

      cor(Teams$run_rate,Teams$single_rate) #0.0458714 as good as zero as specified in the graph
        
      #Here we see that singles and runs per match have a weak correlation
      
# We therefore see from the above slopes that relationship between two variables need not necessarily mean causation
      
      
      # calculate correlation between HR, BB and singles
      Teams %>% 
        filter(yearID %in% 1961:2001 ) %>% 
        mutate(Singles = (H-HR-X2B-X3B)/G, BB = BB/G, HR = HR/G) %>%  
        summarize(cor(BB, HR), cor(Singles, HR), cor(BB,Singles))
      
      
#      
       