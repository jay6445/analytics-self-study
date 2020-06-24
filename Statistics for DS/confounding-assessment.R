#Confounding assessment

library(dslabs)
data("research_funding_rates")
research_funding_rates

research_funding_rates %>% mutate(total_men_not_awarded = sum(applications_men) - sum(awards_men))

research_funding_rates %>% mutate(total_women_not_awarded = sum(applications_women) - sum(awards_women))


dataFrame <- data.frame(gender= c("men","women"),awarded = c(sum(research_funding_rates$awards_men),sum(research_funding_rates$awards_women)),
           not_awarded = c(sum(research_funding_rates$applications_men) - sum(research_funding_rates$awards_men), sum(research_funding_rates$applications_women) - sum(research_funding_rates$awards_women))
           ,total = c(sum(research_funding_rates$applications_men),sum(research_funding_rates$applications_women)))

(290/1635)*100           
(177/1188)*100

dataFrame <- dataFrame %>% mutate(success_rates = c(sum(research_funding_rates$success_rates_men),sum(research_funding_rates$success_rates_women)))
dataFrame

chi_square <- dataFrame %>% select(-gender) %>% chisq.test()

tidy(chi_square)

two_by_two <-data.frame(awarded = c("no", "yes"), 
                         men = c(sum(research_funding_rates$applications_men) - sum(research_funding_rates$awards_men), sum(research_funding_rates$awards_men)),
                         women = c(sum(research_funding_rates$applications_women) - sum(research_funding_rates$awards_women), sum(research_funding_rates$awards_women)))

 two_by_two                       
 chi_square <- two_by_two %>% select(-awarded) %>% chisq.test()
 tidy(chi_square)
 
 
 dat <- research_funding_rates %>% 
   mutate(discipline = reorder(discipline, success_rates_total)) %>%
   rename(success_total = success_rates_total,
          success_men = success_rates_men,
          success_women = success_rates_women) %>%
   gather(key, value, -discipline) %>%
   separate(key, c("type", "gender")) %>%
   spread(type, value) %>%
   filter(gender != "total")
 
 dat
 
 dat %>%  ggplot(aes(discipline,success,col = gender, size = applications )) + geom_point() 
