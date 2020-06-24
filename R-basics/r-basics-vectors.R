#defining a vector
#vector is created by using the concatenate function c
codes <- c(130,480,777)
class(codes) #numeric vector
country <- c("India","Canada","UK")

#codes can be assigned country names by using the names function
names(codes) <- country
codes

#vectors can be assigned names directly as follows
codes <- c(India=130,Canada=480,UK=777) #double quotes not needed
codes

#sequence function
seq(1,10,2) #seq(initial,limit,step)
#or 1:10
#one more important argument is length.out which predefines the sequence length
seq(0,100,length.out = 5)



#calling particular elements from vector
codes[2]
codes["India"]
codes[1:2]
codes[seq(1,3,2)]
codes[c(1,3)]
codes[c("India","UK")]

#vectors can be combined to make a data frame
data(murders)
states <- murders$state #creates vector for state names
population <- murders$population #creates vector for population
#now lets create a date frame
my_df <- data.frame(state = states,population = population)
my_df

