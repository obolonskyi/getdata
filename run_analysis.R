

Sys.setlocale(category = "LC_ALL", locale = "english")
setwd("D:/COursera/Data Science/UCI HAR Dataset/")

#Merges the training and the test sets to create one data set.

## general tables

activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")[,2]

##Read TEST tables
subject_tests <- read.table("./test/subject_test.txt", header = FALSE)
x_test <- read.table("./test/X_test.txt", header = FALSE)
y_test <- read.table("./test/y_test.txt", header = FALSE)

##Read TRAIN tables
subject_train <- read.table("./train/subject_train.txt")
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")


##Appropriately labels the data set with descriptive variable names.
features <- gsub("\\(|\\)", "", features, perl  = TRUE)

##Assigning names of the columns in datasets
colnames(activity_labels) <- c("activity_ID","activity_type")
colnames(x_test) <- features
colnames(y_test) <-"activity_ID"
colnames(x_train) <- features
colnames(y_train) <- "activity_ID"
colnames(subject_tests) <- "Sub_ID"
colnames(subject_train) <- "Sub_ID"


##Concatenate all data sets in one with descriptive names of columns

con_data<- rbind(cbind(y_test, subject_tests, x_test),cbind(y_train, subject_train, x_train))

##Extracts only the measurements on the mean and standard deviation for each measurement.
mean_data <- con_data[,grepl("mean|std|Sub_ID|activity_ID", names(con_data))]


##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
tidy_means <- ddply(mean_data, c("activity_ID", "Sub_ID"), numcolwise(mean))

write.table(tidy_means,file="tidydata_means.txt", row.name=FALSE)
  