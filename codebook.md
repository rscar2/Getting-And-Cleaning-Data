## This codebook decribes the variables, the data, and any transformations or work performed to clean up the data

The data used to generate the files in this repository was downloaded from:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012. This dataset
is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any 
commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

The dataset is composed of measurements of human activity through the use of a Samsung Smartphone. The experiments have been carried out with a group of 
30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING,
LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and
3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been 
randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec 
and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth
low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz
cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 
See 'features_info.txt' for more details. 

The original data was manipulated in the following manner to produce xMeanStdValues.csv:

- First the Train and Test data was combined into a large data frame consisting of 10299 observations (rows), and 561 measurements (columns)
- Features.txt was read to get all the variable names and activity.txt was read to get the activity labels for each code in the Train and Test data
- This data frame was reduced in size by extracting all the column names that had either "mean" or "std" in them. Columns go from 561 to 79
- The resulting data frame finally had 2 leading columns added to it, subject name and activity name was decoded from a number to a more descriptive string 

The 2ndTidyDataSet.csv file was produced by manipulating the xMeanStdValues data frame in the following manner:

- Through the use of 2 nested loops, we cycle through all the unique subject names and all the unique activity names
- We capture the row locations of every row that contains the specific subject name and activity name and store it in a vector
- The average of every one of the 79 variables is computed using the colMeans() function
- rows are added to the new data set as the nested loop cycle through the use of the rbind() function 
- 30 unique subjects by 6 unique activities are what produce the total 180 rows of this dataset
- Final data set is written to 2ndTidyDataSet.csv
