# assessment3 part 2

set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
library(HistData)
data("GaltonFamilies")

female_heights <- GaltonFamilies%>%     
  filter(gender == "female") %>%     
  group_by(family) %>%     
  sample_n(1) %>%     
  ungroup() %>%     
  select(mother, childHeight) %>%     
  rename(daughter = childHeight)

#Calculate the mean and standard deviation of mothers' heights, the mean and standard deviation of daughters' heights, 
#and the correlaton coefficient between mother and daughter heights.

  female_heights %>% summarize(mean(mother),sd(mother),mean(daughter),sd(daughter),cor(mother,daughter))

#Calculate the slope and intercept of the regression line predicting daughters' heights given mothers' heights. 
#Given an increase in mother's height by 1 inch, how many inches is the daughter's height expected to change?

  slope = female_heights %>% summarize(s = cor(mother,daughter) * (sd(daughter)/sd(mother))) %>% pull(s)
  slope
  intercept = mean(female_heights$daughter) - slope*mean(female_heights$mother)
  intercept  
  
#change in inches in y according to change in x by 1 inch is the slope
  
#percent change in y according to change in x by 1 inch
  cor(female_heights$mother,female_heights$daughter)^2 *100
  (0.3245199)^2

#What is the conditional expected value of her daughter's height given the mother's height
  female_heights %>% filter(round(mother) == 60)%>%group_by(round(mother))%>%summarize(m = mean(daughter)) %>% pull(m)
  
  
  #sd(daughter) 2.778689
  #sd(mother) 0
  
  42.51701 + 0.3393856*(60)
  
  
  #practice
      data(murders)
  #simulation for 1000 samples of total murders
      library(dplyr)
      library(tidyverse)
      library(dslabs)
      m <- replicate(1000,{sample_n(murders,33) %>% summarise(m = mean(total))%>% pull(m)})
      m #sample function only takes data frame as an input not a vector
      library(tidyverse)
      qplot(m,geom = "histogram",binwidth=5, color = I("black"))
      mean(m)
  
  #regression line between population and total murders
  
      slope = cor(murders$population,murders$total) * sd(murders$total)/sd(murders$population)
      intercept = mean(murders$total) - cor(murders$population,murders$total)*mean(murders$population)
      intercept
      murders %>% ggplot(aes(population,total))+ geom_point(alpha=0.5) +geom_abline(slope = slope,intercept = intercept)
  
  #practice using white and black employee salaries
      
      #sampling means of white sample to approximate population mean
      mean(w_salary[1:62])
      sampling_white <- replicate(1000,{sample_n(data.frame(w_salary[1:62],b_salary),33) %>% summarise(m = mean(w_salary)) %>% pull(m)})
      sampling_white
      sampling_black <- replicate(1000,{sample_n(data.frame(w_salary[1:62],b_salary),33)%>% summarise(m = mean(b_salary))%>% pull(m)})
      sampling_black
      
      data.frame(sampling_black,sampling_white) %>% ggplot(aes(sampling_white,sampling_black)) + geom_point(alpha = 0.5)
      + abline(slope = 0, intercept=0)
  
     cor(b_salary,w_salary[1:62]) #we have a 0.9312439 correlation coefficient for our sample
     sd(w_salary)
     sd(b_salary)
    
     #the sampling distribution of mean gives us the correlation cofficient of 1
     #that is perfect correlation, there there's no gap in the salaries of black and whites
     cor(sampling_white,sampling_black) #1 mimics the cor of the population
      
 