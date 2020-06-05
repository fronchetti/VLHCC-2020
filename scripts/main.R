# Attention:
# Change the working_directory value to the absolute path where the repository was cloned/downloaded
working_directory <- "/home/fronchettl/Documents/VLHCC-2020/"
setwd(working_directory)
commits_plots_path <- paste0(working_directory, "plots/commits/stacked/")

#######################
#     Source Code     #
#######################
source("scripts/imports.R")
source("scripts/functions.R")
source("scripts/plots.R")
source("scripts/commits.R")
source("scripts/nature.R")

#######################
#  Method Execution   #
#######################
source("scripts/load_commits_data.R")
commits() # Generates Figure 1 and 2
nature() # Generates Table 1
