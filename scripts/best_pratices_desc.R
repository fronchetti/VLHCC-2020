#########################################################
#             Installing/Loading Packages               #
#########################################################
if (!require("plyr")) {
  install.packages("plyr", dependencies = TRUE)
  library("plyr")
}

setwd("/home/fronchetti/Imagens/CHASE-2018")

#########################################################
#                 Loading Dataset                       #
#########################################################

pulls_merged <- data.frame()
pulls_closed <- data.frame()

for (project in c('atom', 'hubot', 'git-lfs', 'electron', 'linguist')) {
  project_pulls_merged <- read.csv(paste("dataset/", project, "/pulls_merged_new.csv", collapse = NULL, sep=""), header = TRUE, stringsAsFactors = FALSE)
  project_pulls_closed <- read.csv(paste("dataset/", project, "/pulls_closed_new.csv", collapse = NULL, sep=""), header = TRUE, stringsAsFactors = FALSE)
  pulls_merged <- rbind.fill(project_pulls_merged, pulls_merged)
  pulls_closed <- rbind.fill(project_pulls_closed, pulls_closed)
}

#########################################################
#                     Analysis                          #
#########################################################

pulls <- rbind.fill(pulls_merged, pulls_closed)
pulls_by_internals <- subset(pulls, user_type == "Internals")
pulls_by_externals <- subset(pulls, user_type == "Externals")

merged_pulls_by_internals <- subset(pulls_merged, user_type == "Internals")
merged_pulls_by_externals <- subset(pulls_merged, user_type == "Externals")

closed_pulls_by_internals <- subset(pulls_closed, user_type == "Internals")
closed_pulls_by_externals <- subset(pulls_closed, user_type == "Externals")

length(unique(pulls_by_internals$user_login))
length(unique(pulls_by_externals$user_login))
length(unique(closed_pulls_by_internals$user_login))
length(unique(closed_pulls_by_externals$user_login))
length(unique(merged_pulls_by_internals$user_login))
length(unique(merged_pulls_by_externals$user_login))

#########################################################
#                   Best Pratice 1                      #
#########################################################

bp1_internals_total_in <- subset(pulls, user_type == "Internals" & (number_of_files_changed <= 2 | number_of_additions <= 20))
bp1_internals_total_out <- subset(pulls, user_type == "Internals" & (number_of_files_changed > 2 | number_of_additions > 20))
bp1_internals_closed_in <- subset(pulls_closed, user_type == "Internals" & (number_of_files_changed <= 2 | number_of_additions <= 20))
bp1_internals_closed_out <- subset(pulls_closed, user_type == "Internals" & (number_of_files_changed > 2 | number_of_additions > 20))
bp1_internals_merged_in <- subset(pulls_merged, user_type == "Internals" & (number_of_files_changed <= 2 | number_of_additions <= 20))
bp1_internals_merged_out <- subset(pulls_merged, user_type == "Internals" & (number_of_files_changed > 2 | number_of_additions > 20))

#########################################################
#                   Best Pratice 2                      #
#########################################################

bp2_merged_total_in <- subset(pulls_merged, number_of_test_files > 0)
bp2_merged_total_out <- subset(pulls_merged, number_of_test_files == 0)

#########################################################
#                   Best Pratice 3                      #
#########################################################

bp3_internals_merged_blank_line <- subset(pulls_merged, user_type == "Internals" & second_line_is_blank == "True")
bp3_internals_merged_non_blank_line <- subset(pulls_merged, user_type == "Internals" & second_line_is_blank == "False")
bp3_externals_merged_blank_line <- subset(pulls_merged, user_type == "Externals" & second_line_is_blank == "True")
bp3_externals_merged_non_blank_line <- subset(pulls_merged, user_type == "Externals" & second_line_is_blank == "False")

bp3_internals_closed_blank_line <- subset(pulls_closed, user_type == "Internals" & second_line_is_blank == "True")
bp3_internals_closed_non_blank_line <- subset(pulls_closed, user_type == "Internals" & second_line_is_blank == "False")
bp3_externals_closed_blank_line <- subset(pulls_closed, user_type == "Externals" & second_line_is_blank == "True")
bp3_externals_closed_non_blank_line <- subset(pulls_closed, user_type == "Externals" & second_line_is_blank == "False")

bp3_internals_closed_english <- subset(pulls_closed, user_type == "Internals" & language == "en")
bp3_internals_closed_non_english <- subset(pulls_closed, user_type == "Internals" & language != "en")
bp3_externals_closed_english <- subset(pulls_closed, user_type == "Externals" & language == "en")
bp3_externals_closed_non_english <- subset(pulls_closed, user_type == "Externals" & language != "en")

bp3_internals_closed_short <- subset(pulls_closed, user_type == "Internals" & number_of_characters <= 50)
bp3_internals_closed_non_short <- subset(pulls_closed, user_type == "Internals" & number_of_characters > 50)
bp3_externals_closed_short <- subset(pulls_closed, user_type == "Externals" & number_of_characters <= 50)
bp3_externals_closed_non_short <- subset(pulls_closed, user_type == "Externals" & number_of_characters > 50)

#########################################################
#                   Best Pratice 4                      #
#########################################################

bp4_total_in <- subset(pulls, number_of_files_comments > 0)
bp4_total_out <- subset(pulls, number_of_files_comments == 0)

bp4_merged_in <- subset(pulls_merged, number_of_files_comments > 0)
bp4_merged_out <- subset(pulls_merged, number_of_files_comments == 0)

bp4_internals_merged_in <- subset(pulls_merged, user_type == "Internals" & number_of_files_comments > 0)
bp4_internals_merged_out <- subset(pulls_merged, user_type == "Internals" & number_of_files_comments == 0)

bp4_externals_merged_in <- subset(pulls_merged, user_type == "Externals" & number_of_files_comments > 0)
bp4_externals_merged_out <- subset(pulls_merged, user_type == "Externals" & number_of_files_comments == 0)
