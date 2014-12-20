#### Step 1. Merges the training and the test sets to create one data set ###

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

#############################################################################

###Step2. Extracts only the measurements on the mean and standard deviation for each measurement ####
library(plyr)
features <- read.table("features.txt")
###get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
# subset the columns required
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]
###################################################################################################

#### Step 3. Uses descriptive activity names to name the activities in the data set #######
activities <- read.table("activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"
##########################################################################################

### Step4. Appropriately labels the data set with descriptive variable names ##########
names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)
#######################################################################################

######5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)





