#install.packages("tidyverse")
library(tidyverse)

justFrust <- df %>% 
  group_by(Frust1, Frust2, Frust3) %>% 
  summarise()

# Reshape data to long format
justFrust_long <- justFrust %>% 
  pivot_longer(cols = starts_with("Frust"), names_to = "Variable", values_to = "Value")

# Calculate mean and quartiles for each Variable
summary_stats <- justFrust_long %>%
  group_by(Variable) %>%
  summarize(
    mean = round(mean(Value), 4),
    lower_quartile = quantile(Value, 0.25),
    upper_quartile = quantile(Value, 0.75)
  )

# Create the point plot with whiskers
ggplot() +
  #geom_point(data = justFrust_long, aes(x = Variable, y = Value)) +  # Use justFrust_long data for points
  geom_errorbar(data = summary_stats, aes(x = Variable, ymin = lower_quartile, ymax = upper_quartile), width = 0.2) +  # Use summary_stats data for error bars
  geom_point(data = summary_stats, aes(x = Variable, y = mean), color = "red", size = 3) +  # Add points for mean
  geom_text(data = summary_stats, aes(x = Variable, y = mean, label = mean), vjust = -0.5, hjust = -0.5, color = "black") +  # Add labels for mean points
  labs(title = "Point Plot with Whiskers of Frustration Levels",
       x = "Frustration Measure",
       y = "Value") +
  scale_y_continuous(breaks = seq(-3, 3, 1), limits = c(-3, 3)) +  # Set breaks for y-axis to every whole number
  theme_minimal() + 
  scale_x_discrete(labels = c("Frust1" = "Lumberjack", "Frust2" = "Golf", "Frust3" = "Sand"))  # Rename x-axis labels