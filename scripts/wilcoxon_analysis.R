#!/usr/bin/env Rscript

# Title     : Evaluate the metrics through the Wilcoxon Test
# Objective : Evaluate if there is a difference between buggy and clean code in terms 
#             of the technical and social metrics
# Created by: Filipe Falcão, filipebatista@ic.ufal.br
# Created on: 27/03/18


#' Wilcoxon Test and Cliff's Delta
#'
#' @param input_data the input dataframe with metrics
#' @param metric the desired metric's name
wilcoxon_test <- function(input_data, metric) {
  
  # Print details
  cat("Data: buggy_dist and clean_dist\n")
  cat(paste0("Metric: ", metric, "\n\n"))
  
  # Set the buggy and clean dists
  buggy_dist <- input_data[input_data$buggy == TRUE,][[metric]]
  clean_dist <- input_data[input_data$buggy == FALSE,][[metric]] 
  
  # Compute the Wilcoxon Tests
  test <- wilcox.test(buggy_dist, clean_dist)
  test_greater <- wilcox.test(buggy_dist, clean_dist, alternative = "greater")
  test_less <- wilcox.test(buggy_dist, clean_dist, alternative = "less")
  
  # Print results
  cat("Wilcoxon Rank Sum Test\n")
  cat(paste0("Alternative hyphotesis: two sided; p-value: ", round(test$p.value, digits = 3), "\n"))
  cat(paste0("Alternative hyphotesis: greater; p-value: ", round(test_greater$p.value, digits = 3), "\n"))
  cat(paste0("Alternative hyphotesis: less; p-value: ", round(test_less$p.value, digits = 3), "\n\n"))
  
  # Compute the Cliff's Delta
  cliff_delta <- effsize::cliff.delta(buggy_dist, clean_dist)
  
  # Print results
  cat("Cliff's Delta\n")
  cat(paste0("Delta estimate: ", round(cliff_delta$estimate, digits = 3), "\n"))
  cat(paste0("Effect size: ", cliff_delta$magnitude, "\n"))
  
}


# Set current metrics
current_metrics <- read.csv("~/metrics/metrics_bazel.csv")

# Compute the Wilcoxon Test and Cliff's Delta
# F1: Experience
wilcoxon_test(current_metrics, "commits")
wilcoxon_test(current_metrics, "SEXPCommit")
wilcoxon_test(current_metrics, "REXPCommit")
wilcoxon_test(current_metrics, "expReview")
wilcoxon_test(current_metrics, "REXPReview")
wilcoxon_test(current_metrics, "activeDays")

# F2: Technical Contribution Norms
wilcoxon_test(current_metrics, "testPresence")
wilcoxon_test(current_metrics, "medianLinesChanged")
wilcoxon_test(current_metrics, "linesChanged")
wilcoxon_test(current_metrics, "medianModifiedFiles")
wilcoxon_test(current_metrics, "modifiedFiles")

# F3: Ownership Level
wilcoxon_test(current_metrics, "medianOwnership")
wilcoxon_test(current_metrics, "ownership")

# F4: Nature
wilcoxon_test(current_metrics, "reengineeringPercent")
wilcoxon_test(current_metrics, "correctiveEngineeringPercent")
wilcoxon_test(current_metrics, "forwardEngineeringPercent")
wilcoxon_test(current_metrics, "managementPercent")

# F5: Bugginess
wilcoxon_test(current_metrics, "previousBuggyPercent")

# F6: Communication
current_metrics$totalComments <- current_metrics$numberIssueComments + current_metrics$numberPullComments + current_metrics$numberCommitComments
wilcoxon_test(current_metrics, "totalComments")

# F7: Project Establishment
wilcoxon_test(current_metrics, "repositoryTime")
