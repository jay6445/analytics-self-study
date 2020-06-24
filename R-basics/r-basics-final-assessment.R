library(dslabs)
data(heights)

#Write an ifelse() statement that returns 1 if the sex is Female and 2 if the sex is Male.
#What is the sum of the resulting vector?
sum(ifelse(heights$sex == 'Female',1,2))

#Write an ifelse() statement that takes the height column and returns the height if it is greater than 72 inches and returns 0 otherwise.
#What is the mean of the resulting vector?

mean(ifelse(heights$height > 72,heights$height,0))

#Write a function inches_to_ft that takes a number of inches x and returns the number of feet. One foot equals 12 inches.
#What is inches_to_ft(144)?

inches_to_ft <-function(x){
  x/12
}
inches_to_ft(144)
sum(inches_to_ft(heights$height)<5)

#Given an integer x, the factorial of x is called x! and is the product of all integers up to and including x. 
#The factorial() function computes factorials in R. For example, factorial(4) returns 4! = 4 × 3 × 2 × 1 = 24.

# define a vector of length m
m <- 10
f_n <- vector(length = m)

# make a vector of factorials
for(n in 1:m)
{
  f_n[n] <- factorial(n)
}

# inspect f_n
f_n