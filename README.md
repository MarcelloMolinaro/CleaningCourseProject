# CleaningCourseProject
Course Project Week 4 of Coursera Getting and Cleaning Data course

The run_analysis script reads the source data sets from the working directory. If the original data sets do not exist in the working directory, this script will not work properly.
When possible, the script inserts descriptive names into column names.

The script performs these steps:
1) Read variable 'feature' headers, and activity lables (using read.table)
2) Read training data (using read.table)
3) Read test data (using read.table)
4) Combine data, activities, and subject numbers for test and train data (using cbind)
5) Append the training and test data sets into one data frame (using rbind)
6) Use provided activity names to name rows descriptively, deletes activity numbers (1-6) (using merge from dpylr)
7) Extract only measurements on the mean and std deviation, exlcuding meanFrequency (using regular expression "std|mean[^Freq]")
    --meanFrequency is not a standard 'mean' meausrement, it is an additional measurement. The instrictions specified oonly mean and std
8) Creates a new, independent tidy data set with the average of each variable (using group_by, summarise)
       (tBodcAccmean-x, tBodyAccmean-Y, ...etc.) for each subject (1-30) and each activity 
       (Laying, Sitting, etc.)
       This tidy data set is WIDE. It is as tidy as a LONG data set that has a single variable
       column for "Measurement", since this has 1 observation per row, and 1 column per variable.
       The preference for LONG vs WIDE will depend on the analysis done on this tidy data set.
9) Write the new data set to the file "tidy_set_course_project.txt" (using write.table() and row.name = FALSE
