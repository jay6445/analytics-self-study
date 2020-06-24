#indexing of vectors based on conditions
#we can find the indexes of states having murder rates less than or equal to 1 using logical operators

library(dslabs)
data(murders)
murders$rates <- (murders$total/murders$population) * 100000
murders
levels(murders$region)

#find all the states where region is West and murder rate is <= 1

rate <- murders$rates <= 1 #gives a logical output
sum(rate) # as true and false get converted to 1 and 0 it can be added
region <- murders$region == "West"
region
index <- rate & region #we use the & operator as both our conditions need to be satisfied
# true & true = true
# true & false = false
# false & false = false

murders$state[index]
