## the raw data is downloaded directly and unzipped to "./UCI HAR Dataset" directory
## If you ant to test this code, please change to directory path your data is storred
## Here is the R script for this course project as required:

# 1.Merges the training and the test sets to create one data set.
   # first read three training data x, y, subject_train.text
    x_train<-read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE) 
    y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
    s_train<-read.table("./UCI HAR dataset/train/subject_train.txt", header=FALSE)

   # then Read three test data x, y, subject_test.text
    x_test<-read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE) 
    y_test<-read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
    s_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)

   #Read features.txt into R (as virables names later) and spot check its data structure using head()
     virables<-read.table("./UCI HAR Dataset/features.txt", header=FALSE) 
     head(virables)

   #Column combind the training and test dataset as traindata and testdata
    traindata<-cbind(s_train, y_train, x_train)
    testdata<-cbind(s_test, y_test, x_test)

  #Assign column names to traindata and testdata according to readme.txt file
    colnames(traindata)<-c("subject", "label", as.character(virables$V2))
    colnames(testdata)<-c("subject", "label", as.character(virables$V2))

  #remove columns with duplicated column names
    traindata <- traindata[, !duplicated(colnames(traindata))]
    testdata <- testdata[, !duplicated(colnames(testdata))]
    
  #row combind the training and test dataset as combinedata
    combinedata<-rbind(traindata, testdata)


## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
    # subset those data whose column name contains "mean" and "std" and columns  "subject",
    # and "label" from combinedata and put in new dataset meanandsd
    meanandsd<-select(combinedata, subject, label, contains("mean"), contains("std"))



## 3.Uses descriptive activity names to name the activities in the data set
    # read activity_labels.txt and replace "label" column values in meanandsd dataset to corresponding 
    # activity names (such as WALKING, LAYING etc.) according to this file.
    
   labels<-read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE) 
   meanandsd$label<-factor(meanandsd$label, levels=c(1, 2, 3, 4, 5, 6), labels=c("WALKING",
   "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING","LAYING"))



## 4.Appropriately labels the data set with descriptive variable names.
     # replacing some short version column names of meanandsd dataset to more descriptive 
      #longer version names, for example:
          #short version     # longer or more descriptive version
          #Gyro	           #Gyroscope
          #label           #activity
    
    # extract dataset meanandsd column names and put in colname
    colname<-names(meanandsd)
        
    # then replace short version with longer versions for colname with gsub() function
    colname<-gsub ("label", "activity", colname, ignore.case=FALSE)
    colname<-gsub ("tBody", "time-Body", colname, ignore.case=FALSE)
    colname<-gsub ("tGravity", "time-Gravity", colname, ignore.case=FALSE)
    colname<-gsub ("Mag", "Magnitude", colname, ignore.case=FALSE)
    colname<-gsub ("Gyro", "Gyroscope", colname, ignore.case=FALSE)
    colname<-gsub ("Acc", "Accelerometer", colname, ignore.case=FALSE)
    colname<-gsub ("Freq", "Frequency", colname, ignore.case=FALSE)
    colname<-gsub ("BodyBody", "Body", colname, ignore.case=FALSE)
   
    # Reassign the new column names back to dataset meanandsd
     colnames(meanandsd)<-colname



## 5.From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.
   
    # calculate average value of each variables and grouped by activity and subject
    # and put result in subdata
    # Write the data as subtidydata.txt under current working directory
    subdata<-meanandsd %>% group_by(subject, activity) %>% summarise_each(funs(mean))
    write.table(subdata, file="subtidydata.txt", row.names=FALSE, col.names=TRUE)
