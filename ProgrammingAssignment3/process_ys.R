## Load and clean the train and test sets activities (y variable)

## Helper function that returns a text version of an activity
activity_helper <- function(num, activity_labels=c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS',
                                                   'SITTING', 'STANDING', 'LAYING')){
  return(activity_labels[num])
}

## Function that loads and cleans the train and test sets of activity (y variable)
load_activities <- function(train_file, test_file){
  # Load the train set
  # Store activity in column called ActivityID
  activities_column <- read.csv(train_file, header=FALSE, col.names=c('ActivityID'), 
                               colClasses=c('integer'))
  # Load the test set
  # Bind the rows of the test set to the end of the train set
  activities_column <- rbind(activities_column, read.csv(test_file, header=FALSE, col.names=c('ActivityID'), 
                                    colClasses=c('integer')))
  
  # Create a column with a text version of ActivityID called Activity
  activities_column$Activity <-  sapply(activities_column$ActivityID, activity_helper)
  # Create column InstanceID that numbers rows for merging purposes
  activities_column$InstanceID <- c(0:(nrow(activities_column)-1))
  
  return(activities_column)
}