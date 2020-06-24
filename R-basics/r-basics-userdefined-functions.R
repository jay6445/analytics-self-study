#functions in R
data("heights")
heights

#function() is used to define a new function is R
#the variables declared inside the function does not affect the variables in the workspace

#function to plot a scatter plot with sex to heights
sex_to_height_plot <- function(){
  
  boxplot(height~sex,data = heights)
  
}
#calling the function
sex_to_height_plot()

#function that returns female or male average height depending on use input of sex
#in this function we will be setting a default value for sex as "Female"
mean(heights$height[which(heights$sex == "Female")])
heights$height[which(heights$sex == "Male")]

avg_height <- function(sex="Female"){
  ifelse(sex=="Female",mean(heights$height[which(heights$sex == "Female")]),mean(heights$height[which(heights$sex == "Male")]))
}
#this function returns female average height by default
avg_height()


# functions can have multiple arguments as well as default values
avg <- function(x, arithmetic = TRUE){
  n <- length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}
