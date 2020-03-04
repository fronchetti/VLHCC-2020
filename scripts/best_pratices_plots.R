bp1_data_closed <- data.frame(row.names=c("atom_externals", "atom_internals", "electron_externals", "electron_internals", "hubot_externals", "hubot_internals", "git-lfs_externals", "git-lfs_internals", "linguist_externals", "linguist_internals"))
bp1_data_merged <- data.frame(row.names=c("atom_externals", "atom_internals", "electron_externals", "electron_internals", "hubot_externals", "hubot_internals", "git-lfs_externals", "git-lfs_internals", "linguist_externals", "linguist_internals"))
bp2_data_closed <- data.frame(row.names=c("atom_externals", "atom_internals", "electron_externals", "electron_internals", "hubot_externals", "hubot_internals", "git-lfs_externals", "git-lfs_internals", "linguist_externals", "linguist_internals"))
bp2_data_merged <- data.frame(row.names=c("atom_externals", "atom_internals", "electron_externals", "electron_internals", "hubot_externals", "hubot_internals", "git-lfs_externals", "git-lfs_internals", "linguist_externals", "linguist_internals"))
bp3_data_closed <- data.frame(row.names=c("atom_externals", "atom_internals", "electron_externals", "electron_internals", "hubot_externals", "hubot_internals", "git-lfs_externals", "git-lfs_internals", "linguist_externals", "linguist_internals"))
bp3_data_merged <- data.frame(row.names=c("atom_externals", "atom_internals", "electron_externals", "electron_internals", "hubot_externals", "hubot_internals", "git-lfs_externals", "git-lfs_internals", "linguist_externals", "linguist_internals"))
bp4_data_closed <- data.frame(row.names=c("atom_externals", "atom_internals", "electron_externals", "electron_internals", "hubot_externals", "hubot_internals", "git-lfs_externals", "git-lfs_internals", "linguist_externals", "linguist_internals"))
bp4_data_merged <- data.frame(row.names=c("atom_externals", "atom_internals", "electron_externals", "electron_internals", "hubot_externals", "hubot_internals", "git-lfs_externals", "git-lfs_internals", "linguist_externals", "linguist_internals"))

setwd("/home/fronchetti/Imagens/CHASE-2018")

#########################################################
#                 Loading Dataset                       #
#########################################################

