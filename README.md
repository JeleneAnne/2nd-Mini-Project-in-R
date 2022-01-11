Step-by-step procedure
1. loading datasets
2. set the dataset directory
3. read the features description from the textfile with the column names n and function 
4. read activity labels from the textfile with the column names code and activity
5. read train data and renamed the columns
6. read test data and renamed the columns
7. merge of training and test sets using rbind
8. keep only measurements for mean and standard deviation 
9. uses the descriptive activity names to name the activity in the data set
10. labels appropriately the data set with descriptive variable names
11. creates a second independent tidy data set with the average of each variable for each activity and each subject from the data set above
