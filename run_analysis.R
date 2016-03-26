# downloading file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI HAR Dataset.zip")

# read data
activityLabels <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/activity_labels.txt"))
features <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/features.txt"))
meanOrStd <- grepl("mean\\(\\)|std\\(\\)", as.character(features[,2]))
subjectTest <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/test/subject_test.txt"))
xTest <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/test/X_test.txt"))
yTest <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/test/y_test.txt"))
subjectTrain <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/train/subject_train.txt"))
xTrain <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/train/X_train.txt"))
yTrain <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/train/y_train.txt"))

# merge data
harTest <- data.frame(subjectTest, activityLabels[,2][yTest[,1]], type = "test", xTest[, meanOrStd])
names(harTest) <- c("subject", "activity", "type", as.character(features[,2])[meanOrStd])
harTrain <- data.frame(subjectTrain, activityLabels[,2][yTrain[,1]], type = "train", xTrain[, meanOrStd])
names(harTest) <- names(harTrain) <- c("subject", "activity", "type", as.character(features[,2])[meanOrStd])
harData <- rbind(harTest, harTrain)
harData <- harData[order(harData$subject, harData$activity),]

# calculating averages
harDataAverages <- harData[1,]
subjects <- sort(unique(harData$subject))
activities <- levels(harData$activity)
variables <- names(harData)[4:length(names(harData))]
for (subject in subjects) {
  for (activity in activities) {
    relatedIndices <- harData$subject == subject & harData$activity == activity
    oneRowData <- list(subject = subject, activity = activity, type = harData$type[relatedIndices][1])
    for (variable in variables) {
      oneRowData <- c(oneRowData, mean = mean(harData[relatedIndices, variable]))
    }
    names(oneRowData) <- names(harDataAverages)
    harDataAverages <- rbind(harDataAverages, oneRowData)
  }
}
harDataAverages <- harDataAverages[2:length(harDataAverages[,1]),]
