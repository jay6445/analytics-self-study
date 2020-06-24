#differences between data frames and tibbles
#1 : tibbles are much more readable

library(Lahman)
      Teams #barely readable df
      
      #display Teams as tibble
      
      as.tibble(Teams)

#2 : if we subset a dataframe we get objects of other type, with tibbles we always get a tibble
      
      Teams[,20] %>% class() #integer
      
      as.tibble(Teams[,20]) %>% class() #we get tibble as a subset too
      
#3 : Tibble gives a warning if the column refrenced does not exist, unlike just NULL with df
      
      Teams$hr
      
      as.tibble(Teams$hr)

#4 : a tibble can contain complex objects like functions or lists
      
      
      tibble(id = c(1, 2, 3), func = c(mean, median, sd))
      