#Covid-19 data
install.packages("jsonlite", repos="https://cran.rstudio.com/")
library("jsonlite")

json_file <- 'https://datahub.io/core/covid-19/datapackage.json'
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

# get list of all resources:
print(json_data$resources$name)

# print all tabular data(if exists any)
for(i in 1:length(json_data$resources$datahub$type)){
  if(json_data$resources$datahub$type[i]=='derived/csv'){
    path_to_file = json_data$resources$path[i]
    data <- read.csv(url(path_to_file))
    print(data)
  }
}

#get all the resource paths
json_data$resources$path

#store the dataframe needed in a local variable
covidts <- read.csv(url("https://pkgstore.datahub.io/core/covid-19/time-series-19-covid-combined_csv/data/31abdab5b8c984c168e25635ffcfc703/time-series-19-covid-combined_csv.csv"))
covidts

covr(covidts$Confirmed,covidts$Deaths)

as.numeric(covidts$Confirmed)
class(covidts$Deaths)
class(covidts$Confirmed)

library(dplyr)

#filtering only India data
covidts <- covidts %>% filter(Country.Region == "India")
covidts
#find the correlation coefficient between confirmed cases and deaths and it's a strong one at 0.9988143
cor(covidts$Confirmed,covidts$Deaths)
plot(covidts$Confirmed,covidts$Deaths)
covidts$Confirmed
print(covidts$Deaths)
hist(covidts$Deaths)
