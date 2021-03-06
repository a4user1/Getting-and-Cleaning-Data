## source
The data for the project was obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## R script
A script called "run_analysis.R" perform 5 steps:   
1. Downloading and unzipping dataset
2. Merging the training and the test sets to create one data set
3. Extracting only the measurements on the mean and standard deviation for each measurement
4. Using descriptive labels to name the activities in the data set:
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:

## Variables:   
"x_train", "y_train", "x_test", "y_test", "subject_train" and "subject_test" contain the data from the downloaded files.
"x_data", "y_data" and "subject_data" merge the previous datasets to further analysis.
"features" contains the correct names for the "x_data" dataset, which are applied to the column names stored in.
About the units, all values are normalized.
