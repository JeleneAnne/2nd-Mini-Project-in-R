# load libraries
library(dplyr) 

# set dataset directory
setwd("C:\\Users\\casti\\OneDrive\\Desktop\\2ndminiproject\\specdata")

# read features description 
features <- read.table("./UCI HAR Dataset/features.txt", col.names=c("n","functions"))

# read activity labels 
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity")) 

# read train data 
x_train   <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features$functions)
y_train   <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names="code") 
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "subject")

# read test data 
x_test   <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features$functions)
y_test   <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="code") 
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "subject")



# merge of training and test sets
x_total   <- rbind(x_train, x_test)
y_total   <- rbind(y_train, y_test) 
sub_total <- rbind(sub_train, sub_test) 
Merged_Data <- cbind(sub_total, y_total, x_total)



# keep only measurements for mean and standard deviation 
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# uses the descriptive activity names to name the activity in the data set
TidyData$code <- activity_labels[TidyData$code, 2]

# labels appropriately the data set with descriptive variable names
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# creates a second independent tidy data set with the average of each variable for each activity and each subject from the data set above
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)