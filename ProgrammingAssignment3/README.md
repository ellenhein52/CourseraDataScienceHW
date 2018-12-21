# Getting and Cleaning Data: Class Project
----------------------------------------------------

The script for the Getting and Cleaning Data class project is contained in 4 seperate R files:
* `**run_analysis.R**` : Runs the analysis. Loads the following scripts using `source()`.
* `**process_subjects.R**`: Contains function(s) for loading and processing the subject text files.
* `**process_ys.R**`: Contains function(s) for loading and processing the activity text files.
* `**process_xs.R**`: Contains function(s) for loading and processing the features text files.

All scripts need to be in the same working directory. The directory tree looks like this:
```
-RWorkingDirectory:
	-process_subjects.R
	-process_ys.R
	-process_xs.R
	-run_analysis.R
	-UCI
		-UCI HAR Dataset
			-...
```


## Process Used to Clean Dataset and Create New Dataset

This section details the process used to clean the original dataset and create a new dataset. It is assumed that the dataset has already
been downloaded and unzipped.

The raw dataset can be downloaded at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
Discriptions of the original dataset can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

After running `run_analysis.R`, the home directory is set to `~/Coursera/course_3_project` on line 6. Change this if nessisary.
Other parameters that may need modifying are the locations of the subject train and test files, activity train and test files, features
train and test files, and `features.txt`. These parameters can be found from lines 19-27 in `run_analysis.R`.


### Step 1: Load and Clean subject_train.txt and subject_test.txt

Function `load_subject_id`, called on line 30 of `run_analysis.R`, found in `process_subjects.R` loads the train dataset and uses `rbind` to bind the test dataset on the end of the
train dataset. An extra column called InstanceID is added to the data frame to later facilitate a merge. This function returns a data frame
with the following columns:

Column Name | Column Datatype | Discription
----------- | --------------- | ------------
SubjectID | integer | An integer representing the identity of a test subject.
InstanceID | integer | The row number starting from 0. Used for merging datasets.


### Step 2: Load and Clean y_train.txt and y_test.txt

Function `load_activities`, called on line 32 of `run_analysis.R`, found in `process_ys.R` loads the train dataset and uses `rbind` to bind the test dataset on the end of the
train dataset. Additionally, a column is added that consists of text labels for the activity ids. The text label assigned to the integer ids are as follows:
1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

An extra column called InstanceID is added to the data frame to later facilitate a merge. This function returns a data frame with the following columns:

Column Name | Column Datatype | Discription
----------- | --------------- | ------------
ActivityID | integer | An integer representing an activity.
Activity | character | Text representing an activity.
InstanceID | integer | The row number starting from 0. Used for merging datasets.


### Step 3: Load and Clean x_train.txt, x_test.txt, and `features.txt`

Function `load_features`, called on line 34 of `run_analysis.R`, is found in `process_xs.R`.

Function `load_x_column_names` in `process_xs.R` (called in function `load_features`), loads the column names from the file `features.txt`
The columns are filtered to only include the means and stds of the dataset. This is accomplished by using the regex `-mean\\(\\)|-std\\(\\)` with grep on the column names. This function accepts only
column names with the substrings `-mean()` or `std()`. I purposly did not include meanFrequency as this is NOT a mean, but a mean weighted by frequency (big difference). 

Next, I cleaned up the column names using `gsub`:
```
  # Remove parentises from column names
  cnames <- gsub('[\\(\\)]', '', column_names)
  # Transform leading t's to time
  cnames <- gsub('^t', 'time', cnames)
  # Transform leading f's to fourierTransform
  cnames <- gsub('^f', 'fourierTransform', cnames)
```
The code removes parentises, replaces leading 't' with 'time' and leading 'f' with fourierTransform.

Now, we load the train dataset and use `rbind` to bind the test dataset on the end of the train dataset and use the indices we got from `grep` earier to filter the columns down to only 67 variables.
An extra column called InstanceID is added to the data frame to later facilitate a merge. 

The output contains 67 columns in total (ignoring the InstanceID column). The following text (from `feature_info.txt`) contains information on the columns:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
>
> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
>
> tBodyAcc-XYZ
> tGravityAcc-XYZ
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ
> tBodyGyroJerk-XYZ
> tBodyAccMag
> tGravityAccMag
> tBodyAccJerkMag
> tBodyGyroMag
> tBodyGyroJerkMag
> fBodyAcc-XYZ
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccMag
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag
>
> The set of variables that were estimated from these signals are: 
>
> mean: Mean value
> std: Standard deviation

### Step 4: Merge the Three Datasets, Group by Activity and SubjectID, Take the Mean, and Write Results

We're finally back in `run_analysis.R`.

Now we merge the three datasets using the column InstanceID and function `merge`. 
```
# Create table of averages grouped by activity then subject
# Merge three tables into one
mdf <- merge(subjects, activities)
mdf <- merge(mdf, features)
```
Afterwords we `NULL` the columns `InstanceID` and `ActivityID` (lines 52-53) because we don't need them anymore.
```
mdf$InstanceID <- NULL
mdf$ActivityID <- NULL
```

Finally, we create a dataframe with the average of each variable for each activity and each subject.
```
mean_by_activity_and_subject <- as.data.frame(mdf %>% 
                                                group_by(Activity, SubjectID) %>% 
                                                summarise_each(funs(mean)))
```
The above code can be broken down into:
```
# Group the dataframe by factors Activity and SubjectID
temp <- group_by(mdf, Activity, SubjectID)
# Use the sumerize_each function to take the mean of of the seperate groups
temp <- summarise_each(temp, funs(mean))
# Transform temp from a data.table to a data.frame
temp <- as.data.frame(temp)
```

Finally, we save the data frame `mdf`, and the script ends.