#linear regression genetic history example
library(tidyverse)
library(HistData)
data("GaltonFamilies")
set.seed(1983)
galton_heights <- GaltonFamilies %>%
  filter(gender == "male") %>%
  group_by(family) %>%
  sample_n(1) %>%
  ungroup() %>%
  select(father, childHeight) %>%
  rename(son = childHeight)


# summarize() function summarizes the data and presents to us
galton_heights %>% summarize(mean(father),sd(father),mean(son),sd(son))



#find the correlation between son and fathers heights
  galton_heights %>% summarize(r=cor(father,son)) %>% pull(r)

#plot can take two vectors
  plot(galton_heights$father,galton_heights$son)

#ggplot can only take a data frame as an input
#ggplot using the data argument to take data frame as an input
  ggplot(data = galton_heights,aes(father,son))+geom_point(alpha=0.5)

#plot father and son height using ggplot() function, aes() stands for aesthetics and takes the co ordinates to plot
#ggplot using the pipe to take the data from data frame
  galton_heights %>% ggplot(aes(father,son)) + geom_point(alpha=0.5)

#extra code
#if we have two vectors we can create a data frame as follows and take it as an input to the ggplot function
  ggplot(data = data.frame(galton_heights$father,galton_heights$son),aes(galton_heights$father,galton_heights$son))+geom_point(alpha=0.5)

#str(galton_heights)
#class(galton_heights)
  galton_heights %>% cor(father,son)

#finding the correlation between heights

  cor(reading,writing)  

  cor(galton_heights$father,galton_heights$son)

#we can use a data frame directly by using a pipe operator

  galton_heights %>% summarize(r=cor(father,son)) %>% pull(r)
  
  
#sample_n() is used to extract a random sample of size n from a given sample or population
#where n is 25 below
  
  sample_n(galton_heights,25,replace = TRUE)

#now lets calculate the correlation of the extracted sample
#using cor() directly with a data frame
  
  sample_n(galton_heights,25) %>% summarize(r = cor(father,son)) %>% pull(r)  
  #0.475702
  
#now of we want to check the distribution of correlation for 1000 random samples from the population 
# we use the monte carlo simulation
  
 R <- replicate(1000,{sample_n(galton_heights,25) %>% summarize(r = cor(father,son)) %>% pull(r)})
  
#similarly we can even check the distribution of means by taking n samples from a population
#it will always be a normal distribution as stated in the central limit theorem
  #We're applying the central limit theorem
  
  meanDist <-  replicate(2000,{sample_n(galton_heights,30) %>% summarize(m = mean(father)) %>% pull(m)})

#breaking down the above function
#replicate(no of random samples, {sample_n(random sample selection from data frame,size of random sample) %>% summarize(r = mean(vector from df)) %>% pull(r)})

  hist(meanDist)  
  mean(meanDist) #very accurate dipiction of population mean 69.09387    
  #population mean
  mean(galton_heights$father) #69.09888
  
  #hence we prove that the mean of sampling distribution of means of a population accurately represents the population mean
  
#we have sampling distribution of correlation coefficients in R
  sd(R)
  mean(R)
  
  
#let's plot the sampling distibution of correlation coefficients
  
  qplot(R,geom = "histogram",binwidth=0.05,color = I("black"))

#We have the sampling distribution of means in meanDist
  #lets plot it
  qplot(meanDist, geom = "histogram",binwidth=0.05,color=I("black"))
  
#practice sampling distribution #muders
  library("dslabs")
  library(dplyr)
  data("murders")
  murders

#sampling distribution of means
  sm <- replicate(1000,{sample_n(murders,30)%>% summarize(m = mean(total)) %>% pull(m)})
 
#mean of sampling distribution
  mean(sm) #185.3763 for 1000 samples
           #184.1029 for 10000 samples     
  #more number of samples more accurate is our representation
#population mean
  mean(murders$total) #184.3725

#representing the sampling distribution using histogram
  
  qplot(sm,geom = "histogram",binwidth=2,color=I("black"))
  
  

