#Assessment: Linear Models

library(tidyverse)
library(broom)
library(Lahman)
  Teams_small <- Teams %>% 
    filter(yearID %in% 1961:2001) %>% 
    mutate(avg_attendance = attendance/G)
Teams_small

#Use runs (R) per game to predict average attendance.
      
      fit <- Teams_small %>% mutate(run_rate = R/G) %>% do(tidy(lm(avg_attendance ~ run_rate,data=.) ))
      fit
      
      #For every 1 run scored per game, average attendance increases by how much? 
      #---slope of the line for run_rate

#correlation between runs and attendance
      
      Teams_small %>% mutate(run_rate = R/G) %>% summarize(cor(avg_attendance,run_rate) ) #0.502884

#Use home runs (HR) per game to predict average attendance.
      
      fit1 <- Teams_small %>% mutate(hr_rate = HR/G) %>% do(tidy(lm(avg_attendance ~ hr_rate,data=.)))
      fit1
      
      #For every 1 home run hit per game, average attendance increases by how much?
      #---slope of the line for hr_rate
      
      
#Use number of wins to predict average attendance; do not normalize for number of games.
      
      fit2 <- Teams_small %>% do(tidy(lm(avg_attendance ~ W,data = .)))
      fit2   
      
      #For every game won in a season, how much does average attendance increase?
      #121 slope of the model
      
      #Suppose a team won zero games in a season.
      #Predict the average attendance.
      
#Use year to predict average attendance.
#How much does average attendance increase each year?      
      
      Teams_small
      
      fit3 <- Teams_small %>% group_by(yearID) %>% mutate(avg_attendance_year = mean(avg_attendance))%>% sample_n(1) %>% select(yearID,avg_attendance_year)%>% ungroup() %>% do(tidy(lm(avg_attendance_year ~ yearID, data = .)))
      
      fit3 <- Teams_small %>% group_by(yearID) %>% do(tidy(lm(avg_attendance ~ yearID,data =.))) %>% select(yearID,estimate)%>% ungroup() %>% do(tidy(lm(estimate ~ yearID, data = .)))
      
      fit3 <- Teams_small %>% do(tidy(lm(avg_attendance ~ yearID,data=.)))
      fit3
      
#What is the correlation coefficient for wins and runs per game?
      
      Teams_small %>% summarise(cor(W,R/G))
      
#What is the correlation coefficient for wins and home runs per game?
      
      Teams_small %>% summarise(cor(W,HR/G))

      
#Stratify Teams_small by wins: divide number of wins by 10 and then round to the nearest integer.
#Keep only strata 5 through 10, which have 20 or more data points.
      
      Teams_strata <- Teams_small %>% mutate(W=round(W/10) ) %>% filter(W %in% 5:10 )
      
      Teams_strata %>% filter(W == 8)

    #Calculate the slope of the regression line predicting average attendance given runs per game for each of the win strata.
    #Which win stratum has the largest regression line slope?   
      
      Teams_strata %>% mutate(R =R/G) %>% group_by(W) %>% do(tidy(lm(avg_attendance ~ R,data=.))) %>% filter(term =="R")
      
    #Calculate the slope of the regression line predicting average attendance given HR per game for each of the win strata.
    #Which win stratum has the largest regression line slope?
      
      Teams_strata %>% mutate(HR = HR/G) %>% group_by(W) %>% do(tidy(lm(avg_attendance ~ HR,data=.))) %>% filter(term =="HR")
      
      
#Fit a multivariate regression determining the effects of runs per game, home runs per game, wins, and year on average attendance.
#Use the original Teams_small wins column, not the win strata from question 3.  
      
      fit <- Teams_small %>% mutate(R=R/G, HR=HR/G) %>% do(tidy(lm(avg_attendance ~ R + HR + W + yearID,data=.) ))
      
      fit
      
      #Use the multivariate regression model from Question 4. Suppose a team averaged 5 runs per game, 1.2 home runs per game, and won 80 games in a season.   
      
      #What would this team's average attendance be in 2002?
      R <-5
      HR <-1.2   
      W<-80
      yearID<-2002
      
      #model to predict attendance
      model_inputs <- data.frame(R,HR,W,yearID)
      
      #for predict method the model must be in an lm object format and not a tibble
      
      predict(fit,model_inputs)
      
      
      #What would this team's average attendance be in 1960?
      
      R <-5
      HR <-1.2   
      W<-80
      yearID<-1960
      
      #model to predict attendance
      
      model_inputs <- data.frame(R,HR,W,yearID)
      model_inputs
      
      fit <- Teams_small %>% mutate(R=R/G, HR=HR/G) %>% lm(avg_attendance ~ R + HR + W + yearID,data=.)
      fit
     
      #for predict method the model must be in an lm object format and not a tibble
      
      predict(fit, model_inputs)
      
      
#Use your model from Question 4 to predict average attendance for teams in 2002 in the original Teams data frame.
#What is the correlation between the predicted attendance and actual attendance?
  
  #Using original Teams data set as an input data frame for predict function
      data(Teams)
     Teams %>% filter(yearID ==2002) %>% mutate(R = R/G,HR =HR/G, yearID, avg_attendance = attendance/G) %>% select(R,HR,W,yearID ,avg_attendance) %>% mutate( predicted_attendance = predict(fit,newdata = .)) %>% summarise(cor(avg_attendance,predicted_attendance))
      
     
     Teams %>% filter(yearID ==2002)
     