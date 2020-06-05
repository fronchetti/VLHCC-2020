# TODO Documentation
# Please Caio, write the documentation for this method
commits <- function() {
  ###############
  #  EMPLOYEES  #
  ############### 
  plot_data(atom_commits_info_employee, "atom_employee", "Atom - Employee - Commits by hour", "Hours Intervals", "Commits")
  plot_data(electron_commits_info_employee, "electron_employee", "Electron - Employee - Commits by hour", "Hours Intervals", "Commits")
  plot_data(gitlfs_commits_info_employee, "gitlfs_employee", "Gitlfs - Employee - Commits by hour", "Hours Intervals", "Commits")
  plot_data(hubot_commits_info_employee, "hubot_employee", "Hubot - Employee - Commits by hour", "Hours Intervals", "Commits")
  plot_data(linguist_commits_info_employee, "linguist_employee", "Linguist - Employee - Commits by hour", "Hours Intervals", "Commits")
   
  ################
  #  VOLUNTEERS  #
  ################
  plot_data(atom_commits_info_volunter, "atom_volunter", "Atom - Volunter - Commits by hour", "Hours Intervals", "Commits")
  plot_data(electron_commits_info_volunter, "electron_volunter", "Electron - Volunter - Commits by hour", "Hours Intervals", "Commits")
  plot_data(gitlfs_commits_info_volunter, "gitlfs_volunter", "Gitlfs - Volunter - Commits by hour", "Hours Intervals", "Commits")
  plot_data(hubot_commits_info_volunter, "hubot_volunter", "Hubot - Volunter - Commits by hour", "Hours Intervals", "Commits")
  plot_data(linguist_commits_info_volunter, "linguist_volunter", "Linguist - Volunter - Commits by hour", "Hours Intervals", "Commits")
  
  # The methods below are not presented in the paper. 
  # Feel free to use them to get a (i) general overview of the hours intervals, and
  # (ii) get the stacked version of the commits data (as presented in Figure 1).
  
  #############
  #  GENERAL  #
  ############# 
  # plot_data(atom_commits_info, "atom", "Atom - Commits by hour", "Hours Intervals", "Commits")
  # plot_data(electron_commits_info, "electron", "Electron - Commits by hour", "Hours Intervals", "Commits")
  # plot_data(gitlfs_commits_info, "gitlfs", "Gitlfs - Commits by hour", "Hours Intervals", "Commits")
  # plot_data(hubot_commits_info, "hubot", "Hubot - Commits by hour", "Hours Intervals", "Commits")
  # plot_data(linguist_commits_info, "linguist", "Linguist - Commits by hour", "Hours Intervals", "Commits")
  
  #############
  #  STACKED  #
  #############
  format_commits_group('day_of_week', "Days of Week", "commits")
  plot_data_stacked('day_of_week', "Days of Week", "commits")
}

# TODO Documentation
# Please Caio, write the documentation for this method
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
