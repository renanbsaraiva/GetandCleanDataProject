#This code creates a tidy data using data from the accelerometers of the Samsung Galaxy S smartphone


#Create tables from data files

subjtrain <- read.table("subject_train.txt")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
subjtest <- read.table("subject_test.txt")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
features <- read.table("features.txt")


#Merges the training and the test sets to create one data set.

datatrain <- subjtrain
datatrain$activity <- ytrain$V1
datatrain$Condition <- 1
datatrain <- cbind(datatrain, xtrain[,1:6])      #Get only main variables from the entire features
datatrain <- cbind(datatrain, xtrain[,41:46])    #Get only main variables from the entire features
datatrain <- cbind(datatrain, xtrain[,81:86])    #Get only main variables from the entire features
datatrain <- cbind(datatrain, xtrain[,121:126])  #Get only main variables from the entire features
datatrain <- cbind(datatrain, xtrain[,161:166])  #Get only main variables from the entire features

#Name the columns of datatrain dataset
names(datatrain) <- c("Subject", "Activity", "TrainorTest", 
                      "Mean of body acceleration time in X axis", 
                      "Mean of body acceleration time in Y axis",
                      "Mean of body acceleration time in Z axis",
                      "Standard deviation of body acceleration time in X Axis",
                      "Standard deviation of body acceleration time in Y Axis",
                      "Standard deviation of body acceleration time in Z Axis",
                      "Mean of gravity acceleration in X axis",
                      "Mean of gravity acceleration in Y axis",
                      "Mean of gravity acceleration in Z axis",
                      "Standard deviation of gravity acceleration in X axis",
                      "Standard deviation of gravity acceleration in Y axis",
                      "Standard deviation of gravity acceleration in Z axis",
                      "Mean of body acceleration Jerk time in X axis",
                      "Mean of body acceleration Jerk time in Y axis",
                      "Mean of body acceleration Jerk time in Z axis",
                      "Standard deviation of body acceleration Jerk time in X axis",
                      "Standard deviation of body acceleration Jerk time in Y axis",
                      "Standard deviation of body acceleration Jerk time in Z axis",
                      "Mean of body gyro time in X axis",
                      "Mean of body gyro time in Y axis",
                      "Mean of body gyro time in Z axis",
                      "Standard deviation of body gyro time in X axis",
                      "Standard deviation of body gyro time in Y axis",
                      "Standard deviation of body gyro time in Z axis",
                      "Mean of body gyro Jerk time in X axis",
                      "Mean of body gyro Jerk time in Y axis",
                      "Mean of body gyro Jerk time in Z axis",
                      "Standard deviation of body gyro Jerk time in X axis",
                      "Standard deviation of body gyro Jerk time in Y axis",
                      "Standard deviation of body gyro Jerk time in Z axis"
                      )

datatest <- subjtest
datatest$activity <- ytest$V1
datatest$Condition <- 2
datatest <- cbind(datatest, xtest[,1:6])         #Get only main variables from the entire features
datatest <- cbind(datatest, xtest[,41:46])       #Get only main variables from the entire features
datatest <- cbind(datatest, xtest[,81:86])       #Get only main variables from the entire features
datatest <- cbind(datatest, xtest[,121:126])     #Get only main variables from the entire features
datatest <- cbind(datatest, xtest[,161:166])     #Get only main variables from the entire features

#Name the columns of datatest dataset
names(datatest) <- c("Subject", "Activity", "TrainorTest", 
                      "Mean of body acceleration time in X axis", 
                      "Mean of body acceleration time in Y axis",
                      "Mean of body acceleration time in Z axis",
                      "Standard deviation of body acceleration time in X Axis",
                      "Standard deviation of body acceleration time in Y Axis",
                      "Standard deviation of body acceleration time in Z Axis",
                      "Mean of gravity acceleration in X axis",
                      "Mean of gravity acceleration in Y axis",
                      "Mean of gravity acceleration in Z axis",
                      "Standard deviation of gravity acceleration in X axis",
                      "Standard deviation of gravity acceleration in Y axis",
                      "Standard deviation of gravity acceleration in Z axis",
                      "Mean of body acceleration Jerk time in X axis",
                      "Mean of body acceleration Jerk time in Y axis",
                      "Mean of body acceleration Jerk time in Z axis",
                      "Standard deviation of body acceleration Jerk time in X axis",
                      "Standard deviation of body acceleration Jerk time in Y axis",
                      "Standard deviation of body acceleration Jerk time in Z axis",
                      "Mean of body gyro time in X axis",
                      "Mean of body gyro time in Y axis",
                      "Mean of body gyro time in Z axis",
                      "Standard deviation of body gyro time in X axis",
                      "Standard deviation of body gyro time in Y axis",
                      "Standard deviation of body gyro time in Z axis",
                      "Mean of body gyro Jerk time in X axis",
                      "Mean of body gyro Jerk time in Y axis",
                      "Mean of body gyro Jerk time in Z axis",
                      "Standard deviation of body gyro Jerk time in X axis",
                      "Standard deviation of body gyro Jerk time in Y axis",
                      "Standard deviation of body gyro Jerk time in Z axis"
)

#Create a unified dataset called dataTrainTest using datatrain and datatest
dataTrainTest <- rbind(datatrain,datatest)


#Uses descriptive activity names to name the activities in the data set
dataTrainTest$Activity[dataTrainTest$Activity==1] <- "Walking"
dataTrainTest$Activity[dataTrainTest$Activity==2] <- "Walking_UpStairs"
dataTrainTest$Activity[dataTrainTest$Activity==3] <- "Walking_DownStairs"
dataTrainTest$Activity[dataTrainTest$Activity==4] <- "Sitting"
dataTrainTest$Activity[dataTrainTest$Activity==5] <- "Standing"
dataTrainTest$Activity[dataTrainTest$Activity==6] <- "Laying"

#Creates an independent tidy data set with the average of each variable for each activity and each subject.

install.packages("plyr")
library(plyr)
tidyData <- ddply(dataTrainTest, .(Subject,Activity),numcolwise(mean))

write.Table(tidyData, row.name=FALSE)

