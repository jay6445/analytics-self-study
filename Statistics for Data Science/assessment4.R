#assessment least square estimates

beta1 = seq(0, 1, len=nrow(galton_heights))

rss <- function(beta0, beta1, data){
  resid <- galton_heights$son - (beta0+beta1*galton_heights$father)
  return(sum(resid^2))
}


results <- data.frame(beta1 = beta1, rss = sapply(beta1, rss, beta0 = 36))

mean(results$beta1)

results %>% ggplot(aes(beta1, rss)) + geom_line() + 
  geom_line(aes(beta1, rss), col=2)




#Load the Lahman library and filter the Teams data frame to the years 1961-2001. Run a linear model in R predicting the number of runs per game based on both the number of bases on balls per game and the number of home runs per game.
#What is the coefficient for bases on balls?

    library(Lahman)
    Teams <- Teams %>% filter(yearID %in% 1961:2001)
    Teams
    
    fit1 <- Teams %>% mutate(runrate = R/G, bbrate = BB/G, homer_rate = HR/G) %>% lm(runrate ~ bbrate + homer_rate,data=.)
    fit2 <- Teams %>% mutate(runrate = R/G, bbrate = BB/G, homer_rate = HR/G) %>% lm(runrate ~ homer_rate,data=.)
    fit1
    fit2
   
    Y_hat <- predict(fit, se.fit = TRUE)
    names(Y_hat)
   
    
    
# In Questions 7 and 8, you'll look again at female heig#hts from GaltonFamilies.

#Define female_heights, a set of mother and daughter heights sampled from GaltonFamilies, as follows:    
    
    
    set.seed(1989) #if you are using R 3.5 or earlier
    set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
    library(HistData)
    data("GaltonFamilies")
    options(digits = 3)    # report 3 significant digits
    
    female_heights <- GaltonFamilies %>%     
      filter(gender == "female") %>%     
      group_by(family) %>%     
      sample_n(1) %>%     
      ungroup() %>%     
      select(mother, childHeight) %>%     
      rename(daughter = childHeight)

#Fit a linear regression model predicting the mothers' heights using daughters' heights.    
    
    female_heights %>% lm(mother ~ daughter,data = .)    
    
    #Coefficients:
    #(Intercept)     daughter  
    #44.18         0.31  
    
#Predict mothers' heights using the model.
    mom_height = 44.18 + 0.31*female_heights$daughter
    mom_height
    female_heights$mother
   
#We have shown how BB and singles have similar predictive power for scoring runs. Another way to compare the usefulness of these baseball metrics is by assessing how stable they are across the years. 
#Because we have to pick players based on their previous performances, 
#we will prefer metrics that are more stable. In these exercises, we will compare the stability of singles and BBs.
#Before we get started, we want to generate two tables: one for 2002 and another for the average of 1999-2001 seasons. 
#We want to define per plate appearance statistics, keeping only players with more than 100 plate appearances. Here is how we create the 2002 table:    
 
    library(Lahman)
    bat_02 <- Batting %>% filter(yearID == 2002) %>%
      mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
      filter(pa >= 100) %>%
      select(playerID, singles, bb)   
    
   
    length(Batting$playerID)
    
    
#Now compute a similar table but with rates computed over 1999-2001. Keep only rows from 1999-2001 where players have 100 or more plate appearances, calculate each player's single rate and BB rate per season, then calculate the average single rate (mean_singles) and average BB rate (mean_bb) per player over those three seasons.
#How many players had a single rate mean_singles of greater than 0.2 per plate appearance over 1999-2001?
    
    bat_03 <- Batting %>% filter(yearID %in% 1999:2001) %>%
      mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
      filter(pa >= 100) %>%
      select(playerID, singles, bb) %>% group_by(playerID) %>% summarise(mean_bb = mean(bb), mean_singles = mean(singles))
    
    
    bat_03 %>% filter(mean_singles > 0.2)
    
#How many players had a BB rate mean_bb of greater than 0.2 per plate appearance over 1999-2001?
    
    bat_03 %>% filter(mean_bb > 0.2)

    
#Use inner_join() to combine the bat_02 table with the table of 1999-2001 rate averages you created in the previous question.
#What is the correlation between 2002 singles rates and 1999-2001 average singles rates? 
    
    bat_04 <- inner_join(bat_02,bat_03)
    
    bat_04 %>% summarise(cor(singles,mean_singles))
    
#What is the correlation between 2002 BB rates and 1999-2001 average BB rates?
    
    bat_04 %>% summarize(cor(bb,mean_bb))  

    
#Make scatterplots of mean_singles versus singles and mean_bb versus bb.
#Are either of these distributions bivariate normal?    
    
    p1 <- bat_04 %>% ggplot(aes(mean_singles,singles)) + geom_point(alpha=0.5) + geom_smooth(method = "lm")
    p2 <- bat_04 %>% ggplot(aes(mean_bb,bb))+ geom_point(alpha =0.5) + geom_smooth(method = "lm")
    
    grid.arrange(p1,p2)

    
#Fit a linear model to predict 2002 singles given 1999-2001 mean_singles.
    
#What is the coefficient of mean_singles, the slope of the fit?
     
    bat_04 %>% lm(singles ~ mean_singles,data=.)
    
    bat_04 %>% lm(bb ~ mean_bb,data=.)
        