# Title : Evaluating Model Performance
# Author : Romansya
##########################################

library(caret)

#read the data
dataSoal <- read.csv('Dataset/Data-soal.csv')

#confusion matrix using table() function
cm <- table(dataSoal$Aktual,dataSoal$Prediksi)
cm

#assigning variables from confusion matrix
AA <- cm[1,1]
AB <- cm[1,2]
AC <- cm[1,3]
BA <- cm[2,1]
BB <- cm[2,1]
BC <- cm[2,1]
CA <- cm[3,1]
CB <- cm[3,1]
CC <- cm[3,1]

# accuracy
acc <- (AA+BB+CC)/(AA+AB+AC+BA+BB+BC+CA+CB+CC)
acc

# precision
prec_a <- AA/(AA+AB+AC)
prec_b <- BB/(BA+BB+BC)
prec_c <- CC/(CA+CB+CC)

# recall
rec_a <- AA/(AA+BA+CA)
rec_b <- BB/(AB+BB+CB)
rec_c <- CC/(AC+BC+CC)

# precision and recall
all <- data.frame(Class=c("A","B","C"),
                  Precision=c(prec_a,prec_b,prec_c),
                  Recall=c(rec_a,rec_b,rec_c))
all