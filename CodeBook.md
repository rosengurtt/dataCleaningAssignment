# Code Book for Data Cleaning Course Assignment

This data corresponds to an experiment carried on with a smartphone used as a "wearable", measuring acceleration and angular velocity of 30 people, while they perform different activities. The data is divided in 2 sets of files, that have exactly the same structure, one called "train" and one called "test". From the point of view of this assignment is irrelevant the difference between test and train. The datasets created for the assignment contain the totality of the experiments, regardless of them being part of the "test" or the "training".

The raw data consist of the following:

- files with the raw readings from the smartphones
- files that allow the association of the readings to subjects and to the activities they were doing
- a file that provides the names of the variables of the experiments

In the first group (the raw readings), there are 2 type of files:
- files that contain readings for a particular axis and a particular measure (for example acceleration on the Z axis). These files are contained in the 2 folders called "Inertial Signals". These files were not used to produce the data sets of this assignment
- files that integrate the data from the different measures in the previous files. These are the files where the main data was extracted from. They are called "X_test.txt" and "X_train.txt"

To produce the datasets requested in the assignment, the following steps had to be performed:

1. Due to the fact that the raw data didn't provide headers, appropriate names were assigned to the data frames after reading the files

The names of the experiment variables were read from the file "features.txt". This is a csv file with 561 rows (there are therefore 561 experiment variables)

2. The data from the files containing the combined measures, was merged with the files providing the activities and subjects information, in order to produce a full set of data that contains all the information. This action had to be made independently for the "test" data and the "train" data

3. The train data was then merged with the test data in one full dataset

4. The columns of interest were extracted to produce the first dataset requested in the assignment (the columns that contain "mean" and "standard deviation" data, plus the activities and the subjects columns)

5. To produce the second data set, the average of each variable was calculated for each activity and subject

