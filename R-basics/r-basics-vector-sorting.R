#vector sorting
#sort function is used to sort the data from min to max
library(dslabs)
data("murders")
str(murders)
#sorting states acc to total murders
sort(murders$total)

#indexs of the ordered elements is obtained using order
s <- order(murders$total)

#displaying the state names using the above sorted index of total murders
murders$state[s]

#maximum murder value can be found using max function
max(murders$total)
#index of max value can be obtained as 
which.max(murders$total)

#similarly min value can be obtained using min function
min(murders$total)
which.min(murders$total)

#Ranks can be obtained using rank function where rank 1 is assigned to smallest value and so on
rank(murders$total)
#ranks can be given to largest to smallest by mentioning a negative symbol to the parameter
rank(-murders$total)

#assessment for sorting

# Define a variable states to be the state names from the murders data frame
states <- murders$state

# Define a variable ranks to determine the population size ranks 
ranks <- rank(murders$population)

# Define a variable ind to store the indexes needed to order the population values
ind <- order(murders$population)
ind
# Create a data frame my_df with the state name and its rank and ordered from least populous to most 
my_df <- data.frame(states = states[ind],ranks = ranks[ind])
my_df

#mean function is used to calculate the average of numeric vector
mean(murders$population)

data("na_example")
mean("na_example") #returns NA
#while calculating mean of a vector we might get NA if it comes across atleast one NA in the vector
#in order to exclude the NA from the vector we use is.na function that returns a logical vector
index_of_NA <- is.na(na_example) # we have the indexes of the NAs
index_of_NA
# ! operator is used to exclude the NA from the vector

mean(na_example[!index_of_NA])
#2.301754

#practice
#display the states in the increasing order of their murders in a single line
murders$state[order(murders$total,decreasing = TRUE)] #decreasing = TRUE for descending FALSE for ascending

#create a data frame with states, population and total murders in decreasing order of murders
my_df1 <-data.frame(states = murders$state[order(murders$total,decreasing = TRUE)] , population = murders$population[order(murders$total,decreasing = TRUE)], total_murders = murders$total[order(murders$total,decreasing = TRUE)]) 
my_df1
