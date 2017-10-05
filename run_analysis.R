## These functions do a data clean job of the data from
##
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## as per the requirements set in the Assignment instructions

## The path to the unzipped files must be passed as a parameter
## If it is not passed, it assumes the current working directory is the directory with the unzipped files

## GetCleanData creates the first dataset requested in the assignment

GetCleanData <- function(pathToDataFolder = ""){
    
    # We use the dplyr package
    library(dplyr)
    
    # These are the files with the information we will be reading
    columnNamesFile = file.path(pathToDataFolder, "features.txt")
    activitLabelsFile = file.path(pathToDataFolder, "activity_labels.txt")
    testSubjectsFile = file.path(pathToDataFolder, "test", "subject_test.txt")
    trainSubjectsFile = file.path(pathToDataFolder, "train", "subject_train.txt")
    testLabelsFile = file.path(pathToDataFolder, "test", "y_test.txt")
    trainLabelsFile = file.path(pathToDataFolder, "train", "y_train.txt")
    testDataFile = file.path(pathToDataFolder, "test", "X_test.txt")
    trainDataFile = file.path(pathToDataFolder, "train/", "X_train.txt")
    
    # Read the files into dataframes
    # These files are normal csv files, most have just one column. One uses a space as separator
    # instead of a comma. None has headers
    columnNames<-read.csv(columnNamesFile, sep=" ", header = FALSE)
    activityLabels<-read.csv(activitLabelsFile, header = FALSE, sep = " ")
    testSubjects<-read.csv(testSubjectsFile, header = FALSE)
    trainSubjects<-read.csv(trainSubjectsFile, header = FALSE)
    testLabels<-read.csv(testLabelsFile, header = FALSE)
    trainLabels<-read.csv(trainLabelsFile, header = FALSE)
    
    # We calculate the number of columns, because we need this value to read the data files
    numberOfColumns = nrow(columnNames)
    
    # The format of these files is fixed width, with a constant width of 16 characters for
    # all the columns
    lengthOfDataFields = 16
    testData<-read_fwf(testDataFile, fwf_widths(rep(lengthOfDataFields, numberOfColumns)))
    trainData<-read_fwf(trainDataFile, fwf_widths(rep(lengthOfDataFields, numberOfColumns)))
    
    # The files have no column names. We assign them appropirate names
    names(columnNames)<-c("seq","name")
    names(activityLabels)<-c("seq","activity")
    names(testSubjects)<-c("subject")
    names(trainSubjects)<-c("subject")
    names(testLabels)<-c("seq")
    names(trainLabels)<-c("seq")
    names(testData)<-as.vector(columnNames$name)
    names(trainData)<-as.vector(columnNames$name)
    
    # We add the activity labels descriptive names to the labels files:
    testLabels<-merge(testLabels,activityLabels)
    trainLabels<-merge(trainLabels,activityLabels)
    
    # We now merge the labels, subjects and data tables for both test and train data:
    fullTestData<-cbind(testLabels, testSubjects, testData)
    fullTrainData<-cbind(trainLabels, trainSubjects, trainData)
    
    # We now merge the rows from those 2 data frames
    fullData <- rbind(fullTestData, fullTrainData)
    
    # We now extract extract the columns that we are interested:
    # the activity and subject columns, and all the mean and standard deviation ones
    fullData[,grepl("mean|std|activity|subject", colnames(fullData))]
    
}

## GetAveragedCleanedData creates the second data set requested in the assingnment
GetAveragedCleanedData <- function(pathToDataFolder = ""){
    
    # Get the full data first
    selectedData <- GetCleanData(pathToDataFolder)
    
    # Extract averaged data per activity and subject
    averagedSelectedData<- selectedData %>% group_by(activity,subject) %>% summarise_all(funs(mean(., na.rm=TRUE)))
    
}