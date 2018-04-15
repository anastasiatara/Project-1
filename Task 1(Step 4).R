#BY TADZIO
getwd()
setwd("~/Desktop")

##Brought the datasets into R using the read.table command (TADZIO)
##Created new variables for each one to make manipulation easier (TADZIO) 

y_train1 <- read.table(file = "/Users/Tadzio/Desktop/y_train.txt")
x_train1 <- read.table(file = "/Users/Tadzio/Desktop/x_train.txt")
y_test1 <- read.table(file = "/Users/Tadzio/Desktop/y_test.txt")
x_test1 <- read.table(file = "/Users/Tadzio/Desktop/x_test.txt")

##Used the cbind command to merge the datasets into their respective training and testing variables (TADZIO)
##By doing so I reduced the # of datasets from 4 to 2 (TADZIO)

training_data <- cbind(y_train1,x_train1)
testing_data <- cbind(y_test1, x_test1)

##To fully merge the two into one, I used the rbind command to combine the rows (TADZIO)

##We now have one merged dataset (TADZIO)
merged_data <- rbind(training_data, testing_data)

#BY NOAH
##In order to rename the variables for easy subsetting, you have to import the features.txt file which describes the recorded variables
  ##Note: make sure to load dplyr package
library(dplyr)
features <- read.table(file="/Users/noah_hilton/Desktop/features.txt")
features2 <- select.list(features, c(2)) ##selects only variable name column of features table
features_transposed <- t(features2)  ##converts features2 table into a character vector
colnames (merged_data) [2:562] <- features_transposed  ##uses features_transposed vector to rename merged_data column headers [2:562]
colnames(merged_data) [1] <- "Activity"  ##renames first column of merged_data table to reference activity output

#BY TADZIO
##In order to extract just the mean and standard dev I referenced the features.txt file to figure out 
  ##which column in the dataset refered to the either mean or standard dev

##I then created a vector using the c() command to extract only the mean and standard dev measurements.
##Those were then placed under the title of merged_data_mean_and_std

merged_data_mean_and_std <- merged_data[c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543 )]

#BY NOAH
#using a string of if_else commands, we can code the activity labels in activity_labels.txt to their corresponding activities
merged_data_mean_and_std$Activity_Label <- if_else(merged_data_mean_and_std$Activity == 1,"WALKING",(
  if_else(merged_data_mean_and_std$Activity == 2,"WALKING_UPSTAIRS",(
    if_else(merged_data_mean_and_std$Activity == 3, "WALKING_DOWNSTAIRS",(
      if_else(merged_data_mean_and_std$Activity == 4, "SITTING",(
        if_else(merged_data_mean_and_std$Activity == 5, "STANDING",(
          if_else(merged_data_mean_and_std$Activity == 6, "LAYING","NA")))))))))))

#BY ANASTASIA
##With gsub we are labelling names of features using descriptive variable names 
names(features)<-gsub("^t", "time", names(features))
names(features)<-gsub("^f", "frequency", names(features))
names(features)<-gsub("Acc", "Accelerometer", names(features))
names(features)<-gsub("Gyro", "Gyroscope", names(features))
names(features)<-gsub("Mag", "Magnitude", names(features))
names(features)<-gsub("BodyBody", "Body", names(features))

names(features)

