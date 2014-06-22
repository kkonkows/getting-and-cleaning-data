# Coursera "Getting and Cleaning Data" course project

Thank you for your time in evaluation this project. This is a markdown document for run_analysis.R script, a part of the "Getting and Cleaning Data" course project. This file does not describe data structure. For this information please open CodeBook.md file.

Let me quickly describe you parts of the script, what it does, etc. This README.md follows the script comments and is divided into sections - each one representing a code below particular # comment line.

Script should be run in a directory above unzipped data set (that is in a parent directory for "UCI HAR Dataset" directory, or in other words in "../UCI HAR Dataset"). One can optinally uncomment some parts of the code if they are willing to download and unzip the dataset to a newly created directory.

## Optional file download

Please have a look at lines 1 to 5, which are by default commented. This is to prevent unnecessary downloads and unzip operation after the dataset has been saved on local hard drive. One could use file checks to make sure the download does not repeat and resign from commenint out the code - due to time constraints, however, I preferred to do as in script and spend more time on more relevant parts of the project.

## Setting up working directory

Line 7 sets the working directory - this is for convienience, not to use full file paths, but rather "./" + file name instead.

Consequently, line 71 sets back the working directory to what it was before - to make sure scripts behaves neatly.

## Reading in from dataset

In lines 11 - 17 the script performs a series of read.table operations creating data.frame objects based on the contents of train and test files. Files used in the script are:
* /UCI HAR Dataset/test/X_test.txt
* /UCI HAR Dataset/test/y_test.txt
* /UCI HAR Dataset/test/subject_test.txt
* /UCI HAR Dataset/train/X_train_.txt
* /UCI HAR Dataset/train/y_train_.txt
* /UCI HAR Dataset/train/subject_train_.txt

Other files, especially located in folders "/UCI HAR Dataset/test/Inertial Signals/" and "/UCI HAR Dataset/train/Inertial Signals/" are not needed to complete the project and because of memory burden they are not read in.

Read data.frame objects are saved according to intuitive nomenclature - "df" + "[Train|Test]" + "[X|Y|Subject]" depending on the file.

## Joining data frame objects

Lines 21 - 27 of the code constitute section that binds the read in data.frame objects together. First, scrips collapses training and test data so that they are in one data structure. Script does that with rbind (combining data.frame objects of the same number of columns). In effect three variables are produced:

* dfX - a data.frame object combining dfTestX and dfTrainX
* dfY - a data.frame object combining dfTestY and dfTrainY
* dfSubject - a data.frame object combining dfTestSubject and dfTrainSubject

Next, scripts gives names to columns for dfY and dfSubject, which are going to be cbind to dfX. This is for convience for durther merge operation.

In line 27, the dfX, dfY and dfSubject are cbind together - I choose to put dfSubject first, as it is more intuitive to have reference to observation ID in the begining.

## Reading in the column names

Lines 31 - 34 are used to read in feature names and activity labels. Two objects are created:

* yLabels - data.frame with labels corresponding to activity ids;
* xNames - data.frame with column names;

Lines 33 and 34 are used to make sure we deal with character vectors (and not for instance, with factors what could break further functions)

## Manipulating column names with regular expressions

Before applying column names to df object, the script sanitizes column names - getting rid of '-', ',', '(', ')' characters. This operation is to make sure no further operations on columns will break due to indexing column name which may look like a name with additional R code, i.e. without this section we could run in following problem while executing a command:

*df$fBodyGyro-bandsEnergy()-25,48*

Not sure how R would be able to decide if we wish to do column extraction or some other (i.e. math operation). Hence this section may be needed.

## Substituting activity indexes for character label

In line 45 there is merge operation on df data.frame object which in effect produces additional column for each row - the column with label written as charaters. In line 46 script removes the column with indices, leaving only descriptive activity label.

Please not the merge operation will leave data.frame unordered.

The result of this section is labeledDF data.frame object - the one with activity labels instead of indices.

## Assiging column names

In lines 50 - 53 script prepares column names, adding a one for "subject" in front of xNames nad the one for "activity_label" as a last entry. Such prepared object - xNames$V2 (as we need only a list of column names) is used to populate names of labeledDF.

## Extraction of columns conveying mean and std

Line 59 extracts only these columns from labeledDF that have "mean" or "std" or "activity_label" or "subejct" as a part of their names. This is according to project requirements. Script behaves case sensitive here, and columns with "Mean" will not be included. This is my choice, as "angle()" features do not seem to be exactly means or standard deviations.

To extract column names, regular expressions are used by grep function.

Result of this line is a data.frame object "extracted" with 81 columns.

## Aggregation of the data to final tidy form

Line 59 produces output data.frame object by aggregate function. The object works on columns 2 - 80 (no need to agregate ID of the subject, neither cannot average characters - such as activity label). In other words, only columns 2 - 80 are being aggregated by mean function. Aggregation, though is based on subject column and activity_label column. This may seem a bit tricky, so in other words - the script uses subject column and activity_label column as aggregation groups, but computes means only on mean and std features.

As a result of this section output data.frame object is produced.

## Adjusting naming of the final data.frame column names

Lines 63 - 65 are used to rename columns - it is important to change them, as their sense has changed, now these are means of means of means of stds. I decied to us "mean." as a prefix to original column.

## Saving files and cleanup

In lines 69 and 70 the output data.frame object is saved as CSV and TXT file accordingly. Script ommit row names to be easier read. Line 72 brings back original working directory.

