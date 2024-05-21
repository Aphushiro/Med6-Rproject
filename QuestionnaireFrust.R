library(tidyverse)

# Reshape data to long format
justFrust_long <- justFrust %>%
  pivot_longer(cols = starts_with("Frust"), names_to = "Variable", values_to = "Value")

# Calculate mean and standard error for each variable
summary_stats <- justFrust_long %>%
  group_by(Variable) %>%
  summarize(
    mean = mean(Value),
    std_error = sd(Value) / sqrt(n())
  )

ggplot() +
  geom_point(data = justFrust_long, aes(x = Variable, y = Value), position = position_dodge2(width = 0.5, preserve = "single"), color = "gray", size = 2, show.legend = FALSE) +
  geom_errorbar(data = summary_stats, aes(x = Variable, ymin = mean - std_error, ymax = mean + std_error), width = 0.1, color = "black") +
  geom_point(data = summary_stats %>% filter(Variable == "Frust1"), aes(x = Variable, y = mean), size = 3, color = "#8B4513", show.legend = FALSE) +
  geom_point(data = summary_stats %>% filter(Variable == "Frust2"), aes(x = Variable, y = mean), size = 3, color = "#008000", show.legend = FALSE) +
  geom_point(data = summary_stats %>% filter(Variable == "Frust3"), aes(x = Variable, y = mean), size = 3, color = "#e5ca19", show.legend = FALSE) +
  geom_text(data = summary_stats, aes(x = Variable, y = mean, label = round(mean, 2)), vjust = -0.5, hjust = -0.5, color = "black") +
  labs(title = "Frustation on Worst-Case States",
       x = "Games",
       y = "Frustration Rating") +
  scale_y_continuous(breaks = seq(-3, 3, 1), limits = c(-3, 3)) +
  theme_minimal() +
  scale_x_discrete(labels = c("Frust1" = "Lumber", "Frust2" = "Golf", "Frust3" = "Sand")) +
  theme(panel.grid.major.y = element_blank(),
        #panel.grid.minor.y = element_blank(),
        plot.title = element_text(hjust = 0.5))
