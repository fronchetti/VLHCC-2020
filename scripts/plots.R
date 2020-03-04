#!/usr/bin/env Rscript

#TODO Documentation
#plot with frequency - grouped
plot_data_stacked <- function(group_feat_name, subtitle, type) {
  
  input_path <- paste0(local_path, "metrics/data_plot/", group_feat_name, "_", type, ".csv")
  
  if(grepl("employee", group_feat_name)){
    projects_data <- read.csv(input_path, row.names = c("Bot", "Employee", "Volunteer"))
    projects_data <- melt(cbind(projects_data, Who = rownames(projects_data)), id.vars = c('Who'))

    #colnames(projects_data) <- c("Who", "Projects", "Frequency")
    #Who <- factor(levels = c("Bot", "Empregado", "Volunt?rio"))
    
    
  } else {
    projects_data <- read.csv(input_path, row.names = c("First day", "Up to 1 Month", "Up to 6 Months", "Up to 1 Year", "More than 1 year"))
    projects_data <- melt(cbind(projects_data, Time = rownames(projects_data)), id.vars = c('Time'))
    #colnames(projects_data) <- c("Time", "Projects", "Frequency")
    #Time <- factor(levels = c("Primeiro dia", "At? um m?s", "At? 6 meses", "At? um ano", "Mais de um ano"))
  }
  
  file_out <- paste0(type, "_", group_feat_name, "_")
  file_out <- paste0(file_out, "stacked")
  file_out_eps <- paste0(file_out, ".eps")
  file_out_png <- paste0(file_out, ".png")
  
  projects_data[projects_data == 0] <- NA
  
  if(grepl("employee", group_feat_name)){

    ggplot(projects_data, aes(factor(projects_data$variable), projects_data$value, fill = factor(projects_data$Who, levels = c("Volunteer", "Employee", "Bot")))) +
    geom_bar(stat = "identity") +
    #scale_fill_manual(values = c("#a1d99b", "#31a354", "#C120C0")) +
    geom_text(aes(label = round(projects_data$value, 1), y = projects_data$value), position = position_stack(vjust = 0.5), color = "white") +
    ggtitle(paste0(type, "_", group_feat_name)) +
    labs(fill = "Who", x = "Projects" , y = "Percentage") +
    ggsave(file_out_eps) +
    ggsave(file_out_png)
    
  } else {
    
    ggplot(projects_data, aes(factor(projects_data$variable), projects_data$value, fill = factor(projects_data$Time, levels = c("First day", "Up to 1 Month", "Up to 6 Months", "Up to 1 Year", "More than 1 year")))) +
    geom_bar(stat = "identity") +
    #scale_fill_manual(values = c("#a1d99b", "#31a354", "#C120C0")) +
    geom_text(aes(label = round(projects_data$value, 1), y = projects_data$value), position = position_stack(vjust = 0.5), color = "white") +
    ggtitle(paste0(type, "_", group_feat_name)) +
    labs(fill = "Time", x = "Projects" , y = "Percentage") +
    ggsave(file_out_eps) +
    ggsave(file_out_png)

  }
  
  
}


