trainX <- read.table("data/train/X_train.txt", quote="\"")
trainY <- read.table("data/train/Y_train.txt", quote="\"")
testX <- read.table("data/test/X_test.txt", quote="\"")
testY <- read.table("data/test/y_test.txt", quote="\"")
features <- read.table("data/features.txt", quote="\"")
subject_train <- read.table("data/train/subject_train.txt", quote="\"")
subject_test <- read.table("data/test/subject_test.txt", quote="\"")
colnames(subject_train) <- c('subject')
colnames(subject_test) <- c('subject')

colnames(features) <- c("id","column_name")
features$column_name <- sapply(features$column_name,
                               function(x) { gsub("-", "",x)})
features$column_name <- sapply(features$column_name,
                               function(x) { gsub("\\(", "",x)})
features$column_name <- sapply(features$column_name,
                               function(x) { gsub(")", "",x)})

colnames(trainX) <- features$column_name
colnames(testX) <- features$column_name

colnames(trainY) <- c("activity")
colnames(testY) <- c("activity")

trainX$activity <- trainY$activity
testX$activity <- testY$activity
trainX$activity <- factor(trainX$activity,
                          levels=c(1,2,3,4,5,6),
                          labels=c('Walking',
                                   'Walking up stairs',
                                   'Walking down stairs',
                                   'Sitting',
                                   'Standing',
                                   'Laying'))
testX$activity <- factor(testX$activity,
                          levels=c(1,2,3,4,5,6),
                          labels=c('Walking',
                                   'Walking up stairs',
                                   'Walking down stairs',
                                   'Sitting',
                                   'Standing',
                                   'Laying'))

trainX$subject <- subject_train$subject
testX$subject <- subject_test$subject

data <- rbind(trainX, testX)
stds <- data[, grepl("std", names(data))]
means <- data[, grepl("mean", names(data))]

data <- cbind(data$subject, data$activity, means, stds)
colnames(data)[1] <- 'subject'
colnames(data)[2] <- 'activity'

