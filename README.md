## The following README file explains how run_analysis.R works

This repository contains the following files:

- run_analysis.R
- codebook.md
- xMeanStdValues.csv 
- 2ndTidyDataSet.csv

run_analysis.R is the script that is used to generate both output files, xMeanStdValues.csv and 2ndTidyDataSet.csv by doing the following:

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

run_analysis.R manipulates the data in this manner:

- First the Train and Test data was combined into a large data frame consisting of 10299 observations (rows), and 561 measurements (columns)
- Features.txt was read to get all the variable names and activity.txt was read to get the activity labels for each code in the Train and Test data
- This data frame was reduced in size by extracting all the column names that had either "mean" or "std" in them. Columns go from 561 to 79
- The resulting data frame finally had 2 leading columns added to it, subject name and activity name was decoded from a number to a more descriptive string 
- This data frame, xMeanStdValues, is written to xMeanStdValues.csv

The 2ndTidyDataSet.csv file is produced by manipulating the xMeanStdValues data frame in the following manner:

- Through the use of 2 nested loops, we cycle through all the unique subject names and all the unique activity names
- We capture the row locations of every row that contains the specific subject name and activity name and store it in a vector
- The average of every one of the 79 variables is computed using the colMeans() function
- rows are added to the new data set as the nested loop cycle through the use of the rbind() function 
- 30 unique subjects by 6 unique activities are what produce the total 180 rows of this dataset
- Final data set is written to 2ndTidyDataSet.csv

The data used to generate the files in this repository was downloaded from:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012. This dataset
is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any 
commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

More information on this data and how is was used to produce the output files can be found in the codebook.md file

