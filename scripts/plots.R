# TODO Documentation
# Please Caio, write the documentation for this method
plot_data_stacked <- function(group_feat_name, subtitle, type) {
  input_path <- paste0(working_directory, "metrics/data_plot/", group_feat_name, "_", type, ".csv")
  
  if(grepl("week", group_feat_name)){
    projects_data <- read.csv(input_path, row.names = c("Sunday", "Wednesday", "Thursday", "Saturday", "Monday", "Friday", "Tuesday"))
    projects_data <- melt(cbind(projects_data, Day = rownames(projects_data)), id.vars = c('Day'))
  }
  
  file_out <- paste0(working_directory, "/plots/commits/", type, "_", group_feat_name, "_")
  file_out <- paste0(file_out, "stacked")
  file_out_eps <- paste0(file_out, ".eps")
  file_out_png <- paste0(file_out, ".png")
  
  projects_data[projects_data == 0] <- NA
  
  if(grepl("week", group_feat_name)){
      ggplot(projects_data, aes(factor(projects_data$variable), projects_data$value, fill = factor(projects_data$Day, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")))) +
      geom_bar(stat = "identity", colour="black") +
      scale_fill_manual(values = c("#9FA8DA","#5C6BC0", "#3949AB", "#283593", "#536DFE", "#304FFE", "#512DA8")) +
      geom_text(aes(label = round(projects_data$value, 1), y = projects_data$value), position = position_stack(vjust = 0.6), color = "gray", size = 4) +
      theme(panel.background = element_rect(fill = "white", colour = "grey50"), legend.box.background = element_rect(), axis.text = element_text(size = 14), axis.title = element_text(size = 16), legend.position = "right", legend.title = element_text(size = 16), legend.text = element_text(size = 16)) +
      labs(fill = "Day", x = "" , y = "Percentage") +
      ggsave(file_out_eps) +
      ggsave(file_out_png)
  } 
}

# TODO Documentation
# Please Caio, write the documentation for this method
plot_data <- function(input_data, project, title, xSub, ySub){
  b <- ggplot(data=input_data, aes(x=factor(input_data$period_of_day))) +
       geom_bar(stat="count", width=0.6, fill="#6f7498")+
       ggtitle(title) +
       scale_x_discrete(labels = c("0", "1", "2", "3",
                                   "4", "5", "6", "7",
                                   "8", "8", "10", "11",
                                   "12", "13", "14", "15",
                                   "16", "17", "18", "19",
                                   "20", "21", "22", "23")) +
       xlab(xSub) + ylab(ySub) +
       theme_minimal()
  out <- paste0(commits_plots_path, project, ".eps")
  out2 <- paste0(commits_plots_path, project, ".png")
  ggsave(out)
  ggsave(out2)
  return(b)
}
