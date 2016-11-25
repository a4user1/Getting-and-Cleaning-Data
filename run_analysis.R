library(plyr)
##Find and download the data set for the project
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "C:/Users/Carlos/Documents/data/Dataset.zip")
unzip(zipfile="C:/Users/Carlos/Documents/data/Dataset.zip",exdir="C:/Users/Carlos/Documents/data")
##Merges the training and the test sets to create one data set.
x_train <- read.table("C:/Users/Carlos/Documents/data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/Users/Carlos/Documents/data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("C:/Users/Carlos/Documents/data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("C:/Users/Carlos/Documents/data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/Carlos/Documents/data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/Carlos/Documents/data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("C:/Users/Carlos/Documents/data/UCI HAR Dataset/features.txt")
activityLabels = read.table("C:/Users/Carlos/Documents/data/UCI HAR Dataset/activity_labels.txt")
colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activityLabels) <- c("activityId","activityType")
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)

##Extracts the measurements on the mean and standard deviation for each measurement.
colNames <- colnames(setAllInOne)
mean_and_std <- (grepl("activityId" , colNames) | 
                         grepl("subjectId" , colNames) | 
                         grepl("mean.." , colNames) | 
                         grepl("std.." , colNames) 
)
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names.
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
by="activityId",
all.x=TRUE)

##creates a second, independent tidy data set with the average of each variable for each activity and each subject.
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
