## Load the UCI HAR Dataset
## Clean the UCI HAR Dataset
## Save new dataset created from the old datasets

# Set working directory
setwd("~/Coursera/course_3_project")

# Download and unzip the dataset from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Load libraries and code
library(dplyr)

source('process_subjects.R')
source('process_ys.R')
source('process_xs.R')

# Set parameters for file locations
subject_train <- 'UCI/UCI HAR Dataset/train/subject_train.txt'
subject_test  <- 'UCI/UCI HAR Dataset/test/subject_test.txt'

y_train <- 'UCI/UCI HAR Dataset/train/y_train.txt'
y_test <- 'UCI/UCI HAR Dataset/test/y_test.txt'

x_train <- 'UCI/UCI HAR Dataset/train/x_train.txt'
x_test <- 'UCI/UCI HAR Dataset/test/x_test.txt'
x_column_names <- 'UCI/UCI HAR Dataset/features.txt'

# Load the training and test datasets for subjects
subjects <- load_subject_id(subject_train, subject_test) # Code in process_subjects.R
# Load the training and test datasets for activity (y)
activities <- load_activities(y_train, y_test) # Code in process_ys.R
# Load the training and test datasets for features (x)
features <- load_features(x_train, x_test, x_column_names) # Code in process_xs.R

# Create table of averages grouped by subject
#subject_mean <- aggregate(features, list(subjects$SubjectID), mean)
#subject_mean$InstanceID <- NULL
#subject_mean <- rename(subject_avgs, SubjectID=Group.1)

# Create table of averages grouped by activity
#activity_mean <- aggregate(features, list(activities$Activity), mean)
#activity_mean$InstanceID <- NULL
#activity_mean <- rename(activity_mean, Activity=Group.1)

# Create table of averages grouped by activity then subject
# Merge three tables into one
mdf <- merge(subjects, activities)
mdf <- merge(mdf, features)

# Remove instance id and activity id columns
mdf$InstanceID <- NULL
mdf$ActivityID <- NULL
# Create a dataframe, grouped by activity, then subjectID, and then
# take the mean of each group
mean_by_activity_and_subject <- as.data.frame(mdf %>% 
                                                group_by(Activity, SubjectID) %>% 
                                                summarise_each(funs(mean)))
# Save the dataframe
write.table(mean_by_activity_and_subject, "mean_by_activity_and_subject.txt", row.name=FALSE)

