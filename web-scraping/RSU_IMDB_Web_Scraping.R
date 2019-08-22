# Title : IMDB Web Scraping
# Author : Romansya
# Date : August 19, 2019
# Objective : To scrap IMDB website for the 100 most popular feature films released in 2019

# Loading the rvest package
library(rvest)

# Reading the html code from website
webpage <- read_html('https://www.imdb.com/search/title/?year=2019&title_type=feature&')

# List of columns :

#Rank: The rank of the film from 1 to 100 on the list of 100 most popular feature films released in 2016.
#Title: The title of the feature film.
#Description: The description of the feature film.
#Runtime: The duration of the feature film.
#Genre: The genre of the feature film,
#Rating: The IMDb rating of the feature film.
#Votes: Votes cast in favor of the feature film.
#Gross_Earning_in_Mil: The gross earnings of the feature film in millions.
#Director: The main director of the feature film. Note, in case of multiple directors, I'll take only the first.
#Actor: The main actor of the feature film. Note, in case of multiple actors, I'll take only the first.


# Rankings

#Using CSS selectors to scrap the rankings section
rank_data_html <- html_nodes(webpage, '.text-primary')

#Converting the ranking data to text
rank_data <- html_text(rank_data_html)

#First look of the ranking data
head(rank_data)
length(rank_data)

#Data-Preprocessing: Converting rankings to numerical
rank_data<-as.numeric(rank_data)

#Another look at the ranking data
head(rank_data)
length(rank_data)


# Title

#Using CSS selectors to scrap the title section
title_data_html <- html_nodes(webpage,'.lister-item-header a')

#Converting the title data to text
title_data <- html_text(title_data_html)

#First look of the title data
head(title_data)
length(title_data)


# Description

#Using CSS selectors to scrap the description section
description_data_html <- html_nodes(webpage,'.text-muted+ .text-muted , .ratings-bar+ .text-muted')

#Converting the description data to text
description_data <- html_text(description_data_html)

#First look of the description data
head(description_data)

#Data-Preprocessing: removing '\n'
description_data<-gsub("\n","",description_data)

#Another look of the description data 
head(description_data)
length(description_data)


# Runtime

#Using CSS selectors to scrap the Movie runtime section
runtime_data_html <- html_nodes(webpage,'.runtime')

#Converting the runtime data to text
runtime_data <- html_text(runtime_data_html)

#First look of the runtime data
head(runtime_data)
length(runtime_data)

#Data-Preprocessing: removing mins and converting it to numerical

runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)

#Filling missing entries with NA
for (i in c(4,7,40,41,46)){
  
  a<-runtime_data[1:(i-1)]
  
  b<-runtime_data[i:length(runtime_data)]
  
  runtime_data<-append(a,list("NA"))
  
  runtime_data<-append(runtime_data,b)
  
}

#Convert to numerical again after editing
runtime_data<-as.numeric(runtime_data)

#Another look at the runtime data
head(runtime_data)
length(runtime_data)


# Genre

#Using CSS selectors to scrap the Movie genre section
genre_data_html <- html_nodes(webpage,'.genre')

#Converting the genre data to text
genre_data <- html_text(genre_data_html)

#First look of the genre data
head(genre_data)

#Data-Preprocessing: removing \n
genre_data<-gsub("\n","",genre_data)

#Data-Preprocessing: removing excess spaces
genre_data<-gsub(" ","",genre_data)

#taking only the first genre of each movie
genre_data<-gsub(",.*","",genre_data)

#Convering each genre from text to factor
genre_data<-as.factor(genre_data)

#Another look of the genre data
head(genre_data)
length(genre_data)


# Rating

#Using CSS selectors to scrap the IMDB rating section
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')

#Converting the ratings data to text
rating_data <- html_text(rating_data_html)

#First look of the rating data
head(rating_data)
length(rating_data)

#Filling missing entries with NA
for (i in c(4,7,12,14,22,40,41,46)){
  
  a<-rating_data[1:(i-1)]
  
  b<-rating_data[i:length(rating_data)]
  
  rating_data<-append(a,list("NA"))
  
  rating_data<-append(rating_data,b)
  
}

#Data-Preprocessing: converting ratings to numerical
rating_data<-as.numeric(rating_data)

#Another look of the ratings data
head(rating_data)
length(rating_data)
View(rating_data)


# Votes

#Using CSS selectors to scrap the votes section
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')

#Converting the votes data to text
votes_data <- html_text(votes_data_html)

#First look of the votes data
head(votes_data)
length(votes_data)

#Data-Preprocessing: removing commas
votes_data<-gsub(",","",votes_data)

#Filling missing entries with NA
for (i in c(4,7,12,14,22,40,41,46)){
  
  a<-votes_data[1:(i-1)]
  
  b<-votes_data[i:length(votes_data)]
  
  votes_data<-append(a,list("NA"))
  
  votes_data<-append(votes_data,b)
  
}

#Data-Preprocessing: converting votes to numerical
votes_data<-as.numeric(votes_data)

#Another look of the votes data
head(votes_data)
length(votes_data)


# Gross Earning

#Using CSS selectors to scrap the gross revenue section
gross_data_html <- html_nodes(webpage,'.ghost~ .text-muted+ span')

#Converting the gross revenue data to text
gross_data <- html_text(gross_data_html)

#Let's have a look at the votes data
head(gross_data)
length(gross_data)

#Data-Preprocessing: removing '$' and 'M' signs
gross_data<-gsub("M","",gross_data)

gross_data<-substring(gross_data,2,6)
head(gross_data)
length(gross_data)

#Filling missing entries with NA
for (i in c(4,7,8,12,14,20,22,24,35,40,41,42,44,45,46,47,50)){
  
  a<-gross_data[1:(i-1)]
  
  b<-gross_data[i:length(gross_data)]
  
  gross_data<-append(a,list("NA"))
  
  gross_data<-append(gross_data,b)
  
}


#Data-Preprocessing: converting gross to numerical after editing
gross_data<-as.numeric(gross_data)

#Another look of the gross data
head(gross_data)
length(gross_data)

#Deleting the last 2 elements from the list
gross_data <- gross_data[0:50]

#Data-Preprocessing: converting gross to numerical
gross_data<-as.numeric(gross_data)

#Another look of the length of the gross data
head(gross_data)
length(gross_data)


# Director

#Using CSS selectors to scrap the directors section
directors_data_html <- html_nodes(webpage,'.text-muted~ .text-muted+ p a:nth-child(1)')

#Converting the directors data to text
directors_data <- html_text(directors_data_html)

#First look of the directors data
head(directors_data)
length(directors_data)

#Data-Preprocessing: converting directors data into factors
directors_data<-as.factor(directors_data)


# Actor

#Using CSS selectors to scrap the actors section
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')

#Converting the gross actors data to text
actors_data <- html_text(actors_data_html)

#First look of the actors data
head(actors_data)
length(actors_data)

#Data-Preprocessing: converting actors data into factors
actors_data<-as.factor(actors_data)


# Combining all the lists to form a data frame
movies_df<-data.frame(Rank = rank_data, Title = title_data,
                      Description = description_data, Runtime = runtime_data,
                      Genre = genre_data, Rating = rating_data,
                      Votes = votes_data, Gross_in_Mil = gross_data,
                      Director = directors_data, Actor = actors_data)


#Structure of the data frame
str(movies_df)

#We have now successfully scraped the IMDb website for the 50 most popular feature films released in 2019.
#Write to csv file
write.csv(movies_df,'RSU_R_top50moviesin2019.csv')