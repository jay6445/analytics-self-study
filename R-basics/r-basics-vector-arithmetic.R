#vector arithmetic operations
#aritmetic operations applies to every element in the vector
library(dslabs)
data("murders")

#we obtain the state with the most number of murders
murders$state[which.max(murders$total)] 

#however it is unfair to compare California just because it has the highest murder numbers
#as it also has highest populationn, Therefore we calculate the murder rate of each state using the
#arithmetic operation
murder_rate <- (murders$total/murders$population)*100000
length(murder_rate)
#create a data frame with states ordered from highest rate to lowest
ind <- order(murder_rate,decreasing = TRUE)
length(ind)
length(murders$state)
rate_df <- data.frame(states = murders$state[ind], population = murders$population[ind], total_murders = murders$total[ind], rate = murder_rate[ind])
rate_df
