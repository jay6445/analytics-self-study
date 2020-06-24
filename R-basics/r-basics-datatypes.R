#load dslabs library
library(dslabs)

#load the murderes dataframe
data(murders)

#class function shows the data type of the variable
class(murders)

#str function shows the columns and their data types of the data frame
str(murders)

#to get the total number of values in a column we use length function
length(murders$population)

#we can access a single column of the data frame using $ or '[[]]'
murders$state
murders$population
murders[["state"]]

#we can use the class function to individually find the data type of the column of the data frame
class(murders$region)

#head function shows the first 6 rows of the data frame
head(murders)

#vector is a data type the stores multiple values
#vector can be numeric, character or logical ie true of false column
class(murders$state)

#factor is another data type which is used when we have selected categorical data to assign
#for example when we record surveys worse,bad,average,good,best,awsome, here we have limited
#categorical data throughout the data set so R assigns numerical data in the background to save memory
class(murders$region)

#in order to view all possible values of the vector data type we use levels function
levels(murders$region)
#number of categorical data
nlevels(murders$region)

#names function returns the column names of the dataframe 
names(murders)

# $ returns a column of the data frame in the form of a vector 
# but if we use [] we can get the column of the data frame as a new data frame
df <- murders["population"]
class(df)

#identical function is used to check if the datatypes of two variables match and it returns a boolean value
identical(a,b)
df
#table function creates a frequency table with first column as variables and second column as it's frequency in the vector
#create table which shows frequency of regions
table(murders$region)


#data type called integers can also be used
#a symbol L is added after a whole number to declare it as an integer
#integers require less space and can provide substantial advantage over numerical data
#however there's no difference apart from memory
3L -3
#now integer vectors can be created without using the concatenate function
intExample <- 1:10
class(intExample)
