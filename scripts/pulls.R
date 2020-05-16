pulls <- function(){
  
  # Set the output dir
  setwd(pulls_plots_path)
  
  dormand_pulls()
  
  # Plot 1: Histogram of days_opened
  format_pulls_group('days_opened_group', "Quantidade de dias que pulls ficaram abertas", "pulls")
  plot_data_stacked('days_opened_group', "Quantidade de dias que pulls ficaram abertas", "pulls")
  
  # Plot 2: Histogram of days_between_first_and_last_comment
  format_pulls_group('days_between_first_and_last_comment_group', "Quantidade de dias entre o primeiro e o ultimo comentario", "pulls")
  plot_data_stacked('days_between_first_and_last_comment_group', "Quantidade de dias entre o primeiro e o ultimo comentario", "pulls")
  
  # Plot 3: Histogram of days_first_comment_after_creation
  format_pulls_group('days_first_comment_after_creation_group', "Quantidade de dias entre a criacao da Pull Request e o Primeiro comentario", "pulls")
  plot_data_stacked('days_first_comment_after_creation_group', "Quantidade de dias entre a criacao da Pull Request e o Primeiro comentario", "pulls")
  
  # Plot 4: Histogram of days_last_comment_before_merged
  format_pulls_group('days_last_comment_before_closed_group', "Quantidade de dias entre o ultimo comentario e o merge da Pull Request", "pulls")
  plot_data_stacked('days_last_comment_before_closed_group', "Quantidade de dias entre o ultimo comentario e o merge da Pull Request", "pulls")
  
  # Plot 5: Histogram of employee_open
  format_data_to_stacked_plot(
    format_data(atom_pulls_info, 'employee_open'),
    format_data(electron_pulls_info, 'employee_open'),
    format_data(gitlfs_pulls_info, 'employee_open'),
    format_data(hubot_pulls_info, 'employee_open'),
    format_data(linguist_pulls_info, 'employee_open'),
    'employee_open',
    "Quem abriu as pulls",
    "pulls")
  
  plot_data_stacked('employee_open',
                    "Quem abriu as pulls",
                    "pulls")
  
  # Plot 6: Histogram of employee_merged
  format_data_to_stacked_plot(
    format_data(atom_pulls_info, 'employee_merged'),
    format_data(electron_pulls_info, 'employee_merged'),
    format_data(gitlfs_pulls_info, 'employee_merged'), 
    format_data(hubot_pulls_info, 'employee_merged'), 
    format_data(linguist_pulls_info, 'employee_merged'),
    'employee_merged',
    "Quem fechou as pulls",
    "pulls")
  
  plot_data_stacked('employee_merged',
                    "Quem fechou as pulls",
                    "pulls")
  
  #Counting Info
  sum(atom_pulls_info_employee$user_closed == 'null' & atom_pulls_info_employee$state == 'closed')/nrow(atom_pulls_info_employee)
  sum(electron_pulls_info_employee$user_closed == 'null' & electron_pulls_info_employee$state == 'closed')/nrow(electron_pulls_info_employee)
  sum(gitlfs_pulls_info_employee$user_closed == 'null' & gitlfs_pulls_info_employee$state == 'closed')/nrow(gitlfs_pulls_info_employee)
  sum(hubot_pulls_info_employee$user_closed == 'null' & hubot_pulls_info_employee$state == 'closed')/nrow(hubot_pulls_info_employee)
  sum(linguist_pulls_info_employee$user_closed == 'null' & linguist_pulls_info_employee$state == 'closed')/nrow(linguist_pulls_info_employee)
  
  sum(atom_pulls_info_volunter$user_closed == 'null' & atom_pulls_info_volunter$state == 'closed')/nrow(atom_pulls_info_volunter)
  sum(electron_pulls_info_volunter$user_closed == 'null' & electron_pulls_info_volunter$state == 'closed')/nrow(electron_pulls_info_volunter)
  sum(gitlfs_pulls_info_volunter$user_closed == 'null' & gitlfs_pulls_info_volunter$state == 'closed')/nrow(gitlfs_pulls_info_volunter)
  sum(hubot_pulls_info_volunter$user_closed == 'null' & hubot_pulls_info_volunter$state == 'closed')/nrow(hubot_pulls_info_volunter)
  sum(linguist_pulls_info_volunter$user_closed == 'null' & linguist_pulls_info_volunter$state == 'closed')/nrow(linguist_pulls_info_volunter)
  
  atom_pulls_info_employee[atom_pulls_info_employee == "null"] = 0
  electron_pulls_info_employee[electron_pulls_info_employee == "null"] = 0
  gitlfs_pulls_info_employee[gitlfs_pulls_info_employee == "null"] = 0
  hubot_pulls_info_employee[hubot_pulls_info_employee == "null"] = 0
  linguist_pulls_info_employee[linguist_pulls_info_employee == "null"] = 0
  
  atom_pulls_info_volunter[atom_pulls_info_volunter == "null"] = 0
  electron_pulls_info_volunter[electron_pulls_info_volunter == "null"] = 0
  gitlfs_pulls_info_volunter[gitlfs_pulls_info_volunter == "null"] = 0
  hubot_pulls_info_volunter[hubot_pulls_info_volunter == "null"] = 0
  linguist_pulls_info_volunter[linguist_pulls_info_volunter == "null"] = 0
  
  sum(as.numeric(atom_pulls_info_employee$days_opened) & !is.na(atom_pulls_info_employee))/nrow(atom_pulls_info_employee)
  sum(as.numeric(electron_pulls_info_employee$days_opened))/nrow(electron_pulls_info_employee)
  sum(as.numeric(gitlfs_pulls_info_employee$days_opened), na.rm=TRUE)/nrow(gitlfs_pulls_info_employee)
  sum(as.numeric(hubot_pulls_info_employee$days_opened))/nrow(hubot_pulls_info_employee)
  sum(as.numeric(linguist_pulls_info_employee$days_opened))/nrow(linguist_pulls_info_employee)
  
  sum(as.numeric(atom_pulls_info_volunter$days_opened))/nrow(atom_pulls_info_volunter)
  sum(as.numeric(electron_pulls_info_volunter$days_opened))/nrow(electron_pulls_info_volunter)
  sum(as.numeric(gitlfs_pulls_info_volunter$days_opened))/nrow(gitlfs_pulls_info_volunter)
  sum(as.numeric(hubot_pulls_info_volunter$days_opened))/nrow(hubot_pulls_info_volunter)
  sum(as.numeric(linguist_pulls_info_volunter$days_opened))/nrow(linguist_pulls_info_volunter)
  
}

