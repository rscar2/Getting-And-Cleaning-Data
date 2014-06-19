# This R script, called run_analysis.R does the following: 
#
# 1.Merges the training and the test sets to create one data set
# 2.Extracts only the measurements on the mean and standard deviation for each measurement
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names
# 5.Creates a second, independent tidy data set with the average of each variable for each
#   activity and each subject

# Assign x,y values for Test and Train

xTst<-read.table("UCI HAR Dataset/test/X_test.txt")
yTst<-read.table("UCI HAR Dataset/test/y_test.txt")
xTrn<-read.table("UCI HAR Dataset/train/X_train.txt")
yTrn<-read.table("UCI HAR Dataset/train/y_train.txt")

# Assign variable names from features file and activity labels from activity labels file

var_Names<-read.table("UCI HAR Dataset/features.txt")
var_Names<-var_Names$V2
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

# read subject IDs
subTst<-read.table("UCI HAR Dataset/test/subject_test.txt")
subTrn<-read.table("UCI HAR Dataset/train/subject_train.txt")

# add "Subject" to each subject ID
rename_sub<-function(x){return(paste("Subject", as.character(x), sep=""))}
subName_Tst<-sapply(subTst, FUN=rename_sub)
subName_Trn<-sapply(subTrn, FUN=rename_sub)

# Merge the test and train subjects
subName_merged<-rbind(subName_Tst, subName_Trn)

# Merge Test&Train for x:first 2947 rows are test, 2948 to 10299 are train, with 561 columns
# y merged has 10299 values on 1 column

xMerged<-rbind(xTst,xTrn)
names(xMerged)<-var_Names
yMerged<-rbind(yTst,yTrn) 

# Translate activity label to an activity name and put in a vector

Activity<-vector(mode="character", length=length(yMerged))

for(i in 1:6){
  locations<-which(yMerged==i)
  Activity[locations]<-as.character(activity_labels[i,2])
}

xMerged<-cbind(subName_merged,Activity,xMerged)
colnames(xMerged)[colnames(xMerged) == "V1"] <- "Subject"

# Find location of all mean + standard deviation variables within the merged x data and pull 
# those values out, resulting in 10299 rows and 82 columns, including Subject + Activity name

Index_Means_Std<-grep("mean|std", var_Names)+2
Index_Means_Std<-c(1,2,Index_Means_Std)
xMeanStdValues<-xMerged[,Index_Means_Std]

# write to a file
write.csv(xMeanStdValues,file="xMeanStdValues.csv")


## Generate second dataset with the means of each variable for each subject and activity

# Calculation of mean of all variables for every subject and activity

FinalNewSet<-data.frame(ncol=81)
newSet<-matrix(ncol=79)
SubActSet<-data.frame()
subAct<-matrix(ncol=2)

for(j in unique(xMeanStdValues$Subject)){
  for (k in unique(xMeanStdValues$Activity)){
    # variable l captures all rows with that subject and activity
    l<-which(xMeanStdValues$Subject==j & xMeanStdValues$Activity==k)    
    SubActSet<-xMeanStdValues[l,]
    subAct<-rbind(subAct,c(j,k))
    cm<-colMeans(data.matrix(SubActSet[sapply(SubActSet, is.numeric)]))
    cm<-as.matrix(cm)
    dim(cm)<-c(1,79)
    newSet<-rbind(newSet, cm)
  }  
}

subAct<-subAct[-1,]
newSet<-newSet[-1,]
FinalNewSet<-cbind(as.data.frame(subAct),as.data.frame(newSet))
finalnames<-c(names(xMeanStdValues[,1:2]),paste("Average",names(xMeanStdValues[,3:81])))
names(FinalNewSet)<-finalnames

write.csv(FinalNewSet,file="2ndTidyDataSet.csv")
