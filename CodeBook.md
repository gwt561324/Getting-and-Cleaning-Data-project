#Code Book for tidy data set

A prefix of t indicates the measurement came from the time domain.
A prefix of f indicates the measurement came from the frequency domain.
All measurements have been averaged by subject and activity.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Two additional columns are present - subject and activity.

subject - identifies the study participant
activity - A factor with six levels. Walking, walking up stairs,
  walking down stairs, Sitting, Standing, Laying

To obtain the tidy data set, a series of steps were followed.

1. Load the test and train data.
2. Load the column names for these data sets.
3. Add the column names to the data sets.
4. Load the test and train data sets for the activity.
5. Setup the activity as a factor with the appropriate names.
6. Combine the activity data with the data from 3.
7. Concatenate the test and train data sets.
8. Remove all columns that are not mean or standard deviation measurements.
9. Aggregate the data set to get the tidy data set by taking the average of each measurement over the subject and activity.