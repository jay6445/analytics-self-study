#create a research such as to prove the height of son depends on father. Genetic quality
library(ggplot2)
library(dplyr)
galton_heights
qplot(galton_heights$father,geom= "histogram",color= I("black"))

galton_heights %>% summarize(c=cor(father,son)) %>% pull(c) #0.3901334

#for the current sample of 179 we have a correlation coefficient of 0.3901334
#Let us check the scatter plot for our sample

galton_heights %>% ggplot(aes(son,father)) + geom_point(alpha = 0.5) + geom_smooth(method = "lm") 
#upward trend observed here

boxplot(galton_heights$son,galton_heights$father)

#Lets simulate for 1000 samples of size 60

son <- replicate(1000,{sample_n(galton_heights,60) %>% summarize(m = mean(son)) %>% pull(m)})
father <- replicate(1000,{sample_n(galton_heights,60) %>% summarize(m = mean(father)) %>% pull(m)})

simulated_heights <- data.frame(father,son)
#now lets plot them

simulated_heights %>% ggplot(aes(son,father)) +geom_point(alpha=0.5,color="purple") +geom_smooth(method="lm")
#line turned flat as a distinct trend cannot be observed

#let us check the stats

fit <- simulated_heights %>% lm(son ~ father,data=.)
summary(fit)
#for the simulated sample of 1000 we get a p-value of 0.8508 which is insignificant
#father's height cannot be used to predict son's hence we accept the null hypothesis

#just for clarity let us check stats for our initial sample of 179 

library(tidyverse)
fit1 <- galton_heights %>% lm(son ~ father,data=.)

summary(fit1) # p-value 6.719e-08
#the p- value obtained in our sample says that the father's height is very significant for predicting son's height

#Anyway let us build our model and check for ourselves

galton_heights$son

predicted_heights <- predict(fit1,galton_heights) #predicted heights of all sons

cor(galton_heights$son,predicted_heights) #correlation between predicted height and actual height must show strong correlation
#here it shows only a correlation of 0.3901334




   