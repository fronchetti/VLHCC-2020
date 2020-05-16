#Installing required packages

if (!require('ggplot2')){
  suppressMessages(install.packages('ggplot2'))
}
if (!require('scales')){
  suppressMessages(install.packages('scales'))
}
if (!require('Hmisc')){
  suppressMessages(install.packages('Hmisc'))
}
if (!require('scales')){
  suppressMessages(install.packages('scales'))
}
if (!require('reshape')){
  suppressMessages(install.packages('reshape'))
}
if (!require('gridExtra')){
  suppressMessages(install.packages('gridExtra'))
}
if (!require('ggthemes')){
  suppressMessages(install.packages('ggthemes'))
}
if (!require('extrafont')){
  suppressMessages(install.packages('extrafont'))
}
if (!require('readr')){
  suppressMessages(install.packages('readr'))
}
if (!require('dplyr')){
  suppressMessages(install.packages('dplyr'))
}
if (!require('svglite')){
  suppressMessages(install.packages('svglite'))
}

# Load required packages and suppress packages messages
suppressMessages(library(ggplot2))
suppressMessages(library(scales))
suppressMessages(library(gridExtra))
suppressMessages(library(Hmisc))
suppressMessages(library(reshape))
suppressMessages(library(readr))
suppressMessages(library(plyr))
suppressMessages(library(ggthemes))
suppressMessages(library(extrafont))
suppressMessages(library(readr))
suppressMessages(library(dplyr))
suppressMessages(library(svglite))

local_path <- "D:/Pesquisa/icse-2019/"
# Setting the workspace dir
setwd(local_path)

source("D:/Pesquisa/icse-2019/scripts/functions.R")

atom_issues_info <- load_data(paste0(local_path, "metrics/full/atom_issues_info.csv"))
electron_issues_info <- load_data(paste0(local_path, "metrics/full/electron_issues_info.csv"))
gitlfs_issues_info <- load_data(paste0(local_path, "metrics/full/gitlfs_issues_info.csv"))
hubot_issues_info <- load_data(paste0(local_path, "metrics/full/hubot_issues_info.csv"))
linguist_issues_info <- load_data(paste0(local_path, "metrics/full/linguist_issues_info.csv"))

atom_pulls_info <- load_data(paste0(local_path, "metrics/full/atom_pulls_info.csv"))
electron_pulls_info <- load_data(paste0(local_path, "metrics/full/electron_pulls_info.csv"))
gitlfs_pulls_info <- load_data(paste0(local_path, "metrics/full/gitlfs_pulls_info.csv"))
hubot_pulls_info <- load_data(paste0(local_path, "metrics/full/hubot_pulls_info.csv"))
linguist_pulls_info <- load_data(paste0(local_path, "metrics/full/linguist_pulls_info.csv"))

atom_commits_info <- load_data(paste0(local_path, "metrics/full/atom_commits_info.csv"))
atom_commits_info$user <- gsub('\\s+', '', atom_commits_info$user)
atom_commits_info$user <- tolower(atom_commits_info$user)
electron_commits_info <- load_data(paste0(local_path, "metrics/full/electron_commits_info.csv"))
electron_commits_info$user <- gsub('\\s+', '', electron_commits_info$user)
electron_commits_info$user <- tolower(electron_commits_info$user)
gitlfs_commits_info <- load_data(paste0(local_path, "metrics/full/gitlfs_commits_info.csv"))
gitlfs_commits_info$user <- gsub('\\s+', '', gitlfs_commits_info$user)
gitlfs_commits_info$user <- tolower(gitlfs_commits_info$user)
hubot_commits_info <- load_data(paste0(local_path, "metrics/full/hubot_commits_info.csv"))
hubot_commits_info$user <- gsub('\\s+', '', hubot_commits_info$user)
hubot_commits_info$user <- tolower(hubot_commits_info$user)
linguist_commits_info <- load_data(paste0(local_path, "metrics/full/linguist_commits_info.csv"))
linguist_commits_info$user <- gsub('\\s+', '', linguist_commits_info$user)
linguist_commits_info$user <- tolower(linguist_commits_info$user)



number_issues <- nrow(atom_issues_info) + nrow(electron_issues_info) + nrow(gitlfs_issues_info) + nrow(hubot_issues_info) + nrow(linguist_issues_info)
number_pulls <- nrow(atom_pulls_info) + nrow(electron_pulls_info) + nrow(gitlfs_pulls_info) + nrow(hubot_pulls_info) + nrow(linguist_pulls_info)

number_issues
number_pulls


