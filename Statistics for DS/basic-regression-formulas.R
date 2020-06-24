#important functions for statistics

galton_heights #data frame used

#creating sampling distribution of means of y using montecarlo simulation, replicate() function creates 1000 entries, sample_n takes samples of n =34 and summarize() takes single mean value for every such sample, finally we have 1000 means.
#sampling distribution will always be Normal

    sample <- replicate(1000,{sample_n(galton_heights,34) %>% summarise(m = mean(son)) %>% pull(m)})

#We can check the distribution of y using the histogram qplot()        
    library(tidyverse)
    library(dplyr)
    library(ggplot2)
    
    qplot(sample, color = I('black'))
    
    #following ggplot() only works with dataframes
    as.data.frame(sample) %>% ggplot(aes(x = sample)) + geom_histogram(binwidth = 0.1, color = "black")

        
#We can use scatter plot to check relation between x and y vectors
    
    galton_heights %>% ggplot(aes(father,son)) + geom_point(alpha =0.5)

    
#Regression line to check if relation between x and y is linear or not
    
    #using lm() function to calculate slope and intercept of the regression line such that the least squared residual is minimum
    
    fit <- lm(son ~ father,data=galton_heights) 
    
    #Coefficients:
    #  (Intercept)       father  
    #37.2876       0.4614 
    
    #when the independent variables keep on incresing we can write lm as lm (y ~ x1 + x2 + x3 + .....xn,data=data.frame)
    
    #we can get other stats of the regression using summary()
    
    summary(fit)
    
    
    #Coefficients:
    #  Estimate Std. Error t value Pr(>|t|)    
    #(Intercept) 37.28761    4.98618   7.478 3.37e-12 ***
    #  father       0.46139    0.07211   6.398 1.36e-09 ***
    #  ---
    #  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    #Residual standard error: 2.45 on 177 degrees of freedom
    #Multiple R-squared:  0.1878,	Adjusted R-squared:  0.1833 
    #F-statistic: 40.94 on 1 and 177 DF,  p-value: 1.36e-09
    
    
    #therefore with such high p-value we cannot use the variable x for our regression model according to hypothesis testing.
    # our null hypothesis is accepted and we drop the variable
    
    
    #We check the regression line for x and y anyway using ggplot and geom_abline()
    
    galton_heights %>% ggplot(aes(father,son)) +geom_point(alpha=0.5) + geom_abline(slope = 0.4614, intercept = 37.2876 )
    

#creating random samples
    
    #uniformly distributed sample is created using runif(n,min,max)
    
    runif(1000,0,1)
    qplot(runif(1000,0,1), color=I('black'))

    #normally distributed sample is created using rnorm(n,mean,sd)
    #standard normal distribution
    
    rnorm(1000,0,1)
    qplot(rnorm(1000,0,1),color=I('black'))    
    
#The intercept in the linear regression model is the mean of the y
#to prove this let us build a model to predict runs per game based on the base on balls
#here we use the tidy() function and specify the confidence interval    
    
    Teams %>% mutate(runrate = R/G,bbrate = BB/G) %>% do(tidy(lm(runrate ~ bbrate,data=.),conf.int = TRUE))
    
           # term        estimate std.error statistic  p.value conf.low conf.high
           #<chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
           #     1 (Intercept)    1.93     0.116       16.7 2.30e-55    1.70      2.16 
           #2 bbrate         0.735    0.0349      21.1 3.00e-82    0.667     0.804

#In the above output we observe that the intercept is actually the mean of the confidence 
#interval ie. the run rate(y) will lie in that confidence interval and mean(y) 
#will be the beta0 or the intercept in our regression model 
    
#When our linear model contains 2 or more predictors ie. x1 x2 we use lm() function as follows
    #in the lm() function we add a + between independent variables
    
    #In the below baseball example we know that the run rate is both dependent on base on balls and home runs so we accordingly find the estimates using lm()
    
    library(Lahman)
    data(Teams)
    
    Teams %>% filter(yearID %in% 1961:2001) %>% mutate(run_rate = R/G,bb_rate = BB/G, hr_rate = HR/G) %>%
    do(tidy(lm(run_rate ~ bb_rate + hr_rate,data= .)))
    
    
    # regression with BB, singles, doubles, triples, HR
    Teams %>% 
        filter(yearID %in% 1961:2001) %>% 
        mutate(BB = BB / G, 
               singles = (H - X2B - X3B - HR) / G, 
               doubles = X2B / G, 
               triples = X3B / G, 
               HR = HR / G,
               R = R / G) %>%  
               do(tidy(lm(R ~ BB + singles + doubles + triples + HR, data = .)))

    #prediction of runs using the above model
    
    #create our model
        fit <- Teams %>% filter(yearID %in% 1961:2001) %>% 
               mutate(BB = BB / G, 
               singles = (H - X2B - X3B - HR) / G, 
               doubles = X2B / G, 
               triples = X3B / G, 
               HR = HR / G,
               R = R / G) %>%  
               lm(R ~ BB + singles + doubles + triples + HR, data = .) #Do not use tidy as we need our model in lm() object format
    
    #We see run rate depends upon bb singles doubles tripples and hr
        
        model_inputs<- data.frame(BB= 2,singles= 1, doubles = 3, triples = 2.3, HR = 9)
        model_inputs
        
        #We predict the runs based on the above model inputs using predict() method
        
        predict(fit,model_inputs) #16.64833 runs in that match
        
        #We can input a data frame for many such obs of bb, singles,doubles... and predict the runs for each obs
        
        