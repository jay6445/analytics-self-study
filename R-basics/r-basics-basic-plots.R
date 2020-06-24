#plotting of different graphs using R
data("murders")
murders <- murders %>% mutate(rate = total/population * 100000)
murders
murder_rate <- murders$rate
total_murders <- murders$total
#plot() function is used to create a scatter plot
plot(murder_rate,total_murders)
murders$state[which.max(murders$rate)]

#hist() function is used to create a histogram
hist(murder_rate)

#boxplot function is used for a boxplot
#arguments of boxplot(column1~column2,data=tablename)

boxplot(rate~region,data=murders)

# Create a boxplot of state populations by region for the murders dataset
boxplot(population~region,data=murders)
     