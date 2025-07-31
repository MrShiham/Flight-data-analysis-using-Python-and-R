# Loading required libraries
library(data.table)
library(zoo)

# Importing the data sets of year 2006 and 2007
set.seed(42) # Setting seed for reproducibility
dataset_2006 <- fread("C:/Users/user/Downloads/2006.csv")[sample(.N, .N * 0.1)]
dataset_2007 <- fread("C:/Users/user/Downloads/2007.csv")[sample(.N, .N * 0.1)]

# Merging datasets
merged_data <- rbindlist(list(dataset_2006, dataset_2007))

# Removing duplicates
merged_data <- unique(merged_data)

# Checking datasets
colnames(dataset_2006)
colnames(dataset_2007)
dim(dataset_2006)
dim(dataset_2007)
str(dataset_2006)
str(dataset_2007)

# Filling null values with mean values for column ArrDelay and DepDelay
merged_data[, ArrDelay := na.approx(ArrDelay)]
merged_data[, DepDelay := na.approx(DepDelay)]

# Checking for any null and missing values
colSums(is.na(merged_data))

# Importing Airports and Plane datasets
Airport <- fread("C:/Users/user/Downloads/Airport.csv")
Plane_data <- fread("C:/Users/user/Downloads/Plane_data.csv")

# Removing duplicate values from the datasets
Airport <- unique(Airport)
Plane_data <- unique(Plane_data)

# Checking columns of Airport dataset
colnames(Airport)

# Checking columns of plane dataset
colnames(Plane_data)

# Checking for null values and missing values of these datasets
colSums(is.na(Airport))
colSums(is.na(Plane_data))

# Removing missing values
Airport <- na.omit(Airport)
Plane_data <- na.omit(Plane_data)

# Saving the cleaned datasets
write.csv(merged_data, file = "C:/Users/user/Downloads/merged.csv", row.names = FALSE)
write.csv(Airport, file = "C:/Users/user/Downloads/Airport.csv", row.names = FALSE)
write.csv(Plane_data, file = "C:/Users/user/Downloads/Plane_data.csv", row.names = FALSE)
