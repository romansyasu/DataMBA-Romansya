# Title : Twitter API Scraping
# Author : Romansya
# Date : August 21, 2019
# Objective : To scrap Twitter with its API

# Load package
library(rtweet)

# API Authorization
token <- create_token(
  consumer_key = "secret",
  consumer_secret = "secret",
  access_token = "secret",
  access_secret = "secret"
)

# Crawling Data from Twitter

#Looking for tweets with popular hashtag #SaveSpiderMan (trending August 21, 2019 with >150K tweets), we took only 10K tweets
cuit <- search_tweets(q='#SaveSpiderMan', n = 10000)

#Get to know the column names of tweets
colnames(cuit)
dim(cuit)

#Take some variables
cuitcuit <- cuit[,c('user_id','created_at','screen_name','text','retweet_count')]

# Write to csv file
write.csv(cuitcuit, 'RSU_PopularTweets.csv')
