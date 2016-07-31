################################################################################
# Libraries                                                                    #
################################################################################
library(data.table)
library(dplyr)
library(plyr)

################################################################################
# 1:Merges the training and the test sets to create one data set.              #
################################################################################

# Choose file train
setwd("~/Desktop/UCI HAR Dataset/train")
list.files()
# Read test set
x_train<-read.table("X_train.txt");y_train<-read.table("y_train.txt")
subject_train<-read.table("subject_train.txt")
train<-cbind(subject_train, y_train, x_train)
train<-tbl_df(train)
train
# Choose file test
setwd("~/Desktop/UCI HAR Dataset/test")
list.files()
# Read train set
x_test<-read.table("X_test.txt");y_test<-read.table("y_test.txt")
subject_test<-read.table("subject_test.txt")
test<-cbind(subject_test, y_test, x_test)
test<-tbl_df(test)
test
# Merge test and train data
mergeData<-rbind(train,test)
mergeData

################################################################################
# 2:Extracts only the measurements on the mean and standard deviation for each #
#   measurement.                                                               #
################################################################################

# Read file features 
setwd("~/Desktop/UCI HAR Dataset")
list.files()
features<-read.table("features.txt")
features<-as.matrix(features$V2)
# Rename columns
colnames(mergeData) <- c("subject","activity",features)
# Extracts only the measurements on the mean and standard deviation for each 
# measurement.
mergeData<-mergeData[,grep("subject|activity|mean\\(\\)|std\\(\\)",
                           colnames(mergeData))]

################################################################################
# 3:Uses descriptive activity names to name the activities in the data set     #
################################################################################

# Choose file
setwd("~/Desktop/UCI HAR Dataset")
list.files()
# Read activity labels
activity_labels<-read.table("activity_labels.txt")
# Transform  activity names to name the activities
mergeData$activity<-as.factor(mergeData$activity)
levels(mergeData$activity) <- activity_labels$V2


################################################################################
# 4:Appropriately labels the data set with descriptive variable names.         #
################################################################################

#Replace "-" for "."
colnames(mergeData)<-gsub("-",".",colnames(mergeData))
mergeData

################################################################################
# 5:Creates a second, independent tidy data set with the average of each varia-#
#   ble for each activity and each subject.                                    #
################################################################################

# The average of each variable for each activity
mergeData<-data.table(mergeData)
tidy_data<-group_by(mergeData,activity,subject)
tidyData<-summarise_each(tidy_data,funs(mean))
write.table(tidyData,"tidyData.txt", row.names = FALSE)

