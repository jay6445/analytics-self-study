#assessment 3

library(dslabs)
library(dplyr)
data(heights)
options(digits = 3) 
heights
str(heights)
mean(heights$height)
#mean height is 68.3
ind <- heights$height > mean(heights$height) & heights$sex == "Female"
length(heights$height[ind])


#If you use mean() on a logical (TRUE/FALSE) vector, it returns the proportion of observations that are TRUE.
#What proportion of individuals in the dataset are female?

mean(heights$sex == 'Female')

heights$sex == 'Female'

class(min(heights$height))

#Use the match() function to determine the index of the first individual with the minimum height.
match(min(heights$height),heights$height)
heights$height[match(min(heights$height),heights$height)]

heights$sex[1032]

#This question takes you through three steps to determine how many of the integer height values between the minimum and maximum heights are not actual heights of individuals in the heights dataset.

max(heights$height)L
class(50L)

int <- heights$height >= 50 & heights$height <= 60 & is.numeric(heights$height) == TRUE 
int
heights$height[int]
x <- heights$height[which.min(heights$height):which.max(heights$height)] 
x <- heights$height[51:83]
x
y <- 2:90
class(y)
class(x)

x <- seq(10.2,20.8,by = 0.8)
x <- 11:20
x <- min(heights$height):max(heights$height)
x <- ceiling(min(heights$height)):max(heights$height)
class(x)
x
x <- 50:82
sum((x %in% heights$height)!= TRUE)

str(heights)

#Using the heights dataset, create a new column of heights in centimeters named ht_cm. Recall that 1 inch =
#2.54 centimeters. Save the resulting dataset as heights2.

heights2 <- heights %>% mutate(ht_cm = height*2.54)
heights2$ht_cm[18]
mean(heights2$ht_cm)

#Create a data frame females by filtering the heights2 data to contain only female individuals.

female <- heights2 %>% filter(sex == "Female")
str(female)
mean(female$ht_cm)

#The olive dataset in dslabs contains composition in percentage of eight fatty acids found in the lipid fraction of 572 Italian olive oils:
  
library(dslabs)
data(olive)
head(olive)

#Plot the percent palmitic acid versus palmitoleic acid in a scatterplot
palmitic = olive$palmitic
palmitoleic = olive$palmitoleic
plot(log(palmitic,10),log(palmitoleic,10))

#Create a histogram of the percentage of eicosenoic acid in olive
hist(olive$eicosenoic)

#Make a boxplot of palmitic acid percentage in olive with separate distributions for each region.

#Which region has the highest median palmitic acid percentage?
boxplot(palmitic ~ region,data = olive)