for (project in c('atom', 'hubot', 'git-lfs', 'electron', 'linguist')) {
  closed_file_path <- paste("dataset/", project, "/pulls_closed_new.csv", sep="")
  merged_file_path <- paste("dataset/", project, "/pulls_merged_new.csv", sep="")
  merged_file <- read.csv(merged_file_path)
  closed_file <- read.csv(closed_file_path)
  
  #########################################################
  #                   Best Pratice 1                      #
  #########################################################
  # Closed
  bp1_internals_closed_in <- subset(closed_file, user_type == "Internals" & (number_of_files_changed <= 2 & number_of_additions <= 20))
  bp1_externals_closed_in <- subset(closed_file, user_type == "Externals" & (number_of_files_changed <= 2 & number_of_additions <= 20))
  bp1_internals_closed_out <- subset(closed_file, user_type == "Internals" & (number_of_files_changed > 2 | number_of_additions > 20))
  bp1_externals_closed_out <- subset(closed_file, user_type == "Externals" & (number_of_files_changed > 2 | number_of_additions > 20))
  bp1_data_closed[paste(project, "_internals", sep=""), "meet_best_pratice"] <- nrow(bp1_internals_closed_in) / (nrow(bp1_internals_closed_in) + nrow(bp1_internals_closed_out)) * 100
  bp1_data_closed[paste(project, "_externals", sep=""), "meet_best_pratice"] <- nrow(bp1_externals_closed_in) / (nrow(bp1_externals_closed_in) + nrow(bp1_externals_closed_out)) * 100
  bp1_data_closed[paste(project, "_internals", sep=""), 'does_not_meet_best_pratice'] <- nrow(bp1_internals_closed_out) / (nrow(bp1_internals_closed_in) + nrow(bp1_internals_closed_out)) * 100
  bp1_data_closed[paste(project, "_externals", sep=""), "does_not_meet_best_pratice"] <- nrow(bp1_externals_closed_out) / (nrow(bp1_externals_closed_in) + nrow(bp1_externals_closed_out)) * 100

  # Merged
  bp1_internals_merged_in <- subset(merged_file, user_type == "Internals" & (number_of_files_changed <= 2 & number_of_additions <= 20))
  bp1_externals_merged_in <- subset(merged_file, user_type == "Externals" & (number_of_files_changed <= 2 & number_of_additions <= 20))
  bp1_internals_merged_out <- subset(merged_file, user_type == "Internals" & (number_of_files_changed > 2 | number_of_additions > 20))
  bp1_externals_merged_out <- subset(merged_file, user_type == "Externals" & (number_of_files_changed > 2 | number_of_additions > 20))
  bp1_data_merged[paste(project, "_internals", sep=""), "meet_best_pratice"] <- nrow(bp1_internals_merged_in) / (nrow(bp1_internals_merged_in) + nrow(bp1_internals_merged_out)) * 100
  bp1_data_merged[paste(project, "_externals", sep=""), "meet_best_pratice"] <- nrow(bp1_externals_merged_in) / (nrow(bp1_externals_merged_in) + nrow(bp1_externals_merged_out)) * 100
  bp1_data_merged[paste(project, "_internals", sep=""), 'does_not_meet_best_pratice'] <- nrow(bp1_internals_merged_out) / (nrow(bp1_internals_merged_in) + nrow(bp1_internals_merged_out)) * 100
  bp1_data_merged[paste(project, "_externals", sep=""), "does_not_meet_best_pratice"] <- nrow(bp1_externals_merged_out) / (nrow(bp1_externals_merged_in) + nrow(bp1_externals_merged_out)) * 100

  #########################################################
  #                   Best Pratice 2                      #
  #########################################################
  # Closed
  bp2_internals_closed_in <- subset(closed_file, user_type == "Internals" & number_of_test_files > 0)
  bp2_externals_closed_in <- subset(closed_file, user_type == "Externals" & number_of_test_files > 0)
  bp2_internals_closed_out <- subset(closed_file, user_type == "Internals" & number_of_test_files == 0)
  bp2_externals_closed_out <- subset(closed_file, user_type == "Externals" & number_of_test_files == 0)
  bp2_data_closed[paste(project, "_internals", sep=""), "meet_best_pratice"] <- nrow(bp2_internals_closed_in) / (nrow(bp2_internals_closed_in) + nrow(bp2_internals_closed_out)) * 100
  bp2_data_closed[paste(project, "_externals", sep=""), "meet_best_pratice"] <- nrow(bp2_externals_closed_in) / (nrow(bp2_externals_closed_in) + nrow(bp2_externals_closed_out)) * 100
  bp2_data_closed[paste(project, "_internals", sep=""), 'does_not_meet_best_pratice'] <- nrow(bp2_internals_closed_out) / (nrow(bp2_internals_closed_in) + nrow(bp2_internals_closed_out)) * 100
  bp2_data_closed[paste(project, "_externals", sep=""), "does_not_meet_best_pratice"] <- nrow(bp2_externals_closed_out) / (nrow(bp2_externals_closed_in) + nrow(bp2_externals_closed_out)) * 100
  
  # Merged
  bp2_internals_merged_in <- subset(merged_file, user_type == "Internals" & number_of_test_files > 0)
  bp2_externals_merged_in <- subset(merged_file, user_type == "Externals" & number_of_test_files > 0)
  bp2_internals_merged_out <- subset(merged_file, user_type == "Internals" & number_of_test_files == 0)
  bp2_externals_merged_out <- subset(merged_file, user_type == "Externals" & number_of_test_files == 0)
  bp2_data_merged[paste(project, "_internals", sep=""), "meet_best_pratice"] <- nrow(bp2_internals_merged_in) / (nrow(bp2_internals_merged_in) + nrow(bp2_internals_merged_out)) * 100
  bp2_data_merged[paste(project, "_externals", sep=""), "meet_best_pratice"] <- nrow(bp2_externals_merged_in) / (nrow(bp2_externals_merged_in) + nrow(bp2_externals_merged_out)) * 100
  bp2_data_merged[paste(project, "_internals", sep=""), 'does_not_meet_best_pratice'] <- nrow(bp2_internals_merged_out) / (nrow(bp2_internals_merged_in) + nrow(bp2_internals_merged_out)) * 100
  bp2_data_merged[paste(project, "_externals", sep=""), "does_not_meet_best_pratice"] <- nrow(bp2_externals_merged_out) / (nrow(bp2_externals_merged_in) + nrow(bp2_externals_merged_out)) * 100
  
  #########################################################
  #                   Best Pratice 3                      #
  #########################################################
  # Closed
  bp3_internals_closed_in <- subset(closed_file, user_type == "Internals" & (number_of_characters <= 50 & second_line_is_blank == "True" & language == "en"))
  bp3_internals_closed_out <- subset(closed_file, user_type == "Internals" & (number_of_characters > 50 | second_line_is_blank != "True" | language != "en"))
  bp3_externals_closed_in <- subset(closed_file, user_type == "Externals" & (number_of_characters <= 50 & second_line_is_blank == "True" & language == "en"))
  bp3_externals_closed_out <- subset(closed_file, user_type == "Externals" & (number_of_characters > 50 | second_line_is_blank != "True" | language != "en"))
  bp3_data_closed[paste(project, "_internals", sep=""), "meet_best_pratice"] <- nrow(bp3_internals_closed_in) / (nrow(bp3_internals_closed_in) + nrow(bp3_internals_closed_out)) * 100
  bp3_data_closed[paste(project, "_externals", sep=""), "meet_best_pratice"] <- nrow(bp3_externals_closed_in) / (nrow(bp3_externals_closed_in) + nrow(bp3_externals_closed_out)) * 100
  bp3_data_closed[paste(project, "_internals", sep=""), 'does_not_meet_best_pratice'] <- nrow(bp3_internals_closed_out) / (nrow(bp3_internals_closed_in) + nrow(bp3_internals_closed_out)) * 100
  bp3_data_closed[paste(project, "_externals", sep=""), "does_not_meet_best_pratice"] <- nrow(bp3_externals_closed_out) / (nrow(bp3_externals_closed_in) + nrow(bp3_externals_closed_out)) * 100
  
  # Merged
  bp3_internals_merged_in <- subset(merged_file, user_type == "Internals" & (number_of_characters <= 50 & second_line_is_blank == "True" & language == "en"))
  bp3_externals_merged_in <- subset(merged_file, user_type == "Externals" & (number_of_characters <= 50 & second_line_is_blank == "True" & language == "en"))
  bp3_internals_merged_out <- subset(merged_file, user_type == "Internals" & (number_of_characters > 50 | second_line_is_blank != "True" | language != "en"))
  bp3_externals_merged_out <- subset(merged_file, user_type == "Externals" & (number_of_characters > 50 | second_line_is_blank != "True" | language != "en"))
  bp3_data_merged[paste(project, "_internals", sep=""), "meet_best_pratice"] <- nrow(bp3_internals_merged_in) / (nrow(bp3_internals_merged_in) + nrow(bp3_internals_merged_out)) * 100
  bp3_data_merged[paste(project, "_externals", sep=""), "meet_best_pratice"] <- nrow(bp3_externals_merged_in) / (nrow(bp3_externals_merged_in) + nrow(bp3_externals_merged_out)) * 100
  bp3_data_merged[paste(project, "_internals", sep=""), 'does_not_meet_best_pratice'] <- nrow(bp3_internals_merged_out) / (nrow(bp3_internals_merged_in) + nrow(bp3_internals_merged_out)) * 100
  bp3_data_merged[paste(project, "_externals", sep=""), "does_not_meet_best_pratice"] <- nrow(bp3_externals_merged_out) / (nrow(bp3_externals_merged_in) + nrow(bp3_externals_merged_out)) * 100
  
  #########################################################
  #                   Best Pratice 4                      #
  #########################################################
  # Closed
  bp4_internals_closed_in <- subset(closed_file, user_type == "Internals" & number_of_files_comments > 0)
  bp4_externals_closed_in <- subset(closed_file, user_type == "Externals" & number_of_files_comments > 0)
  bp4_internals_closed_out <- subset(closed_file, user_type == "Internals" & number_of_files_comments == 0)
  bp4_externals_closed_out <- subset(closed_file, user_type == "Externals" & number_of_files_comments == 0)
  bp4_data_closed[paste(project, "_internals", sep=""), "meet_best_pratice"] <- nrow(bp4_internals_closed_in) / (nrow(bp4_internals_closed_in) + nrow(bp4_internals_closed_out)) * 100
  bp4_data_closed[paste(project, "_externals", sep=""), "meet_best_pratice"] <- nrow(bp4_externals_closed_in) / (nrow(bp4_externals_closed_in) + nrow(bp4_externals_closed_out)) * 100
  bp4_data_closed[paste(project, "_internals", sep=""), 'does_not_meet_best_pratice'] <- nrow(bp4_internals_closed_out) / (nrow(bp4_internals_closed_in) + nrow(bp4_internals_closed_out)) * 100
  bp4_data_closed[paste(project, "_externals", sep=""), "does_not_meet_best_pratice"] <- nrow(bp4_externals_closed_out) / (nrow(bp4_externals_closed_in) + nrow(bp4_externals_closed_out)) * 100
  
  # Merged
  bp4_internals_merged_in <- subset(merged_file, user_type == "Internals" & number_of_files_comments > 0)
  bp4_externals_merged_in <- subset(merged_file, user_type == "Externals" & number_of_files_comments > 0)
  bp4_internals_merged_out <- subset(merged_file, user_type == "Internals" & number_of_files_comments == 0)
  bp4_externals_merged_out <- subset(merged_file, user_type == "Externals" & number_of_files_comments == 0)
  bp4_data_merged[paste(project, "_internals", sep=""), "meet_best_pratice"] <- nrow(bp4_internals_merged_in) / (nrow(bp4_internals_merged_in) + nrow(bp4_internals_merged_out)) * 100
  bp4_data_merged[paste(project, "_externals", sep=""), "meet_best_pratice"] <- nrow(bp4_externals_merged_in) / (nrow(bp4_externals_merged_in) + nrow(bp4_externals_merged_out)) * 100
  bp4_data_merged[paste(project, "_internals", sep=""), 'does_not_meet_best_pratice'] <- nrow(bp4_internals_merged_out) / (nrow(bp4_internals_merged_in) + nrow(bp4_internals_merged_out)) * 100
  bp4_data_merged[paste(project, "_externals", sep=""), "does_not_meet_best_pratice"] <- nrow(bp4_externals_merged_out) / (nrow(bp4_externals_merged_in) + nrow(bp4_externals_merged_out)) * 100
}