#Add columns in the data with the information of the cuts
for (feat in feats_to_cut_issues) {
  
  # Cut feats
  atom_issues_info <- create_intervals(atom_issues_info, feat)
  electron_issues_info <- create_intervals(electron_issues_info, feat)
  gitlfs_issues_info <- create_intervals(gitlfs_issues_info, feat)
  hubot_issues_info <- create_intervals(hubot_issues_info, feat)
  linguist_issues_info <- create_intervals(linguist_issues_info, feat)
  
}

for (feat in feats_to_cut_pulls) {
  atom_pulls_info <- create_intervals(atom_pulls_info, feat)
  electron_pulls_info <- create_intervals(electron_pulls_info, feat)
  gitlfs_pulls_info <- create_intervals(gitlfs_pulls_info, feat)
  hubot_pulls_info <- create_intervals(hubot_pulls_info, feat)
  linguist_pulls_info <- create_intervals(linguist_pulls_info, feat)
}


atom_commits_info <- create_intervals_date(atom_commits_info)
electron_commits_info <- create_intervals_date(electron_commits_info)
gitlfs_commits_info <- create_intervals_date(gitlfs_commits_info)
hubot_commits_info <- create_intervals_date(hubot_commits_info)
linguist_commits_info <- create_intervals_date(linguist_commits_info)



#Subseting Commits

atom_commits_info_employee <- subseting(atom_commits_info, atom_commits_info$site_admin, "TRUE", "commits")
atom_commits_info_volunter <- subseting(atom_commits_info, atom_commits_info$site_admin, "FALSE", "commits")

electron_commits_info_employee <- subseting(electron_commits_info, electron_commits_info$site_admin, "TRUE", "commits")
electron_commits_info_volunter <- subseting(electron_commits_info, electron_commits_info$site_admin, "FALSE", "commits")

gitlfs_commits_info_employee <- subseting(gitlfs_commits_info, gitlfs_commits_info$site_admin, "TRUE", "commits")
gitlfs_commits_info_volunter <- subseting(gitlfs_commits_info, gitlfs_commits_info$site_admin, "FALSE", "commits")

hubot_commits_info_employee <- subseting(hubot_commits_info, hubot_commits_info$site_admin, "TRUE", "commits")
hubot_commits_info_volunter <- subseting(hubot_commits_info, hubot_commits_info$site_admin, "FALSE", "commits")

linguist_commits_info_employee <- subseting(linguist_commits_info, linguist_commits_info$site_admin, "TRUE", "commits")
linguist_commits_info_volunter <- subseting(linguist_commits_info, linguist_commits_info$site_admin, "FALSE", "commits")


#Subseting Issues
atom_issues_info_employee <- subseting(atom_issues_info, atom_issues_info$employee_open, "employee", "issues")
atom_issues_info_volunter <- subseting(atom_issues_info, atom_issues_info$employee_open, "volunter", "issues")
atom_issues_info_bot <- subseting(atom_issues_info, atom_issues_info$employee_open, "bot", "issues")

electron_issues_info_employee <- subseting(electron_issues_info, electron_issues_info$employee_open, "employee", "issues")
electron_issues_info_volunter <- subseting(electron_issues_info, electron_issues_info$employee_open, "volunter", "issues")
electron_issues_info_bot <- subseting(electron_issues_info, electron_issues_info$employee_open, "bot", "issues")

gitlfs_issues_info_employee <- subseting(gitlfs_issues_info, gitlfs_issues_info$employee_open, "employee", "issues")
gitlfs_issues_info_volunter <- subseting(gitlfs_issues_info, gitlfs_issues_info$employee_open, "volunter", "issues")
gitlfs_issues_info_bot <- subseting(gitlfs_issues_info, gitlfs_issues_info$employee_open, "bot", "issues")

hubot_issues_info_employee <- subseting(hubot_issues_info, hubot_issues_info$employee_open, "employee", "issues")
hubot_issues_info_volunter <- subseting(hubot_issues_info, hubot_issues_info$employee_open, "volunter", "issues")
hubot_issues_info_bot <- subseting(hubot_issues_info, hubot_issues_info$employee_open, "bot", "issues")

linguist_issues_info_employee <- subseting(linguist_issues_info, linguist_issues_info$employee_open, "employee", "issues")
linguist_issues_info_volunter <- subseting(linguist_issues_info, linguist_issues_info$employee_open, "volunter", "issues")
linguist_issues_info_bot <- subseting(linguist_issues_info, linguist_issues_info$employee_open, "bot", "issues")

#Subseting Pull Requests
atom_pulls_info_employee <- subseting(atom_pulls_info, atom_pulls_info$employee_open, "employee", "employee_open")
atom_pulls_info_volunter <- subseting(atom_pulls_info, atom_pulls_info$employee_open, "volunter", "employee_open")
atom_pulls_info_bot <- subseting(atom_pulls_info, atom_pulls_info$employee_open, "bot", "employee_open")

