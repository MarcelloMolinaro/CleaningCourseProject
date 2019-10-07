#run_analysis.R
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data
#       set with the average of each variable for each activity and each subject.


library(plyr)
library(dplyr)
library(tidyr)
#library()...

#read column headers, and activity lables
features <- read.table("./UCI HAR Dataset/features.txt")
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activitynum", "activity"))

#read training data
train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
trainactivity <- read.table("./UCI HAR Dataset/train/y_train.txt") #, col.names = "activity") # 1-6 for each activity
trainsubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject") # 1-30 for each subject

#read test data
test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
testactivity <- read.table("./UCI HAR Dataset/test/y_test.txt")#, col.names = "activity")
testsubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

#combine data, activities, and subject numbers
trainmerge <- cbind(train, trainactivity, trainsubjects)
testmerge <-  cbind(test, testactivity, testsubjects)

#(1)Merges the training and test data sets into one data frame
alldata <- rbind(trainmerge, testmerge) 

#(3)use provided activity names to name rows descriptively 
alldata <- merge(alldata, activitylabels, by.x = "V1", by.y = "activitynum", all = TRUE)[,2:564]

#(2)Extracts only measurements on the man and std deviation, exlcuding meanFrequency
alldata <- alldata[,append(grep("std|mean[^Freq]", colnames(alldata)), c(562, 563))]


        #combine all "alldata vartiables into a singel one that overwrites
        # can i use %>% more??
        #should I narrow my table by creating an axis variable column (x, y, z?)


