load_data <- function(dataset_path){
  mydata <- read_csv(dataset_path)
  return (mydata)
}

#' Create a factor feature for the intervals of a given numeric feature
#' in a given dataframe.
#'
#' @param input_data the input dataframe
#' @param feat the feature to create intervals
#'
#' @return the updated dataframe with a new feature for the intervals
create_intervals <- function(input_data, feat) {
  
  # Intervals range in days
  intervals <- c(0, 1, 30, 180, 365, +Inf)
  
  # Cut the input data
  group_feat_name <- paste0(feat, "_group")
  input_data[group_feat_name] <- cut(as.integer(input_data[[feat]]), intervals)
  return(input_data)
  
}

create_intervals_date <- function(input_data) {
 
  
  
  attr(input_data$date, "tzone") <- "US/Pacific"
  
  input_data$day_of_week <- weekdays(as.Date(input_data$date))
  
  input_data$period_of_day <- cut(as.integer(format(input_data$date, "%H")) + 1,
                                 breaks = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24)
                                  #breaks = c(0, 8, 18, 24)
                                  #seq(0, 24, 1)
                                  )
  
  return (input_data)
}


#' Formmat the data to stack plot and save
#'
#' @param df1 the first input dataframe
#' @param df2 the second input dataframe
#' @param df3 the third input dataframe
#' @param df4 the fourth input dataframe
#' @param df5 the fifth input dataframe
#' @param group_feat_name the string containing the name of the feat group
#' @param subtitle the subtitle for the plot
#'
#' @return nothing
format_data_to_stacked_plot <- function(df1, df2, df3, df4, df5, group_feat_name, subtitle, type) {
  
  frequency_vector <- cbind(df1$frequency, df2$frequency, df3$frequency, df4$frequency, df5$frequency)
  projects_data <- as.data.frame(frequency_vector)
  
  colnames(projects_data) <- c("atom", "electron", "gitlfs", "hubot", "linguist")
  path_out <- paste0(local_path, "metrics/data_plot/", group_feat_name, "_", type, ".csv")
  write_csv(x = projects_data, path = path_out)
  #print("Saving plot data for " + group_feat_name + "on " + subtitle)
  
}

#TODO Documentation
#format with frequency - individually
format_data <- function(input_data, group_feat_name) {
  
  data_as_table <- table(input_data[group_feat_name])
  
  data_as_df <- as.data.frame(data_as_table)
  
  print(data_as_df)
  print(group_feat_name)
  
  colnames(data_as_df) <- c(group_feat_name, "frequency")
  
  frequency <- (data_as_df$frequency/sum(data_as_df$frequency))*100
  
  data_as_df$frequency <- frequency
  
  data_as_df <- check_bot(data_as_df)
  
  return(data_as_df)
}

#TODO Documentation
format_data_to_stacked_grouped <- function(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, group_feat_name, subtitle, type) {
  
  frequency_vector <- cbind(df1$frequency, df2$frequency, df3$frequency, df4$frequency, df5$frequency, df6$frequency, df7$frequency, df8$frequency, df9$frequency, df10$frequency)
  projects_data <- as.data.frame(frequency_vector)
  
  colnames(projects_data) <- c("AE", "AV", "EE", "EV",
                               "HE", "HV", "GE", "GV", "LE", "LV")
  
  path_out <- paste0(local_path, "metrics/data_plot/", group_feat_name, "_", type, ".csv")
  write_csv(x = projects_data, path = path_out)
}

format_commit_data_to_stacked <- function(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, project, group_feat_name, type) {
  
  df <- format_data("atom", df1, group_feat_name)
  
  df
  
  
  frequency_vector <- cbind(df1$frequency, df2$frequency, df3$frequency, df4$frequency, df5$frequency, df6$frequency, df7$frequency, df8$frequency, df9$frequency, df10$frequency)
  #projects_data <- as.data.frame(frequency_vector)
  
  #colnames(projects_data) <- c("AE", "AV", "EE", "EV",
  #                             "HE", "HV", "GE", "GV", "LE", "LV")
  
  #path_out <- paste0(local_path, "metrics/data_plot/", group_feat_name, "_", type, ".csv")
  #write_csv(x = projects_data, path = path_out)
  
}

#TODO Documentation
# Features to cut
feats_to_cut_issues <- c("days_opened", "days_between_first_and_last_comment", "days_first_comment_after_creation", "days_last_comment_before_closed")
feats_to_cut_pulls <- c("days_opened", "days_between_first_and_last_comment", "days_first_comment_after_creation", "days_last_comment_before_closed")

#TODO Documentation
check_bot <- function(x){
  
  if(nrow(x) < 3){
    
    aux <- data.frame("bot", 0.000000)
    
    colnames(aux) <- colnames(x)
    
    x <- rbind(aux, x)
    
  }
  
  return(x)
}

#Subset the data by a parameter
subseting <- function(dataset, column, parameter, type){
  
  sub_data <- subset(dataset, column == parameter)
  file_path <- paste0(local_path, "metrics/subset/", deparse(substitute(dataset)))
  file_path <- paste0(file_path, "_")
  file_path <- paste0(file_path, parameter)
  file_path <- paste0(file_path, "_", type, ".csv")
  
  print(file_path)
  
  write_csv(path = file_path, x = sub_data)
  
  return(sub_data)
}

#TODO Documentation
sort_users <- function(employee, volunter){
  
  s <- plyr::count(volunter$user_closed)
  s <- arrange(s, desc(s$freq), s$x)
  
  colnames(s) <- c("names", "count")
  
  print("Volunter")
  print(s)
  
  p <- plyr::count(employee$user_closed)
  p <- arrange(p, desc(p$freq), p$x)
  colnames(p) <- c("names", "count")
  
  print("Employee")
  print(p)
  
}

