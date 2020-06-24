
library(dslabs)
library(dplyr)
data(murders)
#variance for sample data
        var <- function(x){ #will take vector as an input
          var<-0
          for (i in 1:length(x)) {
            var <- var + ((x[i]-mean(x))^2)/length(x)-1  
          }
          print(var)
        } 
sort(murders$total)
var(murders$total)

#standard deviation for sample data
        std <-function(x){
          std<-0
          for(i in 1:length(x))
          {std <- std + (x[i]-mean(x))^2/length(x)
          }
          std <- sqrt(std)
          print(std)
        }

#coffecient of variance or relative standard deviation
        rstd <- function(x){
          rstd<-0
          for(i in 1:length(x))
          {rstd <- rstd + (x[i]-mean(x))^2/length(x)-1
          }
          rstd <- sqrt(rstd)/mean(x)
          print(rstd)
        }

#covariance
        covr <- function(x,y){
          cov <- 0
          for(i in length(x))
          {cov <- cov + (x[i]-mean(x))*(y[i]-mean(y))/(length(x)-1)}
          print(cov)
        }
covr(murders$total,murders$population)
cov(murders$total,murders$population)
#correlation coefficient

        corc <- function(x,y)
        {
          stdx <- 0
          stdy <- 0
          cov <- 0
          #calculate covariance
          for(i in length(x))
          {cov <- cov + (x[i]-mean(x))*(y[i]-mean(y))}
          
          #standard deviation for x
          for(i in 1:length(x))
          {stdx <- stdx + (x[i]-mean(x))^2/(length(x)-1)
          }
          #stdx <- sqrt(stdx)
          
          #standard deviation for y
          for(i in 1:length(x))
          {stdy <- stdy + (y[i]-mean(y))^2/(length(y)-1)
          }
          #stdy <- sqrt(stdy)
          
          #correlation coefficient
          corc <- cov/sqrt(stdx*stdy)
          print(corc)
        }
corc(murders$total,murders$population)
cor(murders$total,murders$population)

sd(murders$total)
std(murders$total)

#pooled variance
          p_var <- function(x,y){
            p_var <- ((length(x)-1)*var(X) + (length(y)-1)*var(y))/(length(x)+length(y)-2)
            print(p_var)
          }