electron_pulls_info_employee <- subseting(electron_pulls_info, electron_pulls_info$employee_open, "employee", "employee_open")
electron_pulls_info_volunter <- subseting(electron_pulls_info, electron_pulls_info$employee_open, "volunter", "employee_open")
electron_pulls_info_bot <- subseting(electron_pulls_info, electron_pulls_info$employee_open, "bot", "employee_open")

gitlfs_pulls_info_employee <- subseting(gitlfs_pulls_info, gitlfs_pulls_info$employee_open, "employee", "employee_open")
gitlfs_pulls_info_volunter <- subseting(gitlfs_pulls_info, gitlfs_pulls_info$employee_open, "volunter", "employee_open")
gitlfs_pulls_info_bot <- subseting(gitlfs_pulls_info, gitlfs_pulls_info$employee_open, "bot", "employee_open")

hubot_pulls_info_employee <- subseting(hubot_pulls_info, hubot_pulls_info$employee_open, "employee", "employee_open")
hubot_pulls_info_volunter <- subseting(hubot_pulls_info, hubot_pulls_info$employee_open, "volunter", "employee_open")
hubot_pulls_info_bot <- subseting(hubot_pulls_info, hubot_pulls_info$employee_open, "bot", "employee_open")

linguist_pulls_info_employee <- subseting(linguist_pulls_info, linguist_pulls_info$employee_open, "employee", "employee_open")
linguist_pulls_info_volunter <- subseting(linguist_pulls_info, linguist_pulls_info$employee_open, "volunter", "employee_open")
linguist_pulls_info_bot <- subseting(linguist_pulls_info, linguist_pulls_info$employee_open, "bot", "employee_open")


number_issues_employee <- nrow(atom_issues_info_employee) + nrow(electron_issues_info_employee) + nrow(gitlfs_issues_info_employee) + nrow(hubot_issues_info_employee) + nrow(linguist_issues_info_employee)
number_pulls_employee <- nrow(atom_pulls_info_employee) + nrow(electron_pulls_info_employee) + nrow(gitlfs_pulls_info_employee) + nrow(hubot_pulls_info_employee) + nrow(linguist_pulls_info_employee)

number_issues_employee
number_pulls_employee

number_issues_volunter <- nrow(atom_issues_info_volunter) + nrow(electron_issues_info_volunter) + nrow(gitlfs_issues_info_volunter) + nrow(hubot_issues_info_volunter) + nrow(linguist_issues_info_volunter)
number_pulls_volunter <- nrow(atom_pulls_info_volunter) + nrow(electron_pulls_info_volunter) + nrow(gitlfs_pulls_info_volunter) + nrow(hubot_pulls_info_volunter) + nrow(linguist_pulls_info_volunter)

number_issues_volunter
number_pulls_volunter

(sum(atom_pulls_info_volunter$user_closed == 'null' & atom_pulls_info_volunter$state == 'closed') +
sum(electron_pulls_info_volunter$user_closed == 'null' & electron_pulls_info_volunter$state == 'closed') +
sum(gitlfs_pulls_info_volunter$user_closed == 'null' & gitlfs_pulls_info_volunter$state == 'closed') +
sum(hubot_pulls_info_volunter$user_closed == 'null' & hubot_pulls_info_volunter$state == 'closed') +
sum(linguist_pulls_info_volunter$user_closed == 'null' & linguist_pulls_info_volunter$state == 'closed'))  / number_pulls_volunter

issues_plots_path <- paste0(local_path, "plots/issues/stacked/")
pulls_plots_path <- paste0(local_path, "plots/pulls/stacked/")
commits_plots_path <- paste0(local_path, "plots/commits/stacked/")







































#Spearman - Not finished

