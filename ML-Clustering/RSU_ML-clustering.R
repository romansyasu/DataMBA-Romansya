#title : 'Machine Learning I (Clustering)'
#author : 'Romansya'
############################################

# Intro
# From the dataset, make cluster using k-means clustering and hierarcichal clustering.


# Load library and data
library(cluster)
library(DataExplorer)

data <- read.csv('https://raw.githubusercontent.com/arikunco/machinelearning/master/dataset/online_retail_clean.csv')

# Exclude the CustomerID column
data_new <- data[,2:4]

# Data understanding
summary(data_new)


# K-means

# Determine the number of clusters
wss <- 0
for (i in 1:15) {
  km.out <- kmeans(data_new[,1:3], centers = i, nstart = 20)
  # Save total within sum of squares to wss variable
  wss[i] <- km.out$tot.withinss
}
plot(1:15, wss, type = "b", 
     xlab = "Number of Clusters", 
     ylab = "Within groups sum of squares")

# The optimal number of cluster is 3
km <- kmeans(data_new, centers = 3, nstart=20)
plot(data_new, col = km$cluster,
     main = "k-means with 3 clusters")

# Check member of clusters
clust <- cbind(data_new,cluster=km$cluster)
#cluster1
head(clust[clust$cluster==1,])
summary(clust[clust$cluster==1,])[,1:3]
#cluster2
head(clust[clust$cluster==2,])
summary(clust[clust$cluster==2,])[,1:3]
#cluster3
head(clust[clust$cluster==3,])
summary(clust[clust$cluster==3,])[,1:3]


# Hierarchical

# calculates similarity
d <- dist(data_new[,1:3])

# model
hclust.out <- hclust(d = d)
summary(hclust.out)

# draw a dendogram
layout(1)
plot(hclust.out)
abline(h = 3.5, col = "royalblue")
#cut
cutree(hclust.out, h = 6)
cutree(hclust.out, k = 3)
