library(tidyverse)
library(ggbeeswarm)
library(ordinal)  # For clmm function

create_plot_and_model <- function(df, qualData, data_type) {
  # Merge the data
  merged_data <- df %>%
    left_join(qualData, by = "ID")
  
  # Reshape to long format
  long_data <- merged_data %>%
    pivot_longer(cols = starts_with(data_type), names_to = "Variable", values_to = "Value") %>%
    mutate(MostFrustratingMatch = case_when(
      (Variable == paste0(data_type, "Lumber") & MostFrustrating == "Lumber") ~ TRUE,
      (Variable == paste0(data_type, "Golf") & MostFrustrating == "Golf") ~ TRUE,
      (Variable == paste0(data_type, "Sand") & MostFrustrating == "Sand") ~ TRUE,
      TRUE ~ FALSE
    )) %>%
    group_by(ID) %>%
    mutate(average_value = mean(Value)) %>%
    ungroup() %>%
    mutate(alpha = scale(average_value, 
                         center = min(average_value), 
                         scale = max(average_value) - min(average_value)))
  
  # Set the factor levels for Variable to reorder categories
  long_data$Variable <- factor(long_data$Variable, levels = c(paste0(data_type, "Lumber"), paste0(data_type, "Golf"), paste0(data_type, "Sand")))
  
  # Calculate mean and standard error for each variable
  summary_stats <- long_data %>%
    group_by(Variable) %>%
    summarize(
      mean = mean(Value),
      std_error = sd(Value) / sqrt(n())
    )
  
  # Create the plot
  p <- ggplot(long_data) +
#    geom_line(aes(x = Variable, y = Value, group = ID), 
#              color = "black", alpha = long_data$alpha, position = position_jitter(width = 0, height = 0.3)) +
    geom_quasirandom(aes(x = Variable, y = Value, color = MostFrustratingMatch), 
                     width = 0.3, size = 2, show.legend = FALSE, alpha = 0.5) +
    geom_errorbar(data = summary_stats, aes(x = Variable, ymin = mean - std_error, ymax = mean + std_error), 
                  width = 0.1, color = "white") +
    geom_point(data = summary_stats, aes(x = Variable, y = mean), size = 3, color = "red", show.legend = FALSE) +  
    geom_text(data = summary_stats, aes(x = Variable, y = mean, label = round(mean, 2)), 
              vjust = -0.5, hjust = -0.25, color = "white") +
    labs(#title = data_type,
         x = "Games",
         y = paste(data_type, "Rating")) +
    scale_y_continuous(breaks = seq(-3, 3, 1), limits = c(-3.3, 3.3)) +
#    scale_x_discrete(labels = c(paste0(data_type, "Lumber") = "Lumber", 
#                                paste0(data_type, "Golf") = "Golf", 
#                                paste0(data_type, "Sand") = "Sand")) +
    scale_color_manual(
      values = c("TRUE" = "darkgray", "FALSE" = "darkgray"),
      name = "Selected as\nMost Frustrating",
      labels = c("TRUE" = "Yes", "FALSE" = "No")
    ) +
    theme_minimal() +
    theme(
      text = element_text(color = "white", size = 12, face = "bold"),
      axis.text = element_text(color = "white", size = 10, face = "bold"),
      axis.title = element_text(color = "white", size = 12, face = "bold"),
      panel.grid.major = element_blank()
    )
  
  ggsave(filename = paste0(data_type, "_plot_avg.png"), plot = p, device = "png", width = 3, height = 3.5, units = "in", bg = "transparent")
  
  # Ordinal regression part
  df_long <- df %>%
    select(ID, starts_with(data_type)) %>%
    pivot_longer(cols = -ID, names_to = "Variable", values_to = "Value")
  
  # Ensure 'Value' is treated as an ordinal factor
  df_long$Value <- as.ordered(df_long$Value)
  
  # Fit the cumulative link mixed model
  clmm_model <- clmm(Value ~ Variable + (1 | ID), data = df_long)
  
  # Get the summary of the model
  model_summary <- summary(clmm_model)
  print(model_summary)
  
  # Save the summary results with p-values formatted as decimal numbers
  model_results <- data.frame(
    term = rownames(model_summary$coefficients),
    p_value = format(model_summary$coefficients[, "Pr(>|z|)"], scientific = FALSE),
    stars = ifelse(model_summary$coefficients[, "Pr(>|z|)"] < 0.001, "***",
                   ifelse(model_summary$coefficients[, "Pr(>|z|)"] < 0.01, "**",
                          ifelse(model_summary$coefficients[, "Pr(>|z|)"] < 0.05, "*", "")))
  )
  
  return(model_results)
}

data_types <- c("Goal", "Easy", "Focus", "Frust", "Feed", "Free", "Ctrl", "Hard", "Good", "Know", "Time")

all_model_results <- data.frame()

for (data_type in data_types) {
  model_results <- create_plot_and_model(df, qualData, data_type)
  model_results$data_type <- data_type
  all_model_results <- bind_rows(all_model_results, model_results)
}

# Save the results for later inspection
write_csv(all_model_results, "all_model_results.csv")
