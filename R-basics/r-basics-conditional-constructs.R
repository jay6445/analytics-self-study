#conditional constructs
#if-else
library(dslabs)
data(murders)

murder_rate <- murders$total/murders$population*100000
murders
#if-else
ind <- which.min(murder_rate)
ind
murder_rate[46]

if(murder_rate[ind] < 0.5)
{
  print(murders$state[ind])
}else{
  print("No state has that low rate")
}

#above operation can also be performed using ifelse() function

ifelse(murder_rate[ind]<0.5,murders$state[ind],"none")
#ifelse(condition,ifsatisfied,ifnotsatisfied)

# any() function returns true if atleast one element in the vector satisfies the condition
any(murder_rate >=3)

# all() function returns true if all the elements in the vector satisfy the condition
all(murder_rate > 1)



