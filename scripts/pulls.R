pulls <- function(){
  
  # Set the output dir
  setwd(pulls_plots_path)
  
  # Plot 1: Histogram of days_opened
  format_pulls_group('days_opened_group', "Quantidade de dias que pulls ficaram abertas", "pulls")
  plot_data_stacked('days_opened_group', "Quantidade de dias que pulls ficaram abertas", "pulls")
  
  # Plot 2: Histogram of days_between_first_and_last_comment
  format_pulls_group('days_between_first_and_last_comment_group', "Quantidade de dias entre o primeiro e o ultimo comentário", "pulls")
  plot_data_stacked('days_between_first_and_last_comment_group', "Quantidade de dias entre o primeiro e o ultimo comentário", "pulls")
  
  # Plot 3: Histogram of days_first_comment_after_creation
  format_pulls_group('days_first_comment_after_creation_group', "Quantidade de dias entre a criação da Pull Request e o Primeiro comentário", "pulls")
  plot_data_stacked('days_first_comment_after_creation_group', "Quantidade de dias entre a criação da Pull Request e o Primeiro comentário", "pulls")
  
  # Plot 6: Histogram of days_last_comment_before_merged
  format_pulls_group('days_last_comment_before_merged_group', "Quantidade de dias entre o Último comentário e o merge da Pull Request", "pulls")
  plot_data_stacked('days_last_comment_before_merged_group', "Quantidade de dias entre o Último comentário e o merge da Pull Request", "pulls")
  
  # Plot 7: Histogram of employee_open
  format_data_to_stacked_plot(
    format_data("atom", atom_pulls_info, 'employee_open'),
    format_data("electron", electron_pulls_info, 'employee_open'),
    format_data("gitlfs", gitlfs_pulls_info, 'employee_open'),
    format_data("hubot", hubot_pulls_info, 'employee_open'),
    format_data("linguist", linguist_pulls_info, 'employee_open'),
    'employee_open',
    "Quem abriu as pulls",
    "pulls")
  
  plot_data_stacked('employee_open',
                    "Quem abriu as pulls",
                    "pulls")
  
  # Plot 8: Histogram of employee_merged
  format_data_to_stacked_plot(
    format_data("atom", atom_pulls_info, 'employee_merged'),
    format_data("electron", electron_pulls_info, 'employee_merged'),
    format_data("gitlfs", gitlfs_pulls_info, 'employee_merged'), 
    format_data("hubot", hubot_pulls_info, 'employee_merged'), 
    format_data("linguist", linguist_pulls_info, 'employee_merged'),
    'employee_merged',
    "Quem fechou as pulls",
    "pulls")
  
  plot_data_stacked('employee_merged',
                    "Quem fechou as pulls",
                    "pulls")
  
}

format_pulls_group <- function(group, message, type){
  
  a <- format_data("AE", atom_pulls_info_employee, group)
  c <- format_data("EE", electron_pulls_info_employee, group)
  e <- format_data("GE", gitlfs_pulls_info_employee, group)
  g <- format_data("HE", hubot_pulls_info_employee, group)
  i <- format_data("LE", linguist_pulls_info_employee, group)
  
  b <- format_data("AV", atom_pulls_info_volunter, group)
  d <- format_data("EV", electron_pulls_info_volunter, group)
  f <- format_data("GV", gitlfs_pulls_info_volunter, group)
  h <- format_data("HV", hubot_pulls_info_volunter, group)
  j <- format_data("LV", linguist_pulls_info_volunter, group)
  
  format_data_to_stacked_grouped(a, b, c, d, e, f, g, h, i, j, group, message, type)

}

