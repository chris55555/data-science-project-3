## data-science-project-3

## This repo is for my project work for online collecting and cleaning data from coursera; It comes with the R code doc run_analysis.R and descriptive codebook.text. The raw data was directly downloaded from its web source and unzipped to "./UCI HAR Dataset" directory. In summary, this is how the run_analysis.R code works:  

## 1.Merges the training and the test sets to create one data set.
  # Using read.table() to read three train files x_, y_ and subject_train.txt into R and combined to one complete dataset traindata
  # read three test files x_, y_, subject_test.txt and combined to one complete dataset testdata;  
  # read column names into R from file "./UCI HAR Dataset/features.txt" for data x_train and x_test  
  # Assign column names to traindata and testdata based on features.text and two extra column names "subject" and   "label"  
  # cleanup traindata and testdata by removing duplicated columns  
  # combine traindata and testdata as combinedata  
  
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
 # subset combinedata by only choosing those columns with name contains "mean" and "std" and columns "subject" and "label" and put in new dataset meanandsd 
 
## 3.Uses descriptive activity names to name the activities in the data set
 # read activity_labels.txt and replace "label" column values in meanandsd dataset to corresponding activity names (such as WALKING, LAYING etc.) according to this file.  
 
## 4.Appropriately labels the data set with descriptive variable names.
 # replacing some column names of meanandsd dataset to more descriptive or longer version names, for example: Gyro	to Gyroscope; label  to activity etc.  

## 5.From the data set in step 4, creates a second, independent tidy data  set with the average of each variable for each activity and each subject.
  # calculate average value of each variables for meanandsd and grouped by activity and subject and put result in subdata  
  # Write the data as subtidydata.txt under current working directory
 
