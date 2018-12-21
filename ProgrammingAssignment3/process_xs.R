## Load and clean the train and test sets features (x variable)

## Load column names from a text file
## Return a vector
load_x_column_names <- function(x_column_names){
  column_names <- read.table(x_column_names, sep=' ', 
                             colClasses = c('integer', 'character'), 
                             col.names=c('ID', 'Feature'))
  return(column_names$Feature)
}

## Load and clean the train and test sets features (x variable)
load_features <- function(x_train, x_test, x_column_names){
  # Load column names
  column_names <- load_x_column_names(x_column_names)
  # Get the indices of columns with name with
  # -mean() or -std() in the column name
  # Did not include meanFrequency() due to meanFrequency
  # being the weighted average of the components, by frequency.
  # It's not a normal mean.
  indices <- grep('-mean\\(\\)|-std\\(\\)', column_names)
  
  # Remove parentises from column names
  cnames <- gsub('[\\(\\)]', '', column_names)
  # Transform leading t's to time
  cnames <- gsub('^t', 'time', cnames)
  # Transform leading f's to fourierTransform
  cnames <- gsub('^f', 'fourierTransform', cnames)
  
  # Load the train set
  # use cnames as column names
  features_column <- read.table(x_train, col.names=cnames)
  # Load the test set
  # Bind the rows of the test set to the end of the train set
  features_column <- rbind(features_column, 
                           read.table(x_test,col.names=cnames))
  
  # Select columns where -mean() or -std() is in the column name
  features_column <- features_column[,indices]
  # Create column InstanceID that numbers rows for merging purposes
  features_column$InstanceID <- c(0:(nrow(features_column)-1))
  
  return(features_column)
}