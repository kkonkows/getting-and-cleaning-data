# Coursera "Getting and Cleaning Data" project - data structure

Thank you for you time in assessing this project. Please note that full description of what the script does, how it works and how manipulates the data is contained in README.md file included into this release.

This is a transformed dataset based on: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## File structure 

The data file is a saved in two formats for convinience - output.csv and output.txt (txt being a table with sep=" "). One can use read.csv() or read.table accordingly to read in the files.

The data contains 180 observations for 81 variables. As the data is in aggregated form, one should read the file as follows:

* Column 1 - "subject" - ID of a subject for activity in column 2 - for which variables have been created;
* Column 2 - "activity" - name of the activity per subject for which variables have been created;
* Next 79 columns - Average (mean) values of the variables taken from original data;

In other words, one can interpret row 1 as: subject 1 in laying posistion had average values of 79 variables as in columns 3 - 81.

Please note that column names represent original naming with prefix "mean." to indicate aggregation by using mean.

## Column naming scheme

Please note that all columns are means of means or means standard deviations.

Column names are named accordingly to the following scheme:
* prefix "mean." indicates all columns are means based on aggregation of all observations per subject per activity - as denoted in columns 1 and 2.
* first letter after the prefix denoting either: 't' - time based, 'f' - Fourier Transformation applied
** i.e. mean.tBodyAcc_XYZ - time basde, mean.fBodyAcc_XYZ - fourier transormatio applied
* name following the first letter denotes wether observation considers body or gravity acceleration signal.
** This is a body signal: mean.tBodyAcc_XYZ
** This is a gravity signal: mean.tGravityAcc_XYZ
* next name denotes wether the probe comes from accelerometer or a gyroscope
** This is a accelerometer signal: mean.tGravityAcc_XYZ
** This is a gyroscope signal: mean.fBodyGyroJerkMag_XYZ
* Next column name component will be related to the Fourier Transorm output, as indicated in original document: "Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals)."
** Examples are: mean.fBodyBodyGyroJerkMag_meanFreq
* the _mean or _std component of the column name indiciates if the variables will be means of means or means of standard deviations
** Mean of mean example: mean.t.GravityAccMag_mean
** Mean of standard deviation example: mean.t.BodyGyroJerkMag_std
** Some of the column names will additionally specify that we deal with mean of mean frequency, as mean.fBodyBodyGyroMag_meanFreq
* Finally, some of the columns relate to particular axis of a gyroscope output. These will have X Y or Z at the end
** Example: mean.t.BodyAccJerk_mean_Z, mean.t.BodyGyroJerk_std_X, mean.fBodyGyro_meanFreq_Y

## Variables type and range

Column1 - subject is a ID of type integer; Range = [1;30] (30 subjects total)
Column2 - activity is a label of type character; Range = [LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS]
Column3 to Column 81 - are type of numeric in a range of [-1;1];

## Full list of columns with meaning, types and ranges:

### [1] "subject"
 * Type = integer
 * Range = [1;30]
 * Meaning = subject id
 
### [2] "activity"
 * Type = character
 * Range = [LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS]
 * Meaning = What the person was doing as seen on camera
 
### [3:81] all other columns 
 * Type = numeric
 * Range = [-1;1]
 * Meaning = Mean value of the mean or std per feature. Means are per subject per activity. Meaning is derivded as described above in "Column naming scheme" section.
 * Full list of all the other columns:
                          
 [3] "mean.t.BodyAcc_mean_X"              "mean.t.BodyAcc_mean_Y"             
 [5] "mean.t.BodyAcc_mean_Z"              "mean.t.BodyAcc_std_X"              
 [7] "mean.t.BodyAcc_std_Y"               "mean.t.BodyAcc_std_Z"              
 [9] "mean.t.GravityAcc_mean_X"           "mean.t.GravityAcc_mean_Y"          
