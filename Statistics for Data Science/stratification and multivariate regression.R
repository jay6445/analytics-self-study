#baseball example

#slope for RR vs base on balls

  Teams %>% lm(run_rate ~ bb_rate, data = .) 
# slope = 0.7353 intercept = 1.9323

  Teams

  Teams %>% ggplot(aes(bb_rate,run_rate))+ geom_point(alpha=0.5) + geom_abline(slope = 0.7353,intercept =1.9323)
  Teams %>% summarize(cor(run_rate,bb_rate))
  #correlation coefficient is 0.5502086

#slope for RR and home runs

  Teams %>% mutate(hr_rate = HR/G) %>% lm(run_rate~hr_rate,data=.)

#slope = 1.845 intercept = 2.778
  
  Teams %>% ggplot(aes(hr_rate,run_rate)) + geom_point(alpha = 0.5) + geom_abline(slope = 1.845, intercept = 2.778)
  
  Teams %>% summarize(cor(hr_rate,run_rate))
  #correlation is 0.7615597

#both the above relationships tell that more runs are related to more bb and hr
  #however by applying logic we find that bb is caused by Hr and not the opposite
  
  