barplot(do.call(rbind, bp3_data_closed), beside = FALSE, ylim=c(0,100), legend.text = c("Conform", "Doest not conform"), 
        args.legend = list(x = "top", ncol = 2, cex = 1.5, xpd = TRUE, inset = c(-0.17,-0.17)), names.arg = c("AV", "AE", "BV", "BE", "CV", "CE", "DV", "DE", "EV", "EE"), cex.names=1.2, cex.axis=1.2, ylab = "Percentage", cex.lab=1.2)

barplot(do.call(rbind, bp3_data_merged), beside = FALSE, ylim=c(0,100), legend.text = c("Conform", "Doest not conform"), 
        args.legend = list(x = "top", ncol = 2, cex = 1.5, xpd = TRUE, inset = c(-0.17,-0.17)), names.arg = c("AV", "AE", "BV", "BE", "CV", "CE", "DV", "DE", "EV", "EE"), cex.names=1.2, cex.axis=1.2, ylab = "Percentage", cex.lab=1.2)

barplot(do.call(rbind, bp2_data_closed), beside = FALSE, ylim=c(0,100), legend.text = c("Conform", "Doest not conform"), 
        args.legend = list(x = "top", ncol = 2, cex = 1.5, xpd = TRUE, inset = c(-0.17,-0.17)), names.arg = c("AV", "AE", "BV", "BE", "CV", "CE", "DV", "DE", "EV", "EE"), cex.names=1.2, cex.axis=1.2, ylab = "Percentage", cex.lab=1.2)

