#inferential statistics
#inference about population from a sample

#Calculate the mean and the standard error of the dataset
#Determine which statistic to use for inference
#Find the appropriate statistic, taking into consideration the degrees of freedom (if applicable) for 99% confidence
#Find the 99% confidence interval


  dataset <- c(75000,78000,80000,89500,90000,96000,102300,105000,117000)
  mean(dataset) #92533.33
  #std deviation
  std(dataset) #13135.11 
  #std error
  std_err <- std(dataset)/sqrt(length(dataset))#4378.37
  std_err
  t_score <- 3.355
  nx <- mean(dataset) - t_score * std_err
  px <- mean(dataset) + t_score * std_err
  nx
  px
  #confidence interval [77843.9,107222.8]
  
  
#Calculate the 99% confidence interval

  le <- 100
  lm <- 70
  dmean <- -7
  dstd <- 1.16
  
  #standard error for independent samples with known population variances
  std_err <- sqrt((10^2/100)+(5^2/70))
  std_err
  z_score <- 2.58 
  nx <- dmean - z_score * std_err 
  nx
  px <- dmean + z_score * std_err    
  px
  #confidence interval [-10.00561,-3.994391]

#You have the same datasets from the lesson.
#Calculate the 90% confidence interval
#Compare the result with the 95% confidence interval from the lesson
#unknown population variances and independent samples
  
  ny_apples <- c(3.62,3.76,3.8,3.87,3.98,3.99,3.99,4.02,4.13,4.25) 
  la_apples <- c(3.02,3.02,3.06,3.15,3.22,3.24,3.44,3.81)
  
  #pooled variance
  p_var <- ((length(ny_apples)-1)*var(ny_apples) + (length(la_apples)-1)*var(la_apples))/(length(ny_apples)+length(la_apples)-2)
  p_var #0.05043062

  #standard error
  std_err <- sqrt((p_var^2/length(ny_apples)) + (p_var^2/length(la_apples)))
  std_err  #0.02392135
  length(ny_apples)+length(la_apples)-2
  t_score <- 1.746
  
  dmean <- mean(ny_apples)-mean(la_apples)
  
  nx <- dmean - t_score * std_err
  nx
  px <- dmean + t_score * std_err
  px
  #confidence interval [0.6542333,0.7377667]
  
  