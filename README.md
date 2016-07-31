# For run the  script "run_analysis.R", you need the following libraries:

-data.table

-dplyr

-plyr

## The script is divided in 5 steps

# Step 1: Merges the training and the test sets to create one data set.
Combine the test and train set  (X,y,subject) in mergeData.

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.                                                               
Rename column names of mergeData with the names of features.txt and add only the 
the column on the mean and standard deviation.

# Step 3: Uses descriptive activity names to name the activities in the data set
Transform  activity names to name the activities

# Step 4: Appropriately labels the data set with descriptive variable names.         
Replace "-" for "." in the columns names

# Step 5:Creates a second, independent tidy data set with the average of each variable for each activity and each subject.          
Create a file "tidy Data.text" with the requirements of the step 5
