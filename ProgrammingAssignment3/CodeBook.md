# Explination of Features
-----------------------------------------------------

A discription of the dataset this dataset was derived from can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

This dataset contains the mean, grouped by Activity then SubjectID, of the dataset discribed in the following expcert:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
>
> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
>
> timeBodyAcc-XYZ
> timeGravityAcc-XYZ
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ
> timeBodyGyroJerk-XYZ
> timeBodyAccMag
> timeGravityAccMag
> timeBodyAccJerkMag
> timeBodyGyroMag
> timeBodyGyroJerkMag
> fourierTransformBodyAcc-XYZ
> fourierTransformBodyAccJerk-XYZ
> fourierTransformBodyGyro-XYZ
> fourierTransformBodyAccMag
> fourierTransformBodyAccJerkMag
> fourierTransformBodyGyroMag
> fourierTransformBodyGyroJerkMag
>
> The set of variables that were estimated from these signals are: 
>
> mean: Mean value
> std: Standard deviation

The above expcert explains 66 of the 68 columns of the dataset. The other two columns are explained as follows.

Activity is a factor that represents the action the subject was taking during a time step. Activity is in column Activity. Activity is one of 6 different values:
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

The Subject is represented by an integer, ranging from 1 to 30. The Subject is represented in the column SubjectID.

As there are 6 Activitys and 30 Subjects, the dataset contains 6*30=180 rows. Each row of the dataset contains the mean of the features described above, for each group.

