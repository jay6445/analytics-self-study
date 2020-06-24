#correlation is not causation
  
  #Spurious Correlation
    
      #two variables x and y may have a high correlation close to 1 but logically they are not related to each other

    library(dplyr)
    library(broom)
    library(tidyverse)
    # generate the Monte Carlo simulation
    N <- 25
    g <- 1000000
    sim_data <- tibble(group = rep(1:g, each = N), x = rnorm(N * g), y = rnorm(N * g))
    
    # calculate correlation between X,Y for each group
    res <- sim_data %>% 
      group_by(group) %>% 
      summarize(r = cor(x, y)) %>% 
      arrange(desc(r))
    res
    
    # plot points from the group with maximum correlation
    sim_data %>% filter(group == res$group[which.max(res$r)]) %>%
      ggplot(aes(x, y)) +
      geom_point() + 
      geom_smooth(method = "lm")
    
    # histogram of correlation in Monte Carlo simulations
    res %>% ggplot(aes(r)) + geom_histogram(binwidth = 0.1, color = "black")
    
    # linear regression on group with maximum correlation
    library(broom)
    sim_data %>% 
      filter(group == res$group[which.max(res$r)]) %>%
      do(tidy(lm(y ~ x, data = .))) 

    
    #As you see the p-value obtained here is a very low value which makes us believe that the relation is significant
    #This type of data dredging is called p-hacking
    #In many fields regression models having just the smallest p-value are reported
    #We refer to such situations as the multiple comparasion problem  
    
  
  #High correlation due to outliers
  #We use spearmans correlation method that uses the ranks of the points instead of their values
    
    
    # simulate independent X, Y and standardize all except entry 23
    set.seed(1985)
    x <- rnorm(100,100,1)
    y <- rnorm(100,84,1)
    x[-23] <- scale(x[-23])
    y[-23] <- scale(y[-23])
    
    # plot shows the outlier
    qplot(x, y, alpha = 0.5)
    
    # outlier makes it appear there is correlation
    cor(x,y) #the correlation is high just because of the one outlier
    cor(x[-23], y[-23])
    
    # use rank instead
    qplot(rank(x), rank(y))
    cor(rank(x), rank(y))
    
    # Spearman correlation with cor function
    cor(x, y, method = "spearman")
    
    
  #Cause and effect reversal
    
    #We know that logically x causes y but y causes x can be a technically correct models with significant p-value
    #However the interpretation of such model will be wrong
    #For example
    #Genetically we can say that father's height causes son's height
    #not the other way round
    #However we can build a reverse model which is technically correct but wrongly interpreted
    
    
    # cause and effect reversal using son heights to predict father heights
    library(HistData)
    data("GaltonFamilies")
    GaltonFamilies %>%
      filter(childNum == 1 & gender == "male") %>%
      select(father, childHeight) %>%
      rename(son = childHeight) %>% 
      do(tidy(lm(father ~ son, data = .)))
    
    #here we have a small p-value indicating that our model is significant
    
    
  
  #Confounding effect
    
    #When the correlation between x and y is affected by a third variable z
    #As seen in the baseball example, the HR effects the relation between BB and R
    #The confounding variable must be identified and it's effect on x and y must be reduced
    #The confounding variable is stratified and then the causal relationship between x and y is checked again
    
    
    # UC-Berkeley admission data
    library(dslabs)
    data(admissions)
    admissions
    
    # percent men and women accepted
    admissions %>% group_by(gender) %>% 
      summarize(percentage = 
                  round(sum(admitted*applicants)/sum(applicants),1))
    
    # test whether gender and admission are independent
    admissions %>% group_by(gender) %>% 
      summarize(total_admitted = round(sum(admitted / 100 * applicants)), 
                not_admitted = sum(applicants) - sum(total_admitted)) %>%
      select(-gender) %>% 
      do(tidy(chisq.test(.)))
    #the p-value tells us that admission is gender biased
    #Now lets observe percent admission by majors
    
    # percent admissions by major
    admissions %>% select(major, gender, admitted) %>%
      spread(gender, admitted) %>%
      mutate(women_minus_men = women - men)
    
    # plot total percent admitted to major versus percent women applicants
    admissions %>% 
      group_by(major) %>% 
      summarize(major_selectivity = sum(admitted * applicants) / sum(applicants),
                percent_women_applicants = sum(applicants * (gender=="women")) /
                  sum(applicants) * 100) %>%
      ggplot(aes(major_selectivity, percent_women_applicants, label = major)) +
      geom_text()
    
    # plot number of applicants admitted and not
    admissions %>%
      mutate(yes = round(admitted/100*applicants), no = applicants - yes) %>%
      select(-applicants, -admitted) %>%
      gather(admission, number_of_students, -c("major", "gender")) %>%
      ggplot(aes(gender, number_of_students, fill = admission)) +
      geom_bar(stat = "identity", position = "stack") +
      facet_wrap(. ~ major)
    
    admissions %>% 
      mutate(percent_admitted = admitted * applicants/sum(applicants)) %>%
      ggplot(aes(gender, y = percent_admitted, fill = major)) +
      geom_bar(stat = "identity", position = "stack")
    
    # condition on major and then look at differences
    admissions %>% ggplot(aes(major, admitted, col = gender, size = applicants)) + geom_point()
    
    # average difference by major
    admissions %>%  group_by(gender) %>% summarize(average = mean(admitted))
    
    
    #This effect is called Simpson paradox
    
    
    ?admissions
    0.05*1000000     
    