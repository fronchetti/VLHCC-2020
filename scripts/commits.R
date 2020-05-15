commits <- function() {
  
  format_commits_group('day_of_week', "Days of Week", "commits")
  
  plot_data_stacked('day_of_week', "Days of Week", "commits")
  
  plot_data(atom_commits_info, "atom", "Atom - Commits by hour", "Hours Intervals", "Commits")
  plot_data(electron_commits_info, "electron", "Electron - Commits by hour", "Hours Intervals", "Commits")
  plot_data(gitlfs_commits_info, "gitlfs", "Gitlfs - Commits by hour", "Hours Intervals", "Commits")
  plot_data(hubot_commits_info, "hubot", "Hubot - Commits by hour", "Hours Intervals", "Commits")
  plot_data(linguist_commits_info, "linguist", "Linguist - Commits by hour", "Hours Intervals", "Commits")
  

  
  plot_data(atom_commits_info_employee, "atom_employee", "Atom - Employee - Commits by hour", "Hours Intervals", "Commits")
  plot_data(electron_commits_info_employee, "electron_employee", "Electron - Employee - Commits by hour", "Hours Intervals", "Commits")
  plot_data(gitlfs_commits_info_employee, "gitlfs_employee", "Gitlfs - Employee - Commits by hour", "Hours Intervals", "Commits")
  plot_data(hubot_commits_info_employee, "hubot_employee", "Hubot - Employee - Commits by hour", "Hours Intervals", "Commits")
  plot_data(linguist_commits_info_employee, "linguist_employee", "Linguist - Employee - Commits by hour", "Hours Intervals", "Commits")
  
  plot_data(atom_commits_info_volunter, "atom_volunter", "Atom - Volunter - Commits by hour", "Hours Intervals", "Commits")
  plot_data(electron_commits_info_volunter, "electron_volunter", "Electron - Volunter - Commits by hour", "Hours Intervals", "Commits")
  plot_data(gitlfs_commits_info_volunter, "gitlfs_volunter", "Gitlfs - Volunter - Commits by hour", "Hours Intervals", "Commits")
  plot_data(hubot_commits_info_volunter, "hubot_volunter", "Hubot - Volunter - Commits by hour", "Hours Intervals", "Commits")
  plot_data(linguist_commits_info_volunter, "linguist_volunter", "Linguist - Volunter - Commits by hour", "Hours Intervals", "Commits")
  
  a <- format_data(linguist_commits_info_volunter, "period_of_day")
  sum(a$frequency[10:17])
  
}

