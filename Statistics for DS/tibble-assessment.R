#assessment on tibbles

#We have investigated the relationship between fathers' heights and sons' heights. But what about other parent-child relationships? 
#Does one parent's height have a stronger association with child height? How does the child's gender affect this relationship in heights? 
#Are any differences that we observe statistically significant?
#The galton dataset is a sample of one male and one female child from each family in the GaltonFamilies dataset. The pair column denotes whether
#the pair is father and daughter,father and son, mother and daughter, or mother and son.

#Create the galton dataset using the code below:

library(tidyverse)
library(HistData)
data("GaltonFamilies")
GaltonFamilies

set.seed(1) # if you are using R 3.5 or earlier
set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later

    galton <- GaltonFamilies %>%
      group_by(family, gender) %>%
      sample_n(1) %>%
      ungroup() %>% 
      gather(parent, parentHeight, father:mother) %>%
      mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
      unite(pair, c("parent", "child"))
galton



#Group by pair and summarize the number of observations in each group.

#How many father-daughter pairs are in the dataset?
  
    galton %>% group_by("pair") %>% filter(pair == "father_daughter") %>% summarize(s = length(pair))  

#How many mother-son pairs are in the dataset?

    galton %>% group_by("pair") %>% filter(pair == "mother_son") %>% summarize(s = length(pair))  
    
    
#Calculate the correlation coefficients for fathers and daughters, fathers and sons, mothers and daughters and mothers and sons.
#Which pair has the strongest correlation in heights?    
    library(broom)  
    library(tidyverse)
    library() 
 
  #first I tried plotting the conditions on a scatter plot with regression line showing confidence intervals
    
    p1 <- GaltonFamilies %>% mutate(child = ifelse(gender=="male","son","daughter"))%>% filter(child == "daughter") %>% group_by(family) %>%  ggplot(aes(father,childHeight)) + geom_point(alpha = 0.5) + geom_smooth(method = "lm")
    p2 <- GaltonFamilies %>% mutate(child = ifelse(gender=="male","son","daughter"))%>% filter(child == "son") %>% group_by(family) %>%  ggplot(aes(father,childHeight)) + geom_point(alpha = 0.5) + geom_smooth(method = "lm")
    p3 <- GaltonFamilies %>% mutate(child = ifelse(gender=="male","son","daughter"))%>% filter(child == "daughter") %>% group_by(family) %>%  ggplot(aes(mother,childHeight)) + geom_point(alpha = 0.5) + geom_smooth(method = "lm")
    p4 <- GaltonFamilies %>% mutate(child = ifelse(gender=="male","son","daughter"))%>% filter(child == "son") %>% group_by(family) %>%  ggplot(aes(mother,childHeight)) + geom_point(alpha = 0.5) + geom_smooth(method = "lm")
    
    library(gridExtra)
    
    grid.arrange(p1,p2,p3,p4)
    
  #then I tried creating a tibble using family groups and inputting it to correlation function 
  #such that I get correlation separately for each family, which makes sense due to genetics
    
    GaltonFamilies %>% mutate(child = ifelse(gender=="male","son","daughter"))%>% filter(child == "daughter") %>% group_by(family) %>% do(data.frame(c = cor(.$father,.$childHeight)))
    warning()
    
    dataset <- GaltonFamilies %>% mutate(child = ifelse(gender=="male","son","daughter"))
    
    as.data.frame(dataset) %>% filter(child == "son")  %>% summarise(cor(father,childHeight)) #0.3923835
    as.data.frame(dataset) %>% filter(child == "daughter")  %>% summarise(cor(father,childHeight)) #0.428433
    as.data.frame(dataset) %>% filter(child == "daughter")  %>% summarise(cor(mother,childHeight)) #0.3051645
    as.data.frame(dataset) %>% filter(child == "son")  %>% summarise(cor(mother,childHeight)) #0.323005
    
    
    as.data.frame(dataset) %>% filter(child == "son")  %>% lm(childHeight ~ father,data=.) # 0.4465
    as.data.frame(dataset) %>% filter(child == "daughter")  %>% lm(childHeight ~ father,data=.) # 0.3813 
    as.data.frame(dataset) %>% filter(child == "son")  %>% lm(childHeight ~ mother,data=.)  #0.3651
    as.data.frame(dataset) %>% filter(child == "daughter")  %>% lm(childHeight ~ mother,data=.) #0.3182
    
    
    dataset %>% filter(child == "daughter") 
    GaltonFamilies %>% mutate(child = ifelse(gender=="male","son","daughter"))%>% filter(child == "son") %>% group_by(family)

    as.data.frame(dataset) %>% filter(child == "daughter") %>% summarise(cor(father,childHeight))
  
 #Ultimately I found the way to filter the galton families and apply correlation
    # after grouping according to family, sample_n() function randomly picks a daughter or a son from a family
    # So that we ultimately have a single entry per family
    set.seed(1983)  
    galton_heights_s <- GaltonFamilies %>%
      filter(gender == "male") %>%
      group_by(family) %>%
      sample_n(1) %>%
      ungroup() %>%
      select(father,mother,childHeight) %>%
      rename(son = childHeight)
    
    galton_heights %>% summarise(cor(father,son)) #0.447 correlation between father and son
    galton_heights %>% summarise(cor(mother,son)) #0.256 correlation between mother and son
    
    galton_heights_d <- GaltonFamilies %>%
      filter(gender == "female") %>%
      group_by(family) %>%
      sample_n(1) %>%
      ungroup() %>%
      select(father,mother,childHeight) %>%
      rename(daughter = childHeight)

    galton_heights %>% summarise(cor(father,daughter)) #0.427 correlation between father and daughter
    galton_heights %>% summarise(cor(mother,daughter)) #0.363 correlation between mother and daughter
  

    
#Use lm() and the broom package to fit regression lines for each parent-child pair type. 
#Compute the least squares estimates, standard errors, confidence intervals and p-values for the parentHeight coefficient for each pair.          

library(broom)        



    library(tidyverse)
    library(HistData)
    data("GaltonFamilies")
    set.seed(1) # if you are using R 3.5 or earlier
    set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later
    galton <- GaltonFamilies %>%
      group_by(family, gender) %>%
      sample_n(1) %>%
      ungroup() %>% 
      gather(parent, parentHeight, father:mother) %>%
      mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
      unite(pair, c("parent", "child"))     

    galton %>% filter(pair == "father_daughter") %>% do(tidy(lm(childHeight~parentHeight ,data=.),conf.int = TRUE)) 
    galton %>% filter(pair == "mother_son") %>% do(tidy(lm(childHeight ~ parentHeight ,data=.),conf.int = TRUE)) 
    galton %>% filter(pair == "mother_daughter") %>% do(tidy(lm(childHeight ~ parentHeight ,data=.),conf.int = TRUE))
    galton %>% filter(pair == "father_son") %>% do(tidy(lm(childHeight ~ parentHeight ,data=.),conf.int = TRUE))
    

    
    galton %>%  
      group_by(pair) %>%
      do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE)) %>%
      select(pair, estimate, conf.low, conf.high) %>%
      ggplot(aes(pair, y = estimate, ymin = conf.low, ymax = conf.high)) +
      geom_errorbar() +
      geom_point()
    
