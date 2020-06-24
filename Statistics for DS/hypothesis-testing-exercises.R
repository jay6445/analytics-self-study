#hypothesis testing

#

weight_diff <- c(-9.47,-6.84,-5.06,-3.25,-3.03,-2.43,-0.10,-0.03,1.49,3.66)
weight_diff
sample_mean <- mean(weight_diff) 
sample_mean #-2.506

#null hypothesis is the weightloss program is working, my aim is to reject the claim
length(weight_diff)
#t score for 9,0.025


#You are given the same dataset. We have also created two new worksheets: 'White' (containing only employees that are indicated as white) and 'Nonwhite' (Asian, Black or African American, Hispanic, Two or more races). 
#With the help of the new worksheets, it will be easier for you to calculate sample statistics.
#Using the same methodology as in the lecture, find if there is pay gap based on race.



  w_salary <- c(31200,31200,31200,31200,31200,32760,33280,33280,33280,33280,33280,33280,33280,34444.8,34840,35360,35360,35360,35360,35360,35360,37440,39520,39520,39520,39520,39520,39520,40560,41600,41600,41600,41600,41600,41600,43680,43680,43680,43680,44200,44720,45760,45760,45760,45760,45760,45760,45760,47840,47840,47840,49920,49920,49920,49920,50440,50960,52000,54080,54080,54891.2,56160)#,56160,56160,56160,60299.2)#,60320,60320,62816,65312,65312,70720,72696,76960,81120,82264,87360,87776,89440,93600,97760,99008,99840,102128,102440,106080,108160,110240,110240,112320,112320,113360,114400,114400,114400,114400,114400,114400,114400,114400,114400,114400,114400,115440,116480,116480,118560,124800,128960,133120,135200,166400)
  b_salary <- c(29120,29120,29120,31200,31200,33280,33280,34860.8,35360,37440,39520,41600,43680,43680,43680,45760,45760,45760,45760,45760,45760,45760,46800,47840,49920,49920,49920,49920,52000,52000,52000,54080,54080,54288,56160,57179.2,59280,60320,72696,73840,88920,110240,112320,114400,114400,114400,114400,114400,114400,114400,114400,114816,115440,115460.8,116480,116480,116480,116480,118809.6,124800,131040,135200)
  
  w_mean <- mean(w_salary) #67323.1
  b_mean <- mean(b_salary) #70917.26
  
  W_length <- length(w_salary) #112
  b_length <- length(b_salary)#62
  
  #null hypothesis : there is no gap in salary based on race mean(w_salary - b_salary) = 0
  #alternate hypothesis : there is gap in their mean salaries
  p_var <- ((length(w_salary)-1)*var(w_salary) + (length(b_salary)-1)*var(b_salary))/(length(w_salary)+length(b_salary)-2)
  p_var #1154494006
  
  t_score <- ((w_mean-b_mean)-0)/sqrt((1154494006/112)+(1154494006/62))
  t_score #-0.6682398
  
  112+67 -2
 #for 0.05 significance p-value 0.505449 we accept the null hypothesis
  length(w_salary)
  

#alpha is the critical value beyond which the null hypothesis will be accepted
#1-alpha is our significance level
#z-score / t-score > p-value : reject the null hypothesis
#z-score/t-score < p-value : accept the null hypothesis 
  
  #lets plot the regression line for the white and the black salaries by making a sampling distibution
  
  b_sample <- replicate(1000,{sample_n(data.frame(w_salary,b_salary),34) %>% summarise(m = mean(b_salary)) %>% pull(m)})
  b_sample
  library(dplyr)
  w_sample <- replicate(1000,{sample_n(data.frame(w_salary,b_salary),34) %>%summarise(m =  mean(w_salary)) %>% pull(m)})
  w_sample
  
  lm(b_sample ~ w_sample)
  
 data.frame(b_sample,w_sample) %>% ggplot(aes(b_sample,w_sample)) + geom_point(alpha = 0.5) + geom_abline(intercept = 80387.8271 , slope = -0.2258)

 qplot(w_sample, color = I("black"))  
 qplot(b_sample, color = I("black"))
 mean(sample(w_salary[1:62],34))
 