format_pulls_group <- function(group, message, type){
  
  a <- format_data(atom_pulls_info_employee, group)
  c <- format_data(electron_pulls_info_employee, group)
  e <- format_data(gitlfs_pulls_info_employee, group)
  g <- format_data(hubot_pulls_info_employee, group)
  i <- format_data(linguist_pulls_info_employee, group)
  
  b <- format_data(atom_pulls_info_volunter, group)
  d <- format_data(electron_pulls_info_volunter, group)
  f <- format_data(gitlfs_pulls_info_volunter, group)
  h <- format_data(hubot_pulls_info_volunter, group)
  j <- format_data(linguist_pulls_info_volunter, group)
  
  format_data_to_stacked_grouped(a, b, c, d, e, f, g, h, i, j, group, message, type)

}

dormand_pulls <- function(){
  
  atom_pulls_dormand <- subset(atom_pulls_info, atom_pulls_info$days_opened_group == '(365,Inf]')
  electron_pulls_dormand <- subset(electron_pulls_info, electron_pulls_info$days_opened_group == '(365,Inf]')
  gitlfs_pulls_dormand <- subset(gitlfs_pulls_info, gitlfs_pulls_info$days_opened_group == '(365,Inf]')
  hubot_pulls_dormand <- subset(hubot_pulls_info, hubot_pulls_info$days_opened_group == '(365,Inf]')
  linguist_pulls_dormand <- subset(linguist_pulls_info, linguist_pulls_info$days_opened_group == '(365,Inf]')
  
  file_out_atom <- paste0(local_path, "metrics/subset/", "atom_pulls_dormand.csv")
  file_out_electron <- paste0(local_path, "metrics/subset/", "electron_pulls_dormand.csv")
  file_out_gitlfs <- paste0(local_path, "metrics/subset/", "gitlfs_pulls_dormand.csv")
  file_out_hubot <- paste0(local_path, "metrics/subset/", "hubot_pulls_dormand.csv")
  file_out_linguist <- paste0(local_path, "metrics/subset/", "linguist_pulls_dormand.csv")
  
  write.csv(file = file_out_atom, atom_pulls_dormand)
  write.csv(file = file_out_electron, electron_pulls_dormand)
  write.csv(file = file_out_gitlfs, gitlfs_pulls_dormand)
  write.csv(file = file_out_hubot, hubot_pulls_dormand)
  write.csv(file = file_out_linguist, linguist_pulls_dormand)
  
  
  
  
}
