# Title : Twitter API Scraping
# Author : Romansya
# Date : August 21, 2019
# Objective : To scrap Twitter with its API

# Load package
library(rtweet)

# API Authorization
token <- create_token(
  consumer_key = "k58rVqg3TkK3YjbUbkgmVbUWS",
  consumer_secret = "QhBAcpJE6mZhItrupnUfogsjiwvfb0NjMY9eoO8wg90B7oQb0R",
  access_token = "572353124-UAP995yM3IDTpzG6ps9NanEtlhQOakoMQRkudPbY",
  access_secret = "oW121PWyFHZwFHG16qtF1lk3tFMzeJxYIptH6Zku2WxBI"
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