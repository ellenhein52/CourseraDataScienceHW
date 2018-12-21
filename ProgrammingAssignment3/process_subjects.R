## Load and clean the train and test subject ids

load_subject_id <- function(train_file, test_file){
  # Load the train subject id
  # Place subject id in a column called SubjectID
  subject_id_column <- read.csv(train_file, header=FALSE, col.names=c('SubjectID'), 
                                colClasses = c('integer'))
  # Load the test subject id
  # Bind the rows of the test set to the end of the train set
  subject_id_column <- rbind(subject_id_column, 
                          read.csv(test_file, header=FALSE, col.names=c('SubjectID'), 
                                   colClasses = c('integer')))
  # Create column InstanceID that numbers rows for merging purposes
  subject_id_column$InstanceID <- c(0:(nrow(subject_id_column)-1))
  
  return(subject_id_column)
}