# Run "ImportQFull.R" to run this

# Load necessary libraries
library(tidyverse)

# Assuming df is your existing dataframe
# Step 1: Select columns starting with "Frust" and reshape the data
df_long <- df %>%
  select(starts_with("Frust")) %>% 
  pivot_longer(cols = everything(), names_to = "Variable", values_to = "Value")

# Inspect the reshaped data
head(df_long)

# Step 2: Perform ANOVA
anova_result <- aov(Value ~ Variable, data = df_long)

# Display the ANOVA table
summary(anova_result)

# Optional: Perform Tukey's HSD post-hoc test if needed
tukey_result <- TukeyHSD(anova_result)

# Display the Tukey HSD results
print(tukey_result)

# Optional: Diagnostic plots to check assumptions
par(mfrow = c(2, 2))
plot(anova_result)
