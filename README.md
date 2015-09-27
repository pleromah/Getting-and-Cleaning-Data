# Getting-and-Cleaning-Data
Coursera Course Project (Data Science: Getting and Cleaning Data)

You should create one R script called run_analysis.R that does the following.

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Steps to work on this course project

Download the data source and put into your on your local drive. You'll have a UCI Dataset folder.
Put run_analysis.R in the same folder, then set it as your working directory using setwd() function in RStudio.
Run source("run_analysis.R"), then it will generate a new file tidy.txt in your working directory.

Dependencies
you will need to load data.table library
