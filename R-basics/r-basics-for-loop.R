#for loop in R

#create a function to return the summation of a number sequence

summation <- function(n){
  x <- seq(1,n)
  sum(x)
  
}
summation(100) #we can substitute n and get the summation

#if we want to repeat this process for m variables
#we can use a for loop

#store all the summation values in an empty vector
m <-100 
summation_vector <- vector(length = m)

for(n in 1:m)
{
  summation_vector[n] <- summation(n)
}

#plotting the integers against their summations
plot(1:m,summation_vector)
lines(1:m,summation_vector)


#checking the plot using the actual formula for summation
n <-1:m
plot(n,n*(n+1)/2)
lines(n,n*(n+1)/2)
#gives same result as above