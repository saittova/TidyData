##### Data import
features <- read.table("Data/features.txt")
xtrain <- read.table("Data/train/X_train.txt")
ytrain <- read.table("Data/train/y_train.txt")

xtest <- read.table("Data/test/X_test.txt")
ytest <- read.table("Data/test/y_test.txt")

subjecttest <- read.table("Data/test/subject_test.txt")
subjecttrain <- read.table("Data/train/subject_train.txt")


##### Combining data

features2 <- t(data.frame(features[, 2]))
names <- c(features2, "subject", "Activity")

# Lets formulate the train data into one set
traindata <- cbind(xtrain, subjecttrain)
traindata <- cbind(traindata, ytrain)
colnames(traindata) <- c(1:563)

# Lets formulate the test data into one set
testdata <- cbind(xtest, subjecttest)
testdata <- cbind(testdata, ytest)
colnames(testdata) <- c(1:563)

#Merge test and train data
alldata <- merge(testdata, traindata, all.x=T, all.y=T)

#Lets add labels
actvLabels <- read.table("Data/activity_labels.txt")
alldataLabels <- cbind(alldata, sapply(alldata[,563], function(x) actvLabels[x,2]))
alldataFinal <- alldataLabels[,-563]
colnames(alldataFinal) <- names

##### Filter the unwanted columns

#lets filter columns based on column names - note that meanFreq's are taken away from all mean values
check <- (grepl("mean", colnames(alldataFinal)) * !grepl("meanFreq", colnames(alldataFinal))) + grepl("std", colnames(alldataFinal))
#lets make index list of selected columns
idx <- which(check == 1, arr.ind = TRUE)
#now add the subject and activity column indexes
idx <- c(idx, 562, 563)

#Now extract the data to new filtered set
finalSet <- alldataFinal[, idx]

##### Calculations

#Now lets create a data set with averages of each variable for each activity and each subject
SubjAverage <- cbind(finalSet[,67], apply(finalSet[,1:66], 1, mean))
SubjAverage <- aggregate(SubjAverage, by=list(SubjAverage[,1]), FUN=mean)
SubjAverage <- SubjAverage[,-2]
colnames(SubjAverage) <- c("Subject", "Average")

actvAverage <- cbind(finalSet[,68], apply(finalSet[,1:66], 1, mean))
actvAverage <- aggregate(actvAverage, by=list(actvAverage[,1]), FUN=mean)
actvAverage <- actvAverage[,-2]
colnames(actvAverage) <- c("Activity", "Average")


##### Write files

write.table(finalSet, file="finalSet.txt")
write.table(SubjAverage, file="SubjAverage.txt")
write.table(actvAverage, file="actvAverage.txt")