[11] "mean.t.GravityAcc_mean_Z"           "mean.t.GravityAcc_std_X"           
[13] "mean.t.GravityAcc_std_Y"            "mean.t.GravityAcc_std_Z"           
[15] "mean.t.BodyAccJerk_mean_X"          "mean.t.BodyAccJerk_mean_Y"         
[17] "mean.t.BodyAccJerk_mean_Z"          "mean.t.BodyAccJerk_std_X"          
[19] "mean.t.BodyAccJerk_std_Y"           "mean.t.BodyAccJerk_std_Z"          
[21] "mean.t.BodyGyro_mean_X"             "mean.t.BodyGyro_mean_Y"            
[23] "mean.t.BodyGyro_mean_Z"             "mean.t.BodyGyro_std_X"             
[25] "mean.t.BodyGyro_std_Y"              "mean.t.BodyGyro_std_Z"             
[27] "mean.t.BodyGyroJerk_mean_X"         "mean.t.BodyGyroJerk_mean_Y"        
[29] "mean.t.BodyGyroJerk_mean_Z"         "mean.t.BodyGyroJerk_std_X"         
[31] "mean.t.BodyGyroJerk_std_Y"          "mean.t.BodyGyroJerk_std_Z"         
[33] "mean.t.BodyAccMag_mean"             "mean.t.BodyAccMag_std"             
[35] "mean.t.GravityAccMag_mean"          "mean.t.GravityAccMag_std"          
[37] "mean.t.BodyAccJerkMag_mean"         "mean.t.BodyAccJerkMag_std"         
[39] "mean.t.BodyGyroMag_mean"            "mean.t.BodyGyroMag_std"            
[41] "mean.t.BodyGyroJerkMag_mean"        "mean.t.BodyGyroJerkMag_std"        
[43] "mean.fBodyAcc_mean_X"               "mean.fBodyAcc_mean_Y"              
[45] "mean.fBodyAcc_mean_Z"               "mean.fBodyAcc_std_X"               
[47] "mean.fBodyAcc_std_Y"                "mean.fBodyAcc_std_Z"               
[49] "mean.fBodyAcc_meanFreq_X"           "mean.fBodyAcc_meanFreq_Y"          
[51] "mean.fBodyAcc_meanFreq_Z"           "mean.fBodyAccJerk_mean_X"          
[53] "mean.fBodyAccJerk_mean_Y"           "mean.fBodyAccJerk_mean_Z"          
[55] "mean.fBodyAccJerk_std_X"            "mean.fBodyAccJerk_std_Y"           
[57] "mean.fBodyAccJerk_std_Z"            "mean.fBodyAccJerk_meanFreq_X"      
[59] "mean.fBodyAccJerk_meanFreq_Y"       "mean.fBodyAccJerk_meanFreq_Z"      
[61] "mean.fBodyGyro_mean_X"              "mean.fBodyGyro_mean_Y"             
[63] "mean.fBodyGyro_mean_Z"              "mean.fBodyGyro_std_X"              
[65] "mean.fBodyGyro_std_Y"               "mean.fBodyGyro_std_Z"              
[67] "mean.fBodyGyro_meanFreq_X"          "mean.fBodyGyro_meanFreq_Y"         
[69] "mean.fBodyGyro_meanFreq_Z"          "mean.fBodyAccMag_mean"             
[71] "mean.fBodyAccMag_std"               "mean.fBodyAccMag_meanFreq"         
[73] "mean.fBodyBodyAccJerkMag_mean"      "mean.fBodyBodyAccJerkMag_std"      
[75] "mean.fBodyBodyAccJerkMag_meanFreq"  "mean.fBodyBodyGyroMag_mean"        
[77] "mean.fBodyBodyGyroMag_std"          "mean.fBodyBodyGyroMag_meanFreq"    
[79] "mean.fBodyBodyGyroJerkMag_mean"     "mean.fBodyBodyGyroJerkMag_std"     
[81] "mean.fBodyBodyGyroJerkMag_meanFreq"