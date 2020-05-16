  #!/usr/bin/env Rscript

#TODO Documentation
#plot with frequency - grouped
plot_data_stacked <- function(group_feat_name, subtitle, type) {
  
  input_path <- paste0(local_path, "metrics/data_plot/", group_feat_name, "_", type, ".csv")
  
  if(grepl("employee", group_feat_name)){
    projects_data <- read.csv(input_path, row.names = c("Bot", "Employee", "Volunteer"))
    projects_data <- melt(cbind(projects_data, Who = rownames(projects_data)), id.vars = c('Who'))
    
  } else if(grepl("week", group_feat_name)){
    
    projects_data <- read.csv(input_path, row.names = c("Sunday", "Wednesday", "Thursday", "Saturday", "Monday", "Friday", "Tuesday"))
    projects_data <- melt(cbind(projects_data, Day = rownames(projects_data)), id.vars = c('Day'))
    
  } else {
    projects_data <- read.csv(input_path, row.names = c("First day", "< 1 Month", "< 6 Months", "< 1 Year",  "1 year +"))
    projects_data <- melt(cbind(projects_data, Time = rownames(projects_data)), id.vars = c('Time'))
  }
  
  file_out <- paste0(type, "_", group_feat_name, "_")
  file_out <- paste0(file_out, "stacked")
  file_out_eps <- paste0(file_out, ".eps")
  file_out_png <- paste0(file_out, ".png")
  
  projects_data[projects_data == 0] <- NA
  
  #Plot of Employee/Volunter Opening/Closing
  if(grepl("employee", group_feat_name)){
    
    ggplot(projects_data, aes(factor(projects_data$variable), projects_data$value, fill = factor(projects_data$Who, levels = c("Volunteer", "Employee", "Bot")))) +
      geom_bar(stat = "identity", colour="black") +
      scale_fill_manual(values = c("#ececec", "#4b4b4b", "#969696")) +
      geom_text(aes(label = round(projects_data$value, 1), y = projects_data$value), position = position_stack(vjust = 0.5), color = "gray", size = 6) +
      #ggtitle(paste0(type, "_", group_feat_name)) +
      # theme(legend.position="none") +
      theme(panel.background = element_rect(fill = "white", colour = "grey50"), legend.box.background = element_rect(), axis.text = element_text(size = 12), axis.title = element_text(size = 14), legend.position = "top", legend.title = element_text(size = 14), legend.text = element_text(size = 14)) +
      labs(fill = "Who", x = "" , y = "Percentage") +
      ggsave(file_out_eps, height = 6, width = 8) +
      ggsave(file_out_png, height = 6, width = 8)
    
    #Commits by day of week
  } else if(grepl("week", group_feat_name)){
    
    ggplot(projects_data, aes(factor(projects_data$variable), projects_data$value, fill = factor(projects_data$Day, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")))) +
      geom_bar(stat = "identity", colour="black") +
      scale_fill_manual(values = c("#9FA8DA","#5C6BC0", "#3949AB", "#283593", "#536DFE", "#304FFE", "#512DA8")) +
      geom_text(aes(label = round(projects_data$value, 1), y = projects_data$value), position = position_stack(vjust = 0.6), color = "gray", size = 4) +
      #ggtitle(paste0(type, "_", group_feat_name)) +
      #  theme(legend.position="none") +
      theme(panel.background = element_rect(fill = "white", colour = "grey50"), legend.box.background = element_rect(), axis.text = element_text(size = 14), axis.title = element_text(size = 16), legend.position = "right", legend.title = element_text(size = 16), legend.text = element_text(size = 16)) +
      labs(fill = "Day", x = "" , y = "Percentage") +
      ggsave(file_out_eps) +
      ggsave(file_out_png)
    
    #Commits by hour  
  } else if(grepl("hour", group_feat_name)){
    
    ggplot(projects_data, aes(factor(projects_data$variable), projects_data$value, fill = factor(projects_data$Day, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")))) +
      geom_bar(stat = "identity", colour="black") +
      scale_fill_manual(values = c("#9FA8DA","#5C6BC0", "#3949AB", "#283593", "#536DFE", "#304FFE", "#512DA8")) +
      geom_text(aes(label = round(projects_data$value, 1), y = projects_data$value), position = position_stack(vjust = 0.6), color = "gray", size = 4) +
      # theme(legend.position="none") +
      theme(panel.background = element_rect(fill = "white", colour = "grey50"), legend.box.background = element_rect(), axis.text = element_text(size = 14), axis.title = element_text(size = 16), legend.position = "right", legend.title = element_text(size = 16), legend.text = element_text(size = 16)) +
      #ggtitle(paste0(type, "_", group_feat_name)) +
      labs(fill = "Day", x = "" , y = "Percentage") +
      ggsave(file_out_eps, height = 6, width = 8) +
      ggsave(file_out_png, height = 6, width = 8)
    
    #Pulls/issues by time opened
  } else {
    
    ggplot(projects_data, aes(factor(projects_data$variable), projects_data$value, fill = factor(projects_data$Time, levels = c("First day", "< 1 Month", "< 6 Months", "< 1 Year",  "1 year +")))) +
      geom_bar(stat = "identity", colour="black") +
      scale_fill_manual(values = c("#9FA8DA","#5C6BC0", "#3949AB", "#283593", "#536DFE")) +
      geom_text(aes(label = round(projects_data$value, 1), y = projects_data$value), position = position_stack(vjust = 0.5), color = "gray", size= 8) +
      #theme(text = element_text(size=20), legend.position="right") +
      #ggtitle(paste0(type, "_", group_feat_name)) 
      theme(axis.text = element_text(size = 24), axis.title = element_text(size = 28), legend.position = "bottom", legend.title = element_text(size = 18), legend.text = element_text(size = 18)) +
      labs(fill = "Time", x = "" , y = "Percentage") +
      ggsave(file_out_eps, height = 14, width = 10) +
      ggsave(file_out_png, height = 14, width = 10)
    
  }
  
  
}


plot_data <- function(input_data, project, title, xSub, ySub){
  
  #counts <- table(input_data$period_of_day)
  #barplot(counts, main= title,
  #        xlab= subtitle) 
  
  
  
#  colnames(input_data) <- c("12am", "1am", "2am", "3am",
 #                           "4am", "5am", "6am", "7am",
  #                          "8am", "9am", "10am", "11am",
   #                         "12pm", "1pm", "2pm", "3pm",
    #                        "4pm", "5pm", "6pm", "7pm",
     #                       "8pm", "9pm", "10pm", "11pm")
  
 # input_data
  
  
  b <- ggplot(data=input_data, aes(x=factor(input_data$period_of_day))) +
       geom_bar(stat="count", width=0.6, fill="#6f7498")+
       ggtitle(title) +
       scale_x_discrete(labels = c("0", "1", "2", "3",
                                   "4", "5", "6", "7",
                                   "8", "8", "10", "11",
                                   "12", "13", "14", "15",
                                   "16", "17", "18", "19",
                                   "20", "21", "22", "23")) +
       #coord_cartesian(ylim=c(0,3000)) +
       xlab(xSub) + ylab(ySub) +
       theme_minimal()
  
  
  

  out <- paste0(commits_plots_path, project, ".eps")
  out2 <- paste0(commits_plots_path, project, ".png")
  
  ggsave(out)
  
  ggsave(out2)
  
  return(b)
}
