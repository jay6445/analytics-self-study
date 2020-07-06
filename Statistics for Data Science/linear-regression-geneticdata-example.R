#historical data as to how heridaty plays a role in the next generation heights

# create the dataset
library(tidyverse)
install.packages("HistData")
library(HistData)
data("GaltonFamilies")
set.seed(1983)
galton_heights <- GaltonFamilies %>%
  filter(gender == "male") %>%
  group_by(family) %>%
  sample_n(1) %>%
  ungroup() %>%
  select(father, childHeight) %>%
  rename(son = childHeight)

# means and standard deviations
galton_heights %>%
  summarize(mean(father), sd(father), mean(son), sd(son))

#summarize function()
?summarise
# scatterplot of father and son heights
galton_heights %>%
  ggplot(aes(father, son)) +
  geom_point(alpha = 0.5)

#correlation coefficient for father's and son's height

ggplot(galton_heights,aes(father,son)) + geom_point(alpha= 0.5)


rho <- mean(scale(galton_heights$father)*scale(galton_heights$son))
rho
galton_heights %>% summarize(r = cor(father, son)) %>% pull(r)

#rho is the symbol for correlation coefficient
cor(w_salary[1:62],b_salary) #correlation coefficient function
length(b_salary)
ggplot(data.frame(w_salary[1:62],b_salary),aes(w_salary[1:62],b_salary))+geom_point(alpha=0.5)

#correlation between fathers height and sons height
cor(galton_heights$father,galton_heights$son) #positive for sure but not a strong one


#take a sample of 25 pairs from the population 
# compute sample correlation
R <- sample_n(galton_heights, 25, replace = TRUE) %>%
  summarize(r = cor(father, son))
R
sample_n(galton_heights, 25, replace = TRUE)


#now we will create a simulation to find the correlation if the sample size was 1000
#we will use the monte carlo simulation

# Monte Carlo simulation to show distribution of sample correlation for a sample of 1000
B <- 1000
N <- 41
R <- replicate(B, {
  sample_n(galton_heights, N, replace = TRUE) %>%
    summarize(r = cor(father, son)) %>%
    pull(r)

  })
R
qplot(R, geom = "histogram", binwidth = 0.05, color = I("black"))

# expected value and standard error
mean(R)
sd(R)

# QQ-plot to evaluate whether N is large enough
data.frame(R) %>%
  ggplot(aes(sample = R)) +
  stat_qq() +
  geom_abline(intercept = mean(R), slope = sqrt((1-mean(R)^2)/(N-2)))

?replicate

qplot(galton_heights$father , geom='histogram', color=I("black"), bins = 15)
qplot(galton_heights$son , geom='histogram', color=I("black"))

galton_heights$father1 = (galton_heights$father - min(galton_heights$father))/ max(galton_heights$father)- min(galton_heights$father) 
qplot(galton_heights$father1 , geom='histogram', color=I("black") , bins = 15)
qplot(galton_heights$father , geom='histogram', color=I("black"), bins = 15)

mean(galton_heights$father)
var(galton_heights$father)

summary(mean = mean(galton_heights$father) , var = var(galton_heights$father))
69.09888 + 6.484943
max(galton_heights$father)
range(galton_heights$father)
std(galton_heights$father)/mean(galton_heights$father)
sqrt(6.484943)

galton_heights$father
