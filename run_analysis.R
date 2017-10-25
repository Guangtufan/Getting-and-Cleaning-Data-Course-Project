# Create the data set
subTrain <- read.table('/Users/yezhuang/Downloads/UCI HAR Dataset/train/subject_train.txt')
subTest <- read.table('/Users/yezhuang/Downloads/UCI HAR Dataset/test/subject_test.txt')
sub <- rbind(subTrain, subTest)

actTrain <- read.table('/Users/yezhuang/Downloads/UCI HAR Dataset/train/y_train.txt')
actTest <- read.table('/Users/yezhuang/Downloads/UCI HAR Dataset/test/y_test.txt')
act <- rbind(actTrain, actTest)

feaTrain <- read.table('/Users/yezhuang/Downloads/UCI HAR Dataset/train/X_train.txt')
feaTest <- read.table('/Users/yezhuang/Downloads/UCI HAR Dataset/test/X_test.txt')
feat <- rbind(feaTrain, feaTest)

dt <- cbind(sub, act,feat)
names(dt)[1] <- 'Subject'
names(dt)[2] <- 'Activity'
head(dt)

# Extracts only the measurements on the mean and standard deviation for each measurement.
featName <- read.table('/Users/yezhuang/Downloads/UCI HAR Dataset/')
names(dt)[3:length(names(dt))] <- as.character(featName[,2])
col <- grepl('mean\\(\\)|std\\(\\)', names(dt))
dtMeanOrStd <- dt[,col]
head(dtMeanOrStd)

# Uses descriptive activity names to name the 
# activities in the data set
actLabel <- read.table('/Users/yezhuang/Downloads/UCI HAR Dataset/activity_labels.txt', stringsAsFactors = F)
dt[dt$Activity == 1, 'Activity'] <- actLabel[1,2]
dt[dt$Activity == 2, 'Activity'] <- actLabel[2,2]
dt[dt$Activity == 3, 'Activity'] <- actLabel[3,2]
dt[dt$Activity == 4, 'Activity'] <- actLabel[4,2]
dt[dt$Activity == 5, 'Activity'] <- actLabel[5,2]
dt[dt$Activity == 6, 'Activity'] <- actLabel[6,2]

# Appropriately labels the data set with descriptive variable
# names.
colName <- names(dt)
colname2 <- gsub('-', ' ', colName)
colname2 <- gsub(',', '-', colname2)
names(dt) <- colname2

# From the data set in step 4, creates a second, 
# independent tidy data set with the average of each 

cols <- unique(names(dt))
dt_tidy <- dt[,cols]
library(dplyr)
dt_tidy <- tbl_df(dt_tidy)
dim(dt_tidy)
tidygroup <-group_by(dt_tidy, Subject, Activity)
tidymean <- summarise_all(tidygroup, funs(mean))
tidymean[1:10, 1:10]
write.table(tidymean, file = '/Users/yezhuang/Desktop/tidy data.txt', col.names = F)


