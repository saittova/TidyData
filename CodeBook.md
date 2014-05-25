## CodeBook.md
This markdown document explains the run_analysis.R code and its variables, data and results

### Data import

Data is imported from several text files (.txt) into R objects using read.table() function.

In the first stage the data is imported into corresponding R objects:
features
xtrain
ytrain
xtest
ytest
subjecttest
subjecttrain

### Combining data

Next the data is combined:
1. All train data along subject/activity data into one set
2. All test data along subject/activity data into one set
3. Add activity labels

This results into "alldataFinal" R object

### Filter the unwanted columns

Unwanted columns are filtered away

This results into "finalSet" R object.
This object represents the first tidy object

### Calculations

Next the average values for each subject and activity are calculated.
This results into "SubjAverage" and "actvAverage" R objects.
These objects represents the second and third tidy objects.
