# 1.-Merges the training and the test sets to create one data set.

## Choose file train
setwd("~/Desktop/UCI HAR Dataset/train")
list.files()
## Read test set
train<-read.table("X_train.txt")
labelstrain<-read.table("y_train.txt")
library(data.table);train<-data.table(train);labelstrain<-data.table(labelstrain)
names(labelstrain)<-"V0"
trainl<-cbind(labelstrain,train)
## Choose file test
setwd("~/Desktop/UCI HAR Dataset/test")
list.files()
## Read train set
test<-read.table("X_test.txt")
test<-data.table(test)
labelstest<-read.table("y_test.txt")
labelstest<-data.table(labelstest)
names(labelstest)<-"V0"
testl<-cbind(labelstest,test)
## print the names attribute of the train and test
names(trainl)
names(testl)
## Merge test and train
mergeData<-rbind(testl,trainl)
str(mergeData)
dim(mergeData)


# 2.-Extracts only the measurements on the mean and standard deviation for each 
# measurement.


## Read file features 
setwd("~/Desktop/UCI HAR Dataset")
list.files()
features<-read.table("features.txt")
## Extracts only the measurements on the mean and standard deviation for each 
## measurement.
(m<-features[grep("(mean|std)", features[,2]),])


#3.-Uses descriptive activity names to name the activities in the data set


## Choose file train
setwd("~/Desktop/UCI HAR Dataset")
list.files()
activitylabels<-read.table("activity_labels.txt")
activity <- as.factor(mergeData$V0)
## Transform  activity names to name the activities
levels(activity) <- activitylabels$V2


# 4. Appropriately labels the data set with descriptive variable names.
data<-cbind(activity,mergeData)
datalabels<-data.table(data)


# 5. Creates a second, independent tidy data set with the average of each variable 
#    for each activity and each subject.


## Read file subject train
setwd("~/Desktop/UCI HAR Dataset/train")
list.files()
strain<-read.table("subject_train.txt")

## Read file subject test
setwd("~/Desktop/UCI HAR Dataset/test")
list.files()
stest<-read.table("subject_test.txt")

## Merge data
sub<-data.table(rbind(strain,stest))
names(sub)<-"subject"
data<-cbind(sub,datalabels)
head(data,1)

# The average of each variable for each activity and each subject. 
library(reshape2)
meandata<-dcast(data, subject~ variable, mean)

