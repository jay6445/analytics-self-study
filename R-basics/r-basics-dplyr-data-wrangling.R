#data wrangling or manipulation of the dataframe or data table
#we need the dplyr library
library(dplyr)
library(dslabs)
data(murders)

# we use mutate() function to add a new column to a table or a calculated column
#lets add murder rate column to the table murders
new_table <- mutate(murders,rate = (total/population) * 100000)
new_table

#we can use logical operators to select the rows from the table using filter() function
new_table <- filter(new_table,rate <= 0.7)
new_table

#we can select the table column using the select() function
new_table <- select(new_table,state,region,rate)
new_table

#all the above operations required a new temp table to store the output
#We can avoid this by using the pipe %>% operator
#pipe operator plugs in the output of a function directly to the next function

mutate(murders,rate = (total/population) * 100000) %>% filter(rate <= 0.7) %>% select(state,region,rate)
