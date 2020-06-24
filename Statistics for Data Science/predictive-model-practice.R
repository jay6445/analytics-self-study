#Practice 

#Building a predictive model using the murders dataset

library(dslabs)
library(dplyr)
library(ggplot2)
library(broom)

  data("murders") #loading the data set

  murders

#build a model that predicts the total murders based on population

  fit <- murders %>% lm(total ~ population,data=.)

  tidy(fit) #get the p-value for population, it shows that it is extremely significant

#total murders for population of India

  population <- 1380004385
  
  input_model<- data.frame(population)
  input_model

#predict murders
  
  predict(fit,input_model) #45749.92 
 
#plot the relation between population and murders from out data set
 
  murders %>% ggplot(aes(population,total, size=population)) + geom_point(color="purple",alpha=0.5) + geom_smooth(method="lm")

#does total murder follow a normal distribution
  
  qplot(murders$total,color=I("black"))

#does population follow a normal distribution  
  
 qplot(murders$population,color=I("black"))

#As we observe they do not follow a uniform distibution we create mean sampling distribution of both
#using monte carlo simulation
 
 sampling_population <- replicate(1000,{sample_n(murders,31)%>% summarise(m = mean(population)) %>% pull(m) })
 
 sampling_murders <- replicate(1000, {sample_n(murders,31) %>% summarise(m = mean(total)) %>% pull(m)})
 
#check distibution for both
 
 qplot(sampling_population,color=I("black"))

 qplot(sampling_murders,color=I("black")) 

#We now see that they are normally distributed
#if the dataset is of 50-100 never take a sample of 50, in most cases take a sample of 30-35 but not less than 30   

 #create sampling dataframe
 
 sampling_df <- data.frame(sampling_population,sampling_murders)
 
#plot the sampling dist for population and murders
 
 sampling_df %>% ggplot(aes(sampling_population,sampling_murders)) + geom_point(alpha=0.5)+ geom_smooth(method = "lm")

 cor(sampling_population,sampling_murders) #-0.01323606
 
  #After simulation for a population we undersytand that the population is not 
  #much correlated with murders but there are other factors involved
  
 #instead of population and total murders, we can plot the murder rates instead
 
 sampling_df <- sampling_df %>% mutate(murder_rate= (sampling_murders/sampling_population)*100 )
  sampling_df

 #correlation between murder rate and population
  
  sampling_df %>% summarise(cor(sampling_population,murder_rate)) #-0.6711411
  
  sampling_df %>% ggplot(aes(sampling_population,murder_rate)) + geom_point()
  
  
 #We have an inverse relation between population and murders while simulating a population
 #this tells us that the small population regions in out data set might be more notorious
 #We might want to consider other parameters in our model like the mafia influence or the smuggling rate.
  
    
  