run_correlation <- function(dataset, corr_method, type){
  
  # Set the output dir
  wd <- paste0(local_path, "correlations/")
  setwd(wd)
  
  p1 <- cor(x = as.numeric(dataset$days_opened), y = as.numeric(dataset$days_between_first_and_last_comment), use='complete.obs', method = corr_method)
  p2 <- cor(x = as.numeric(dataset$days_opened), y = as.numeric(dataset$number_of_comments), use='complete.obs', method = corr_method)
  p3 <- cor(x = as.numeric(dataset$days_opened), y = as.numeric(dataset$days_first_comment_after_creation), use='complete.obs', method = corr_method)
  p4 <- cor(x = as.numeric(dataset$days_opened), y = as.numeric(dataset$days_last_comment_before_closed), use='complete.obs', method = corr_method)
  
  correlations_1 <- cbind('-', p1, p2, p3, p4)
  colnames(correlations_1) <- c("days_opened", "days_between_first_and_last_comment", "number_of_comments", "days_first_comment_after_creation", "days_last_comment_before_closed")
  
  p5 <- cor(x = as.numeric(dataset$days_between_first_and_last_comment), y = as.numeric(dataset$days_opened), use='complete.obs', method = corr_method)
  p6 <- cor(x = as.numeric(dataset$days_between_first_and_last_comment), y = as.numeric(dataset$number_of_comments), use='complete.obs', method = corr_method)
  p7 <- cor(x = as.numeric(dataset$days_between_first_and_last_comment), y = as.numeric(dataset$days_first_comment_after_creation), use='complete.obs', method = corr_method)
  p8 <- cor(x = as.numeric(dataset$days_between_first_and_last_comment), y = as.numeric(dataset$days_last_comment_before_closed), use='complete.obs', method = corr_method)
  
  correlations_2 <- cbind(p5, '-', p6, p7, p8)
  colnames(correlations_2) <- c("days_opened", "days_between_first_and_last_comment", "number_of_comments", "days_first_comment_after_creation", "days_last_comment_before_closed")
  
  p9 <- cor(x = as.numeric(dataset$number_of_comments), y = as.numeric(dataset$days_opened), use='complete.obs', method = corr_method)
  p10 <- cor(x = as.numeric(dataset$number_of_comments), y = as.numeric(dataset$days_between_first_and_last_comment), use='complete.obs', method = corr_method)
  p11 <- cor(x = as.numeric(dataset$number_of_comments), y = as.numeric(dataset$days_first_comment_after_creation), use='complete.obs', method = corr_method)
  p12 <- cor(x = as.numeric(dataset$number_of_comments), y = as.numeric(dataset$days_last_comment_before_closed), use='complete.obs', method = corr_method)
  
  correlations_3 <- cbind(p9, p10, "-", p11, p12)
  colnames(correlations_3) <- c("days_opened", "days_between_first_and_last_comment", "number_of_comments", "days_first_comment_after_creation", "days_last_comment_before_closed")
  
  p13 <- cor(x = as.numeric(dataset$days_first_comment_after_creation), y = as.numeric(dataset$days_opened), use='complete.obs', method = corr_method)
  p14 <- cor(x = as.numeric(dataset$days_first_comment_after_creation), y = as.numeric(dataset$days_between_first_and_last_comment), use='complete.obs', method = corr_method)
  p15 <- cor(x = as.numeric(dataset$days_first_comment_after_creation), y = as.numeric(dataset$number_of_comments), use='complete.obs', method = corr_method)
  p16 <- cor(x = as.numeric(dataset$days_first_comment_after_creation), y = as.numeric(dataset$days_last_comment_before_closed), use='complete.obs', method = corr_method)
  
  correlations_4 <- cbind(p13, p14, p15, "-", p16)
  colnames(correlations_4) <- c("days_opened", "days_between_first_and_last_comment", "number_of_comments", "days_first_comment_after_creation", "days_last_comment_before_closed")
  
  p17 <- cor(x = as.numeric(dataset$days_last_comment_before_closed), y = as.numeric(dataset$days_opened), use='complete.obs', method = corr_method)
  p18 <- cor(x = as.numeric(dataset$days_last_comment_before_closed), y = as.numeric(dataset$days_between_first_and_last_comment), use='complete.obs', method = corr_method)
  p19 <- cor(x = as.numeric(dataset$days_last_comment_before_closed), y = as.numeric(dataset$number_of_comments), use='complete.obs', method = corr_method)
  p20 <- cor(x = as.numeric(dataset$days_last_comment_before_closed), y = as.numeric(dataset$days_first_comment_after_creation), use='complete.obs', method = corr_method)
  
  correlations_5 <- cbind(p17, p18, p19, p20, "-")
  colnames(correlations_5) <- c("days_opened", "days_between_first_and_last_comment", "number_of_comments", "days_first_comment_after_creation", "days_last_comment_before_closed")
  
  correlations_results <- rbind(correlations_1, correlations_2, correlations_3, correlations_4, correlations_5)
  rownames(correlations_results) <- c("days_opened", "days_between_first_and_last_comment", "number_of_comments", "days_first_comment_after_creation", "days_last_comment_before_closed")
  grid.table(correlations_results)
  
  name <- paste0("correlations_", type)
  name <- paste0(name, "_results.csv")
  
  write.csv(correlations_results, name)
  
}

#run_correlation(atom_issues_info, "spearman", "issues_atom")

