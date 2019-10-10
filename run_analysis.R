#run_analysis.R

library(plyr)
library(dplyr)
library(tidyr)

#read variable 'feature' headers, and activity lables
features <- read.table("./UCI HAR Dataset/features.txt")
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activitynum", "activitytype"))

#read training data, label subject column descriptively (4)
train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
trainactivity <- read.table("./UCI HAR Dataset/train/y_train.txt") #, col.names = "activitynum") # 1-6 for each activity
trainsubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subjectnum") # 1-30 for each subject

#read test data, label subject column descriptively (4)
test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
testactivity <- read.table("./UCI HAR Dataset/test/y_test.txt")#, col.names = "activitynum")
testsubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subjectnum")

#combine data, activities, and subject numbers
trainmerge <- cbind(train, trainactivity, trainsubjects)
testmerge <-  cbind(test, testactivity, testsubjects)

#(1)Merges the training and test data sets into one data frame
alldata <- rbind(trainmerge, testmerge) 

#(3)use provided activity names to name rows descriptively, deletes activity numbers (1-6)
alldata <- merge(alldata, activitylabels, by.x = "V1", by.y = "activitynum", all = TRUE)[,2:564]

#(2)Extracts only measurements on the mean and std deviation, exlcuding meanFrequency
alldata <- alldata[,append(grep("std|mean[^Freq]", colnames(alldata)), c(562, 563))]

#(5) Creates a new, independent tidy data set with the average of each variable 
#       (tBodcAccmean-x, tBodyAccmean-Y, ...etc.) for each subject (1-30) and each activity 
#       (Laying, Sitting, etc.)
#       This tidy data set is WIDE. It is as tidy as a LONG data set that has a single variable
#       column for "Measurement", since this has 1 observation per row, and 1 column per variable.
#       The preference for LONG vs WIDE will depend on the analysis done on this tidy data set.
tidydata <- group_by(alldata, subjectnum, activitytype) %>%
        summarise_all(mean) %>%
        write.table(file = "tidy_set_course_project.txt", row.name=FALSE)