top_commiters <- function(){
  
  #Employee
  atom_top_emp <- as.data.frame(sort(table(atom_commits_info_employee$user)))
  atom_top_emp <- atom_top_emp[order(atom_top_emp$Freq, decreasing = TRUE),]
  atom_top_emp <- atom_top_emp[1:10,]
  atom_top_emp[,3] <- "atom"
  colnames(atom_top_emp) <- c("user", "n_commits", "project")
  
  electron_top_emp <- as.data.frame(sort(table(electron_commits_info_employee$user)))
  electron_top_emp <- electron_top_emp[order(electron_top_emp$Freq, decreasing = TRUE),]
  electron_top_emp <- electron_top_emp[1:10,]
  electron_top_emp[,3] <- "electron"
  colnames(electron_top_emp) <- c("user", "n_commits", "project")
  
  gitlfs_top_emp <- as.data.frame(sort(table(gitlfs_commits_info_employee$user)))
  gitlfs_top_emp <- gitlfs_top_emp[order(gitlfs_top_emp$Freq, decreasing = TRUE),]
  gitlfs_top_emp <- gitlfs_top_emp[1:10,]
  gitlfs_top_emp[,3] <- "gitlfs"
  colnames(gitlfs_top_emp) <- c("user", "n_commits", "project")
  
  hubot_top_emp <- as.data.frame(sort(table(hubot_commits_info_employee$user)))
  hubot_top_emp <- hubot_top_emp[order(hubot_top_emp$Freq, decreasing = TRUE),]
  hubot_top_emp <- hubot_top_emp[1:10,]
  hubot_top_emp[,3] <- "hubot"
  colnames(hubot_top_emp) <- c("user", "n_commits", "project")
  
  linguist_top_emp <- as.data.frame(sort(table(linguist_commits_info_employee$user)))
  linguist_top_emp <- linguist_top_emp[order(linguist_top_emp$Freq, decreasing = TRUE),]
  linguist_top_emp <- linguist_top_emp[1:10,]
  linguist_top_emp[,3] <- "linguist"
  colnames(linguist_top_emp) <- c("user", "n_commits", "project")
  
  top_empl <- rbind(atom_top_emp, electron_top_emp, gitlfs_top_emp, hubot_top_emp, linguist_top_emp)
  
  path_emp <- paste0(local_path, "top_employees.csv")
  write.csv(x =  top_empl, file = path_emp, row.names = FALSE)
  
  #Volunters
  atom_top_vol <- as.data.frame(sort(table(atom_commits_info_volunter$user)))
  atom_top_vol <- atom_top_vol[order(atom_top_vol$Freq, decreasing = TRUE),]
  atom_top_vol <- atom_top_vol[1:10,]
  atom_top_vol[,3] <- "atom"
  colnames(atom_top_vol) <- c("user", "n_commits", "project")
  
  electron_top_vol <- as.data.frame(sort(table(electron_commits_info_volunter$user)))
  electron_top_vol <- electron_top_vol[order(electron_top_vol$Freq, decreasing = TRUE),]
  electron_top_vol <- electron_top_vol[1:10,]
  electron_top_vol[,3] <- "electron"
  colnames(electron_top_vol) <- c("user", "n_commits", "project")
  
  gitlfs_top_vol <- as.data.frame(sort(table(gitlfs_commits_info_volunter$user)))
  gitlfs_top_vol <- gitlfs_top_vol[order(gitlfs_top_vol$Freq, decreasing = TRUE),]
  gitlfs_top_vol <- gitlfs_top_vol[1:10,]
  gitlfs_top_vol[,3] <- "gitlfs"
  colnames(gitlfs_top_vol) <- c("user", "n_commits", "project")
  
  hubot_top_vol <- as.data.frame(sort(table(hubot_commits_info_volunter$user)))
  hubot_top_vol <- hubot_top_vol[order(hubot_top_vol$Freq, decreasing = TRUE),]
  hubot_top_vol <- hubot_top_vol[1:10,]
  hubot_top_vol[,3] <- "hubot"
  colnames(hubot_top_vol) <- c("user", "n_commits", "project")
  
  linguist_top_vol <- as.data.frame(sort(table(linguist_commits_info_volunter$user)))
  linguist_top_vol <- linguist_top_vol[order(linguist_top_vol$Freq, decreasing = TRUE),]
  linguist_top_vol <- linguist_top_vol[1:10,]
  linguist_top_vol[,3] <- "linguist"
  colnames(linguist_top_vol) <- c("user", "n_commits", "project")
  
  top_vol <- rbind(atom_top_vol, electron_top_vol, gitlfs_top_vol, hubot_top_vol, linguist_top_vol)
  path_vol <- paste0(local_path, "top_volunters.csv")
  write.csv(x =  top_vol, file = path_vol, row.names = FALSE)
  
  
}

format_commits_group <- function(group, message, type){
  
  a <- format_data(atom_commits_info_employee, group)
  c <- format_data(electron_commits_info_employee, group)
  e <- format_data(gitlfs_commits_info_employee, group)
  g <- format_data(hubot_commits_info_employee, group)
  i <- format_data(linguist_commits_info_employee, group)
  
  b <- format_data(atom_commits_info_volunter, group)
  d <- format_data(electron_commits_info_volunter, group)
  f <- format_data(gitlfs_commits_info_volunter, group)
  h <- format_data(hubot_commits_info_volunter, group)
  j <- format_data(linguist_commits_info_volunter, group)
  
  format_data_to_stacked_grouped(a, b, c, d, e, f, g, h, i, j, group, message, type)
  
}
