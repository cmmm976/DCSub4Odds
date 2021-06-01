# DCSub3Odds
R Scripts which predicts the odds of getting a "sub 3 run" in the game Dead Cells from two different databases (the "runs" of two people, Henpaku and Rockstomb). Also generates the distribution of run times.

# Introduction and definitions
Speedrunning is the activity of playing a game to accomplish an objective in it as fast as possible. Generally this objective is to finish the game. 
We call an attempt of speedrunning a "speedrun", generally abreviated to a "run".
Sub X designed a run below X minutes in our context.
Dead Cells is a video game classified in the rogue-lite genre. Basically it's a game in which the levels are randomly generated (with some fixed rules).

With this point in mind it has been asked what are the odds of getting a run below 3 minutes for the best speedrunners in activity. This is what the scripts do for two of them.

# Datasets

[Livesplit](https://livesplit.org/) is a software allowing you to track your times while speedrunning. You can also divide your runs into "splits" which are important milestones during it.
Due to the nature of speedrunning, a lot of runs are not finished so we get splits without times.
Livesplit allows you to extract your different splits into .csv files.

Then we have two datasets : the Henpaku's splits (henpakuSplits - it's a .csv file) and Rockstomb's splits (rockstomb.xlsx).
After some manipulations, the times in henpakuSplits are in seconds but the ones in rockstomb.xlsx are not in the right format. You have to divide the values by 86,400,000,000 to get them in seconds.

/!\ When reading the file with R(Studio) please be sure to change the type of all logical variables to numeric !

# Methods

The idea is to take a recent sample of each split done by the two runners, estimate the distribution of the times by a [Kernel Density Estimation](https://en.wikipedia.org/wiki/Kernel_density_estimation), then use the estimated distribution to create a big sample (ie. 100k or 1M) of runs with the [reject sampling method](https://theoreticalecology.wordpress.com/2015/04/22/a-simple-explanation-of-rejection-sampling-in-r/). Indeed a complete run is just the addition of estimated splits.
Then with our sample of runs we just take the frequency of runs below 3 minutes to get an estimation of the odds of a sub 3.

# Results
For Henpaku the odds of a sub 3 are around 1 over 1 million.
For Rockstomb the odds of a sub 3 are between 1 over 100,000 and 1 over 1 000 000.

# Discussion and limitations
We evaluated the accuracy of our models by calculating the odds of a sub 4 : they vary between 17 and 26%. The community finds those values plausible.
For Rockstomb's dataset we divided it into training set and test set and compared the estimated distribution to real splits in the test set "with the naked eye". For splits with a lot of data like Promenande it seems fit very well but for splits with a small sample in training set like Sepulcher, we can have really weird distributions.
Also no calculations of errors for the estimated distributions (like EQM...) have been formally made.

Intuitively, we find the odds of sub 3 a undervalued but the estimation might be good at least for a rough estimate.

Distribution of generated runs from Rockstomb's smplits
![rocksim](https://user-images.githubusercontent.com/63333367/120312667-4ff3c680-c2d9-11eb-8750-aa368f97b31b.png)

