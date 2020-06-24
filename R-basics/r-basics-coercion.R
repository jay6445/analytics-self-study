#coercion feature of R
x <- c(1,"Canada",3) #no error or warning because R assumes we were creating a character vector, this property is called coercion
x #everything has been converted to characters in the above vector
class(x)

#To convert the data type of vector we use as function
y <- as.numeric(x)

# as you see there is a warning here as R did not know what to do with the character Canada
#Warning message:
  #NA introduced by coercion 
#R introduces NA as a replacement
print(y)

y %in% x
ind = which(y %in% x != FALSE)
ind = which(is.na(y) != TRUE)
x[ind]
