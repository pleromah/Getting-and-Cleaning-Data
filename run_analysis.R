## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##zip file was carefully downloaded and saved to ther working directory

## loads features
features <- read.table(paste(wd, "features.txt", sep="/"))
# determine features for mean and standard deviation
wanted_feature_indices <- grep("mean\\(|std\\(", features[,2])

##Loads train and test data
wd <- "C:/Users/olaide.allibalogun/Documents/Rthings/UCI"
subject_train <- read.table(paste(wd, "train/subject_train.txt", sep="/"), col.names = "subject")
X_train <- read.table(paste(wd, "train/X_train.txt", sep="/"), col.names = features[,2], check.names=FALSE)
y_train <- read.table(paste(wd, "train/y_train.txt", sep="/"), col.names = "activity_number")

subject_test <- read.table(paste(wd, "test/subject_test.txt", sep="/"), col.names = "subject")
X_test <- read.table(paste(wd, "test/X_test.txt", sep="/"), col.names = features[,2], check.names=FALSE)
y_test <- read.table(paste(wd, "test/y_test.txt", sep="/"), col.names = "activity_number")

#binds subject,x,and y data for train to form a dataset
dftrain = cbind(subject_train, y_train, x_train)

#binds subject,x,and y data for test to form a dataset
dftest = cbind(subject_test, y_test, x_test)

# #Question 1: merge data sets dftrain and dftest
df <- rbind(dftrain, dftest)

# #Question 2: Extracts only the measurements on the mean and standard deviation for each measurement
tt <- df[,wanted_feature_indices]

# Load: activity labels
activity_labels <- read.table(paste(wd,"activity_labels.txt", sep="/"))[,2]

# #Question 3: Uses descriptive activity names to name the activities in the data set
rb <- rbind(y_train,y_test)#binds y_train and y_test
rb[,2] = activity_labels[rb[,1]] #creates a new column that carries the activity labels for each value in column 1
df$activity = rb[,2] #merges activity labels to the master data set

# #Question 4: Appropriately labels the data set with descriptive variable names.
names(df) <- gsub("Acc", "Accelerator", names(df))
names(df) <- gsub("Mag", "Magnitude", names(df))
names(df) <- gsub("Gyro", "Gyroscope", names(df))
names(df) <- gsub("^t", "time", names(df))
names(df) <- gsub("^f", "frequency", names(df))

# #Question 5: Creates a tidy data set with the average of each variable for each activity and each subject
library(data.table)
masterdt <- data.table(df)
tidyData <- masterdt[, lapply(.SD, mean), by = 'subject,activity']
write.table(tidyData, file = "tidy.txt", row.names = FALSE)

