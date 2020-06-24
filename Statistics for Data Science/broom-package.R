#The broom package has three main functions
# tidy() glance() augment()
#tidy() returns a data frame containing the coefficients of the function passed in it

dat %>% lm(R ~ BB,data= .) #here object of lm is returned
dat %>% do(tidy(lm(R ~ BB,data=.))) #here a tibble/data.frame is returned


#using tidy with cor() function

str(dat)
dat %>% do(tidy(var(R,HR)))

           