require(sqldf)
tidy <- sqldf('select subject,
              activity,
              avg(tBodyAccmeanX) as avg_tBodyAccmeanX,
              avg(tBodyAccmeanZ) as avg_tBodyAccmeanZ,
              avg(tGravityAccmeanY) as avg_tGravityAccmeanY,
              avg(tBodyAccJerkmeanX) as avg_tBodyAccJerkmeanX,
              avg(tBodyAccJerkmeanZ) as avg_tBodyAccJerkmeanZ,
              avg(tBodyGyromeanY) as avg_tBodyGyromeanY,
              avg(tBodyGyroJerkmeanX) as avg_tBodyGyroJerkmeanX,
              avg(tBodyGyroJerkmeanZ) as avg_tBodyGyroJerkmeanZ,
              avg(tGravityAccMagmean) as avg_tGravityAccMagmean,
              avg(tBodyGyroMagmean) as avg_tBodyGyroMagmean,
              avg(fBodyAccmeanX) as avg_fBodyAccmeanX,
              avg(fBodyAccmeanZ) as avg_fBodyAccmeanZ,
              avg(fBodyAccmeanFreqY) as avg_fBodyAccmeanFreqY,
              avg(fBodyAccJerkmeanX) as avg_fBodyAccJerkmeanX,
              avg(fBodyAccJerkmeanZ) as avg_fBodyAccJerkmeanZ,
              avg(fBodyAccJerkmeanFreqY) as avg_fBodyAccJerkmeanFreqY,
              avg(fBodyGyromeanX) as avg_fBodyGyromeanX,
              avg(fBodyGyromeanZ) as avg_fBodyGyromeanZ,
              avg(fBodyGyromeanFreqY) as avg_fBodyGyromeanFreqY,
              avg(fBodyAccMagmean) as avg_fBodyAccMagmean,
              avg(fBodyBodyAccJerkMagmean) as avg_fBodyBodyAccJerkMagmean,
              avg(fBodyBodyGyroMagmean) as avg_fBodyBodyGyroMagmean,
              avg(fBodyBodyGyroJerkMagmean) as avg_fBodyBodyGyroJerkMagmean,
              avg(tBodyAccstdX) as avg_tBodyAccstdX,
              avg(tBodyAccstdZ) as avg_tBodyAccstdZ,
              avg(tGravityAccstdY) as avg_tGravityAccstdY,
              avg(tBodyAccJerkstdX) as avg_tBodyAccJerkstdX,
              avg(tBodyAccJerkstdZ) as avg_tBodyAccJerkstdZ,
              avg(tBodyGyrostdY) as avg_tBodyGyrostdY,
              avg(tBodyGyroJerkstdX) as avg_tBodyGyroJerkstdX,
              avg(tBodyGyroJerkstdZ) as avg_tBodyGyroJerkstdZ,
              avg(tGravityAccMagstd) as avg_tGravityAccMagstd,
              avg(tBodyGyroMagstd) as avg_tBodyGyroMagstd,
              avg(fBodyAccstdX) as avg_fBodyAccstdX,
              avg(fBodyAccstdZ) as avg_fBodyAccstdZ,
              avg(fBodyAccJerkstdY) as avg_fBodyAccJerkstdY,
              avg(fBodyGyrostdX) as avg_fBodyGyrostdX,
              avg(fBodyGyrostdZ) as avg_fBodyGyrostdZ,
              avg(fBodyBodyAccJerkMagstd) as avg_fBodyBodyAccJerkMagstd,
              avg(tBodyAccmeanY) as avg_tBodyAccmeanY,
              avg(tGravityAccmeanX) as avg_tGravityAccmeanX,
              avg(tGravityAccmeanZ) as avg_tGravityAccmeanZ,
              avg(tBodyAccJerkmeanY) as avg_tBodyAccJerkmeanY,
              avg(tBodyGyromeanX) as avg_tBodyGyromeanX,
              avg(tBodyGyromeanZ) as avg_tBodyGyromeanZ,
              avg(tBodyGyroJerkmeanY) as avg_tBodyGyroJerkmeanY,
              avg(tBodyAccMagmean) as avg_tBodyAccMagmean,
              avg(tBodyAccJerkMagmean) as avg_tBodyAccJerkMagmean,
              avg(tBodyGyroJerkMagmean) as avg_tBodyGyroJerkMagmean,
              avg(fBodyAccmeanY) as avg_fBodyAccmeanY,
              avg(fBodyAccmeanFreqX) as avg_fBodyAccmeanFreqX,
              avg(fBodyAccmeanFreqZ) as avg_fBodyAccmeanFreqZ,
              avg(fBodyAccJerkmeanY) as avg_fBodyAccJerkmeanY,
              avg(fBodyAccJerkmeanFreqX) as avg_fBodyAccJerkmeanFreqX,
              avg(fBodyAccJerkmeanFreqZ) as avg_fBodyAccJerkmeanFreqZ,
              avg(fBodyGyromeanY) as avg_fBodyGyromeanY,
              avg(fBodyGyromeanFreqX) as avg_fBodyGyromeanFreqX,
              avg(fBodyGyromeanFreqZ) as avg_fBodyGyromeanFreqZ,
              avg(fBodyAccMagmeanFreq) as avg_fBodyAccMagmeanFreq,
              avg(fBodyBodyAccJerkMagmeanFreq) as avg_fBodyBodyAccJerkMagmeanFreq,
              avg(fBodyBodyGyroMagmeanFreq) as avg_fBodyBodyGyroMagmeanFreq,
              avg(fBodyBodyGyroJerkMagmeanFreq) as avg_fBodyBodyGyroJerkMagmeanFreq,
              avg(tBodyAccstdY) as avg_tBodyAccstdY,
              avg(tGravityAccstdX) as avg_tGravityAccstdX,
              avg(tGravityAccstdZ) as avg_tGravityAccstdZ,
              avg(tBodyAccJerkstdY) as avg_tBodyAccJerkstdY,
              avg(tBodyGyrostdX) as avg_tBodyGyrostdX,
              avg(tBodyGyrostdZ) as avg_tBodyGyrostdZ,
              avg(tBodyGyroJerkstdY) as avg_tBodyGyroJerkstdY,
              avg(tBodyAccMagstd) as avg_tBodyAccMagstd,
              avg(tBodyAccJerkMagstd) as avg_tBodyAccJerkMagstd,
              avg(tBodyGyroJerkMagstd) as avg_tBodyGyroJerkMagstd,
              avg(fBodyAccstdY) as avg_fBodyAccstdY,
              avg(fBodyAccJerkstdX) as avg_fBodyAccJerkstdX,
              avg(fBodyAccJerkstdZ) as avg_fBodyAccJerkstdZ,
              avg(fBodyGyrostdY) as avg_fBodyGyrostdY,
              avg(fBodyAccMagstd) as avg_fBodyAccMagstd,
              avg(fBodyBodyGyroMagstd) as avg_fBodyBodyGyroMagstd
              from data
              group by subject, activity')
write.csv(data, 'data.txt')
write.csv(tidy, 'tidy.txt')
