#setwd("~/Documents/Stanford/Getting-Data/workspace/");

# Please uncomment if working you wish to download and unzip the files:
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="dataset.zip", method="curl");
#unzip("dataset.zip");

setwd('./UCI HAR Dataset/');

# Read in data:

dfTestY = read.table('./test/y_test.txt', sep="");
dfTestX = read.table('./test/X_test.txt', sep="");
dfTestSubject = read.table('./test/subject_test.txt', sep="");

dfTrainY = read.table('./train/y_train.txt', sep="");
dfTrainX = read.table('./train/X_train.txt', sep="");
dfTrainSubject = read.table('./train/subject_train.txt', sep="");

# Join data.frames:

dfX = rbind(dfTestX, dfTrainX);
dfY = rbind(dfTestY, dfTrainY);
dfSubject = rbind(dfTestSubject, dfTrainSubject);
names(dfY) <- c("LABEL");
names(dfSubject) <- c("SUBJECT");

df = cbind(dfSubject, dfX, dfY);

# Read in labels and column names:

yLabels = read.table("./activity_labels.txt", sep="");
xNames = read.table("./features.txt", sep="");
yLabels$V2 <- as.character(yLabels$V2);
xNames$V2 <- as.character(xNames$V2);

# Do some regexps to make sure the column names are safe to use in any R script:

xNames$V2 = gsub("-", "_", xNames$V2, perl=T);
xNames$V2 = gsub(",", "_", xNames$V2, perl=T);
xNames$V2 = gsub("\\(", "", xNames$V2, perl=T);
xNames$V2 = gsub("\\)", "", xNames$V2, perl=T);

# Substitute activity idicies with character labels:

labeledDf = merge(df, yLabels, by.x = "LABEL", by.y = "V1");
labeledDf = labeledDf[,2:564];

# Assign new column naming:

xNames = rbind(c("0", "subject"), xNames);
xNames = rbind(xNames, c("562", "activity_label"));

names(labeledDf) = xNames$V2;

# Extract only those with mean, std or activity_label or subject in column name:
extracted = labeledDf[,grep("mean|std|activity_label|subject", names(labeledDf))];

# Prepare output version of tidy data frame:
output = aggregate(extracted[2:80], by=list(extracted$subject,extracted$activity_label), FUN=mean);

# Prepare new column naming (keep in min we are averaging):

names(output) = paste("mean.",names(output),sep="")
names(output)[1] = "subject";
names(output)[2] = "activity";

# Save to files:

write.csv(output, "../output.csv");
write.table(output, "../output.txt", row.names=F);

setwd('..');
