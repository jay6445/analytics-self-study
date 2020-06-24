#vector indexing functions
# there are three main indexing functions
# which() match() and %in%
library(dslabs)
data("murders")

#to check and get index of single element we use which()
#which() tells you the true entry indexes in a vector
which(murders$state == "Alaska")
#this function got the second state as true to match our condition so it returns the index of the state

#to check and get indexes of multiple entries we use match()
#match() compares two vectors and returns the indexes of the matched elements
match(c("Alaska","California","Columbia","Dakota"),murders$state)

#therefore it compares two vectors and tells us which of the elements in our vector actually come under state and the rest are NA

#to check and obtain the answer in true false we use %in% instead of match()
# %in% tells us whether a vector is a subset of the other

x <- c("a","b","c","d","e","f","g","h")
y <- c("e","f","g","")

y %in% x


#function assessment question stuck for 30 mins

# Store the 5 abbreviations in abbs. (remember that they are character vectors)
abbs <- c("MA", "ME", "MI", "MO", "MU") 

# Use the `which` command and `!` operator to find out which index abbreviations are not actually part of the dataset and store in `ind`
abbs%in%murders$abb
ind <- which(abbs%in%murders$abb != TRUE) # got the index of the element not part of abbs
# Names of abbreviations in `ind`
abbs[ind]

#functions the give             
#output as indexes
which()
order()
match()
which.max()
which.min()
vector1 <- vector <= 100 #logical operations pon vectors

#functions that give logical output(True/false)
is.na()
is.numeric() #etc
vector1 %in% vector2