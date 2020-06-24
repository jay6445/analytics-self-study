#least squared errors

#we want our regression model to fit the data we need to reduce the distance
#that is, reduce the value of the error
library(dplyr)
library(HistData)
library(tidyverse)
data("GaltonFamilies")
set.seed(1983)
galton_heights <- GaltonFamilies %>%
  filter(gender == "male") %>%
  group_by(family) %>%
  sample_n(1) %>%
  ungroup() %>%
  select(father, childHeight) %>%
  rename(son = childHeight)

rss <- function(beta0, beta1, data){
  resid <- galton_heights$son - (beta0+beta1*galton_heights$father)
  return(sum(resid^2))
}
# plot RSS as a function of beta1 when beta0=25
beta1 = seq(0, 1, len=nrow(galton_heights))

results <- data.frame(beta1 = beta1,
                      rss = sapply(beta1, rss, beta0 = 25))
results %>% ggplot(aes(beta1, rss)) +  
  geom_line(aes(beta1, rss))

#sum of squared residual is the squared difference between the 
#(dependentvariable - (intercept(alpha/beta0) + quantifier(beta1)*dependentvariable))^2
#to obtain the smallest value of error we calculate the beta0 and beta1 using the lm(dependentVariable ~ IndependentVariable, data = data.frame) function

#regression model to predict sons height from fathers height
    
    galton_heights %>% lm(son ~ father,data=.)
    
    #Coefficients:
    #  (Intercept)       father  
    #37.2876       0.4614  
    
    #plot regression line
    
    galton_heights %>% ggplot(aes(father,son)) + geom_point(alpha = 0.5) + geom_abline(intercept = 37.2876, slope = 0.4614)

#regression line to predict fathers height from the sons height
    
    galton_heights %>% lm(father ~ son,data = .)
    
    
    #Coefficients:
    #  (Intercept)          son  
    #40.9383       0.4071 
    
    #plot regression line
  
    galton_heights %>% ggplot(aes(son,father)) +geom_point(alpha=0.5) + geom_abline(intercept = 40.9383, slope=0.4071)
    
    
    
    
    
#practice 

    sampling_son <- replicate(1000,{sample_n(galton_heights,34) %>% summarise(m = mean(son)) %>% pull(m)})
    sampling_son
    mean(sampling) #sampling distribution gives a mean of 69.23945
    mean(galton_heights$son) #our sample gives a mean of 69.24581

  #distibution of our son sample

    qplot(galton_heights$son,color = I("black"))

  #distribution of sampling distribution son will give normal distribution

    qplot(sampling_son,color=I("black"))


    sampling_father <- replicate(1000,{sample_n(galton_heights,34)%>% summarise(m = mean(father)) %>% pull(m)})
    sampling_father

  #distribution of father sample

    qplot(galton_heights$father,color=I("black"))

  #distribution of fathers sampling distribution

    qplot(sampling_father,color=I("black"))

  #create a data frame with sampling distribution of heights

    s_galton_heights = data_frame(son = sampling_son,father = sampling_father)
    s_galton_heights

  #plot a regression line for the same
    library(dplyr)
    lm <- s_galton_heights %>% lm(son ~ father,data=.)
    summary(lm)
    s_galton_heights %>% ggplot(aes(father,son)) + geom_point(alpha=0.5) + geom_abline(slope = 0.01052, intercept = 68.51350)

    qplot(s_galton_heights$father,color=I('black'))

    #perfect normal distribution
    #rnorm(n,mean,std)
    x <- rnorm(100,0,1)
    
    qplot(x,color = I('black'))
    
    #uniform distribution
    y <- runif(1000,0,1)
    qplot(y, color = I("black"))
    