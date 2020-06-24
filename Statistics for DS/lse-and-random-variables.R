# Monte Carlo simulation
   
        lse <- replicate(1000, {
          sample_n(galton_heights, 50, replace = TRUE) %>% 
            lm(son ~ father, data = .) %>% 
            .$coef 
        })
        lse
        lse <- data.frame(beta_0 = lse[1,], beta_1 = lse[2,]) 
        lse 
# Plot the distribution of beta_0 and beta_1
  
    install.packages("gridExtra")
    library(gridExtra)
    p1 <- lse %>% ggplot(aes(beta_0)) + geom_histogram(binwidth = 5, color = "black") 
    p2 <- lse %>% ggplot(aes(beta_1)) + geom_histogram(binwidth = 0.1, color = "black") 
    grid.arrange(p1, p2, ncol = 2)

# summary statistics
    sample_n(galton_heights, 50, replace = TRUE) %>% 
      lm(son ~ father, data = .) %>% 
      summary %>%
      .$coef

    lse %>% summarize(se_0 = sd(beta_0), se_1 = sd(beta_1))
    
    
#practice
    library(dplyr)    
    library(tidyverse)
    library(dslabs)
    library(HistData)
    library(Lahman)
    library(gridExtra)
    
    #sampling distribution of intercept(beta_0) and slope(beta_1)
    
    lse1 <- replicate(1000,{sample_n(galton_heights,50) %>% lm(son ~ father,data= .) %>% .$coef})
    
    lse1 <- data.frame(beta_0 = lse1[1,],beta_1 = lse1[2,])
    lse1
    
    dist0 <- qplot(lse1$beta_0,color=I('black'))
    dist1 <- qplot(lse1$beta_1,color = I('black'))

    grid.arrange(dist0,dist1)
    
    
    #lse can also be srongly correlated ie beta_0 abd beta_1
    
    lse1 %>% summarise(cor(beta_0,beta_1))
    
    #correlation is -0.9992384 or -1
    
#However, the correlation depends on how the predictors are defined or transformed.
#Here we standardize the father heights, which changes  xi  to  xi???x¯ .
    
    lse1 <- replicate(1000,{sample_n(galton_heights,50) %>%mutate(father = father - mean(father)) %>% lm(son ~ father,data= .) %>% .$coef})
    lse1
   
    lse1 <- data.frame(beta_0 = lse1[1,],beta_1 = lse1[2,])
    lse1
    
    lse1 %>% summarise(cor(beta_0,beta_1))
    
    #correlation becomes = -0.04512658 or 0
    
    