#the do() function

#When we use a group_by() it returns a tibble instead of a data frame and functions like lm() 
#does not recognize groups and treats the output of group_by as a single data frame

  GaltonFamilies %>% group_by('family','gender') %>% summarise(cor(father,childHeight)) #here a single result is returned as the group_by is ignored
  
  GaltonFamilies %>% group_by('family','gender') %>% tidy(lm(father~childHeight,data=.)) #we use the do() function to bridge the gap between R function and tidyverse functions
  
  #Note : the function inside the do() function must always return an object of type data.frame 
  
  