barplot(do.call(rbind, bp2_data_merged), beside = FALSE, ylim=c(0,100), legend.text = c("Conform", "Doest not conform"), 
        args.legend = list(x = "top", ncol = 2, cex = 1.5, xpd = TRUE, inset = c(-0.17,-0.17)), names.arg = c("AV", "AE", "BV", "BE", "CV", "CE", "DV", "DE", "EV", "EE"), cex.names=1.2, cex.axis=1.2, ylab = "Percentage", cex.lab=1.2)

barplot(do.call(rbind, bp1_data_closed), beside = FALSE, ylim=c(0,100), legend.text = c("Conform", "Doest not conform"), 
        args.legend = list(x = "top", ncol = 2, cex = 1.5, xpd = TRUE, inset = c(-0.17,-0.17)), names.arg = c("AV", "AE", "BV", "BE", "CV", "CE", "DV", "DE", "EV", "EE"), cex.names=1.2, cex.axis=1.2, ylab = "Percentage", cex.lab=1.2)

do.call(rbind, bp1_data_merged)
barplot(do.call(rbind, bp1_data_merged), beside = FALSE, ylim=c(0,100), legend.text = c("Conform", "Doest not conform"), 
        args.legend = list(x = "top", ncol = 2, cex = 1.5, xpd = TRUE, inset = c(-0.17,-0.17)), names.arg = c("AV", "AE", "BV", "BE", "CV", "CE", "DV", "DE", "EV", "EE"), cex.names=1.2, cex.axis=1.2, ylab = "Percentage", cex.lab=1.2)

do.call(rbind, bp4_data_closed)
barplot(do.call(rbind, bp4_data_closed), beside = FALSE, ylim=c(0,100), legend.text = c("Conform", "Doest not conform"), 
        args.legend = list(x = "top", ncol = 2, cex = 1.5, xpd = TRUE, inset = c(-0.17,-0.17)), names.arg = c("AV", "AE", "BV", "BE", "CV", "CE", "DV", "DE", "EV", "EE"), cex.names=1.2, cex.axis=1.2, ylab = "Percentage", cex.lab=1.2)

do.call(rbind, bp4_data_merged)
barplot(do.call(rbind, bp4_data_merged), beside = FALSE, ylim=c(0,100), legend.text = c("Conform", "Doest not conform"), 
        args.legend = list(x = "top", ncol = 2, cex = 1.5, xpd = TRUE, inset = c(-0.17,-0.17)), names.arg = c("AV", "AE", "BV", "BE", "CV", "CE", "DV", "DE", "EV", "EE"), cex.names=1.2, cex.axis=1.2, ylab = "Percentage", cex.lab=1.2)

