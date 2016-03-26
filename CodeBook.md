# Human Activity Recognition Using Smartphones Dataset

No manual intervention needed for preprocessing. Results of the elaboration:

`harData`: a data frame containing all subjects, activities, and means and standard deviations of various measured features.

* `subject`: an integer from 1 to 30, indicating the ordinary number of volunteer.
* `activity`: a factor one of levels `LAYING`, `SITTING`, `STANDING`, `WALKING`, `WALKING_DOWNSTAIRS`, `WALKING_UPSTAIRS`.
* `type`: a factor one of levels `train` and `test`.
* means and standard deviations of measured features.

`harDataAverages`: a summary of data frame `harData`, where the means and standard deviations are averaged by subjects and activities. It contains the same columns. The row contains averages of the mentioned values. 
