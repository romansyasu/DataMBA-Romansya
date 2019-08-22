# Title       : RSU_Formatting_Data_Online_Retail.R
# Author      : Romansya
# Date        : August 22, 2019
# Description : This is an online retail script and its formatting process with RFM method.
# Objective   : To format data (after cleaning)
# Data source : https://archive.ics.uci.edu/ml/datasets/online+retail 
#               This is a transnational data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail.The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers.

####################################################

# Load library
library(tidyverse)
library(lubridate)
library(DataExplorer)

# Load data
onlineretail <- readxl::read_xlsx('dataset/Online Retail.xlsx')

# Preview of the first 6 rows and last 6 rows of data
head(onlineretail)
tail(onlineretail)

# Check missing data
plot_missing(onlineretail)

# CustomerID have 24.93% missing value, let's drop them
onlineretail_drop <- onlineretail[!is.na(onlineretail$CustomerID),]

# Check missing data again
plot_missing(onlineretail_drop)

# Now we're going to make a new table :
# CustomerID | Recency | Frequency | Monetary
# Recency   : Days count from 2011-12-31 to the last transaction made (in days)
# Frequency : Transaction count in the last 6 months
# Monetary  : Money spent for transaction by distinct CustomerID (in dollars)

frequency <- onlineretail_drop %>% group_by(CustomerID) %>% summarise(frequency = n_distinct(InvoiceNo)) 

monetary <- onlineretail_drop %>% group_by(CustomerID) %>% summarise(monetary=sum(UnitPrice*Quantity))                                               

recency <- onlineretail_drop %>% group_by(CustomerID) %>% arrange(desc(InvoiceDate)) %>%   filter(row_number()==1) %>% mutate(recency = as.numeric(as.duration(interval(InvoiceDate,ymd("2011-12-31"))))/86400) %>% select(CustomerID, recency)

# Make the new table by joining the 3 new variable
onlineretail_full <- recency %>% left_join(frequency,by="CustomerID") %>% left_join(monetary,by="CustomerID")

# Make a csv file from the table
write.csv(onlineretail_full, 'OnlineRetail_rfm.csv')