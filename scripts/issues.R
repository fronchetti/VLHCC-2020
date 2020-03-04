issues <- function(){
  
  # Set the output dir
  setwd(issues_plots_path)

  # Plot 1: Histogram of days_opened
  format_issues_group('days_opened_group', "Quantidade de dias que Issues ficaram abertas", "issues")
  plot_data_stacked('days_opened_group', "Quantidade de dias que Issues ficaram abertas", "issues")
  
  # Plot 2: Histogram of days_between_first_and_last_comment
  format_issues_group('days_between_first_and_last_comment_group', "Quantidade de dias entre o primeiro e o ultimo comentário", "issues")
  plot_data_stacked('days_between_first_and_last_comment_group', "Quantidade de dias entre o primeiro e o ultimo comentário", "issues")
  
  # Plot 3: Histogram of days_first_comment_after_creation
  format_issues_group('days_first_comment_after_creation_group', "Quantidade de dias entre a criação da Issue e o Primeiro comentário", "issues")
  plot_data_stacked('days_first_comment_after_creation_group', "Quantidade de dias entre a criação da Issue e o Primeiro comentário", "issues")
  
  # Plot 6: Histogram of days_last_comment_before_closed
  format_issues_group('days_last_comment_before_closed_group', "Quantidade de dias entre o Último comentário e o fechamento da Issue", "issues")
  plot_data_stacked('days_last_comment_before_closed_group', "Quantidade de dias entre o Último comentário e o fechamento da Issue", "issues")
  
  # Plot 7: Histogram of employee_open
  format_data_to_stacked_plot(
    format_data("atom", atom_issues_info, 'employee_open'),
    format_data("electron", electron_issues_info, 'employee_open'),
    format_data("gitlfs", gitlfs_issues_info, 'employee_open'),
    format_data("hubot", hubot_issues_info, 'employee_open'),
    format_data("linguist", linguist_issues_info, 'employee_open'),
    'employee_open',
    "Quem abriu as Issues",
    "issues")
  
  plot_data_stacked('employee_open',
                    "Quem abriu as Issues",
                    "issues")
  
  # Plot 8: Histogram of employee_closed
  format_data_to_stacked_plot(
    format_data("atom", atom_issues_info, 'employee_closed'),
    format_data("electron", electron_issues_info, 'employee_closed'),
    format_data("gitlfs", gitlfs_issues_info, 'employee_closed'), 
    format_data("hubot", hubot_issues_info, 'employee_closed'), 
    format_data("linguist", linguist_issues_info, 'employee_closed'),
    'employee_closed',
    "Quem fechou as Issues",
    "issues")
  
  plot_data_stacked('employee_closed',
                    "Quem fechou as Issues",
                    "issues")
  
}

#Subsetting in Employee, Volunter and bot.
subset_issues <- function(){



}

format_issues_group <- function(group, message, type){
  
  a <- format_data("AE", atom_issues_info_employee, group)
  c <- format_data("EE", electron_issues_info_employee, group)
  e <- format_data("GE", gitlfs_issues_info_employee, group)
  g <- format_data("HE", hubot_issues_info_employee, group)
  i <- format_data("LE", linguist_issues_info_employee, group)
  
  b <- format_data("AV", atom_issues_info_volunter, group)
  d <- format_data("EV", electron_issues_info_volunter, group)
  f <- format_data("GV", gitlfs_issues_info_volunter, group)
  h <- format_data("HV", hubot_issues_info_volunter, group)
  j <- format_data("LV", linguist_issues_info_volunter, group)
  
  format_data_to_stacked_grouped(a, b, c, d, e, f, g, h, i, j, group, message, type)

}
