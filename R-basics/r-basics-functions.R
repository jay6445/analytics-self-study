# -basics : functions
#we can use help funciton to actually see what a function, operator does in R
help("log")
#or
?"log"
#we can check what arguments a function takes by using the args function
args(log)

#function (x, base = exp(1)) 
#suppose you want to set the logrithmic base to 2 you can set
#the second parameter while calling the function

#nested function
log(exp(1))
#as these are inverse function we get 1
#there are many inbuilt datasets available in R
data() 

#sequence function 
sequence <- seq(1,1000)#creates a sequence of numbers entered as arguments
sum(sequence) # adds all the numbers of the sequence

#alternative to sequence we can also use : symbol to return a sequence
sum(1:1000)

#to see all the variables and functions defined in the workspace
ls()

log(1024,4) #log of 1024 to the base 4

#create a uniformly distributed sample using runif(n,min,max)
  x <- runif(1000,-1,1)
  hist(x,freq = F)
  qplot(x,color=I('black'))

#create a normally distributed sample using the rnorm(n) function

  x <- rnorm(1000)
  hist(x)
  qplot(x,color=I('black'))

#instead of creating the sample and then visualizing the distribution, we can create and visualize it at 
# the same time  
  curve(dnorm(x),add=T) 
  

  
  h <- hist(x, plot=F)
  ylim <- range(0, h$density, dnorm(0))
  hist(x, freq=F, ylim=ylim)
  curve(dnorm(x), add=T)
  
  curve(rnorm(x),add=T)
  
  