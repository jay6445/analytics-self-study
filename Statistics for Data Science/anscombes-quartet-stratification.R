#anscombes-quartet-stratification

#heriditary height example
#suppose we need to find the height of the son whose father is around 72 inches
  
  mean(galton_heights$son)
  sd(galton_heights$son)

#we cannot use the about formulas as in those we consider the entire sample and not just 
#fathers with height 72
#however there might be as little as 1 2 or no fathers exactly equal to 72
# we there fore stratify or round up similar values of fathers heights

#Calculate the mean height of the son when the father is 72 inches tall 
  
  conditional_avg <-  galton_heights %>% filter(round(father) == 72) %>% 
  summarize(avg = mean(son)) %>% pull(avg)
  conditional_avg #70.5

#stratify fathers height and plot against son
  
  galton_heights %>% 
  mutate(father_strata = factor(round(father))) %>%
  ggplot(aes(father_strata,son)) + geom_boxplot() + geom_point()
  
#now we calculate the centre point of each box plot which will be the average sons height for that fathers height value
  
  galton_heights %>% mutate(father_starta = factor(round(father))) %>% 
  group_by(father_starta) %>% 
  summarize(avg = mean(son)) %>% 
  ggplot(aes(father_starta,avg))+geom_point(alpha =0.5) 
  
# calculate values to plot regression line on original data
  
  mu_x <- mean(galton_heights$father)
  mu_y <- mean(galton_heights$son)
  s_x <- sd(galton_heights$father)
  s_y <- sd(galton_heights$son)
  r <- cor(galton_heights$father, galton_heights$son)
  m <- r * s_y/s_x
  b <- mu_y - m*mu_x

# add regression line to plot
    galton_heights %>%
    ggplot(aes(father, son)) +
    geom_point(alpha = 0.5) +
    geom_abline(intercept = b, slope = m)
    
    
#in bivariate distribution, the relation between x and y is given by the regression line 
    
      galton_heights %>%
      mutate(z_father = round((father - mean(father)) / sd(father))) %>%
      filter(z_father %in% -2:2) %>%
      ggplot() +  
      stat_qq(aes(sample = son)) +
      facet_wrap( ~ z_father)
      
#The standard deviation of the conditional distribution is  SD(Y???X=x)=??y???1-p^2 , which is smaller than the standard deviation without conditioning  ??y .      

      
#There are two different regression lines depending on whether we are taking the expectation of Y given X or taking the expectation of X given Y.
      
#we drew the regression line where we compute sons height from fathers height
      
      # compute a regression line to predict the son's height from the father's height
      mu_x <- mean(galton_heights$father)
      mu_y <- mean(galton_heights$son)
      s_x <- sd(galton_heights$father)
      s_y <- sd(galton_heights$son)
      r <- cor(galton_heights$father, galton_heights$son)
      m_1 <-  r * s_y / s_x
      b_1 <- mu_y - m_1*mu_x
      
      # compute a regression line to predict the father's height from the son's height
      m_2 <-  r * s_x / s_y
      b_2 <- mu_x - m_2*mu_y

      galton_heights %>% ggplot(aes(father,son)) +geom_point(alpha = 0.5) + geom_abline(slope = m_2,intercept = b_1)    
      
#formula for slope and intercept of the regression line 
      #slope(x,y) = (correlation between x and y) * (sd(y)/sd(x)) #while predicting y
      #slope(y,x) = (correlation between y and x) * (sd(x)/sd(y)) #while predicting x
      
      #intercept(x,y) = mean(y) - slope(x,y) * mean(x) #predicting variable - slope * other variable
      #intercept(y,x) = mean(x) - slope(y,x) * mean(y)
      
      #When two variables follow a bivariate normal distribution, the variation explained can be calculated as  ??2×100

                  