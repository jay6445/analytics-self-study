#creating a data frame using data.frame function
data(murders)

ind <- order(head(murders$population),decreasing = TRUE)
ind

#top 6 highest populated states

top6 <- data.frame(state = murders$state[ind],population = murders$population[ind])
class(top6$state) #as you can see data.frame converts the characters to factor data type

#to prevent this we need to specify an additional argument in the data.frame function
top6 <- data.frame(state = murders$state[ind],population = murders$population[ind],
                   stringsAsFactors = FALSE)
class(top6$state)
#state is character again

# Use nrow() to calculate the number of rows in a table
nrow(murders)

#assessment

#question 1
# add the rate column
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))

# Create a table, call it my_states, that satisfies both the conditions 
my_states <- filter(murders,region %in% c('Northeast','West') & rate < 1)
my_states
# Use select to show only the state name, the murder rate and the rank
select(my_states,state,rate,rank)

#do question 1 in one line using pipe
# Loading the libraries
library(dplyr)
data(murders)

# Create new data frame called my_states (with specifications in the instructions)
my_states <- murders %>% mutate(rate = total/population * 100000,rank = rank(-rate)) %>% filter(region %in% c("Northeast","West") & rate < 1) %>% select(state,rate,rank)
my_states