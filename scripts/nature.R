nature <- function(){
  
  atom_nature_metrics <- load_data(paste0(local_path, "results_nature/atom_nature_metrics.csv"))
  electron_nature_metrics <- load_data(paste0(local_path, "results_nature/electron_nature_metrics.csv"))
  gitlfs_nature_metrics <- load_data(paste0(local_path, "results_nature/gitlfs_nature_metrics.csv"))
  hubot_nature_metrics <- load_data(paste0(local_path, "results_nature/hubot_nature_metrics.csv"))
  linguist_nature_metrics <- load_data(paste0(local_path, "results_nature/linguist_nature_metrics.csv"))
  
  #Atom
  atom_fep_median <- median(atom_nature_metrics$forward_engineering_percent)
  atom_cep_median <- median(atom_nature_metrics$corrective_engineering_percent)
  atom_rep_median <- median(atom_nature_metrics$reengineering_percent)
  atom_unp_median <- median(atom_nature_metrics$uncategorized_percent)
  atom_map_median <- median(atom_nature_metrics$management_percent)
  
  atom_fep_mean <- mean(atom_nature_metrics$forward_engineering_percent)
  atom_cep_mean <- mean(atom_nature_metrics$corrective_engineering_percent)
  atom_rep_mean <- mean(atom_nature_metrics$reengineering_percent)
  atom_unp_mean <- mean(atom_nature_metrics$uncategorized_percent)
  atom_map_mean <- mean(atom_nature_metrics$management_percent)
  
  atom_nature <- cbind(atom_fep_median, atom_cep_median, atom_rep_median, atom_unp_median, atom_map_median, atom_fep_mean, atom_cep_mean, atom_rep_mean, atom_unp_mean, atom_map_mean)
  
  #Electron
  electron_fep_median <- median(electron_nature_metrics$forward_engineering_percent)
  electron_cep_median <- median(electron_nature_metrics$corrective_engineering_percent)
  electron_rep_median <- median(electron_nature_metrics$reengineering_percent)
  electron_unp_median <- median(electron_nature_metrics$uncategorized_percent)
  electron_map_median <- median(electron_nature_metrics$management_percent)
  
  electron_fep_mean <- mean(electron_nature_metrics$forward_engineering_percent)
  electron_cep_mean <- mean(electron_nature_metrics$corrective_engineering_percent)
  electron_rep_mean <- mean(electron_nature_metrics$reengineering_percent)
  electron_unp_mean <- mean(electron_nature_metrics$uncategorized_percent)
  electron_map_mean <- mean(electron_nature_metrics$management_percent)
  
  electron_nature <- cbind(electron_fep_median, electron_cep_median, electron_rep_median, electron_unp_median, electron_map_median, electron_fep_mean, electron_cep_mean, electron_rep_mean, electron_unp_mean, electron_map_mean)
  
  
  #Gitlfs
  gitlfs_fep_median <- median(gitlfs_nature_metrics$forward_engineering_percent)
  gitlfs_cep_median <- median(gitlfs_nature_metrics$corrective_engineering_percent)
  gitlfs_rep_median <- median(gitlfs_nature_metrics$reengineering_percent)
  gitlfs_unp_median <- median(gitlfs_nature_metrics$uncategorized_percent)
  gitlfs_map_median <- median(gitlfs_nature_metrics$management_percent)
  
  gitlfs_fep_mean <- mean(gitlfs_nature_metrics$forward_engineering_percent)
  gitlfs_cep_mean <- mean(gitlfs_nature_metrics$corrective_engineering_percent)
  gitlfs_rep_mean <- mean(gitlfs_nature_metrics$reengineering_percent)
  gitlfs_unp_mean <- mean(gitlfs_nature_metrics$uncategorized_percent)
  gitlfs_map_mean <- mean(gitlfs_nature_metrics$management_percent)
  
  gitlfs_nature <- cbind(gitlfs_fep_median, gitlfs_cep_median, gitlfs_rep_median, gitlfs_unp_median, gitlfs_map_median, gitlfs_fep_mean, gitlfs_cep_mean, gitlfs_rep_mean, gitlfs_unp_mean, gitlfs_map_mean)
  
  #Hubot
  hubot_fep_median <- median(hubot_nature_metrics$forward_engineering_percent)
  hubot_cep_median <- median(hubot_nature_metrics$corrective_engineering_percent)
  hubot_rep_median <- median(hubot_nature_metrics$reengineering_percent)
  hubot_unp_median <- median(hubot_nature_metrics$uncategorized_percent)
  hubot_map_median <- median(hubot_nature_metrics$management_percent)
  
  hubot_fep_mean <- mean(hubot_nature_metrics$forward_engineering_percent)
  hubot_cep_mean <- mean(hubot_nature_metrics$corrective_engineering_percent)
  hubot_rep_mean <- mean(hubot_nature_metrics$reengineering_percent)
  hubot_unp_mean <- mean(hubot_nature_metrics$uncategorized_percent)
  hubot_map_mean <- mean(hubot_nature_metrics$management_percent)
  
  hubot_nature <- cbind(hubot_fep_median, hubot_cep_median, hubot_rep_median, hubot_unp_median, hubot_map_median, hubot_fep_mean, hubot_cep_mean, hubot_rep_mean, hubot_unp_mean, hubot_map_mean)
  
  #Linguist
  linguist_fep_median <- median(linguist_nature_metrics$forward_engineering_percent)
  linguist_cep_median <- median(linguist_nature_metrics$corrective_engineering_percent)
  linguist_rep_median <- median(linguist_nature_metrics$reengineering_percent)
  linguist_unp_median <- median(linguist_nature_metrics$uncategorized_percent)
  linguist_map_median <- median(linguist_nature_metrics$management_percent)
  
  linguist_fep_mean <- mean(linguist_nature_metrics$forward_engineering_percent)
  linguist_cep_mean <- mean(linguist_nature_metrics$corrective_engineering_percent)
  linguist_rep_mean <- mean(linguist_nature_metrics$reengineering_percent)
  linguist_unp_mean <- mean(linguist_nature_metrics$uncategorized_percent)
  linguist_map_mean <- mean(linguist_nature_metrics$management_percent)
  
  linguist_nature <- cbind(linguist_fep_median, linguist_cep_median, linguist_rep_median, linguist_unp_median, linguist_map_median, linguist_fep_mean, linguist_cep_mean, linguist_rep_mean, linguist_unp_mean, linguist_map_mean)
  
  results_nature <- rbind(atom_nature, electron_nature, gitlfs_nature, hubot_nature, linguist_nature)
  colnames(results_nature) <- c("fep_median", "cep_median", "rep_median", "unp_median", "map_median", "fep_mean", "cep_mean", "rep_mean", "unp_mean", "map_mean")
  rownames(results_nature) <- c("atom", "electron", "gitlfs", "hubot", "linguist")
  
  results_nature <- t(results_nature)
  
  write.table(results_nature)
  #grid.table(results_nature)
  
  #png("projects_nature.png", height = 50*nrow(results_nature), width = 200*ncol(results_nature))
  grid.table(results_nature)
  write.csv(results_nature, "projects_nature.csv")
}
