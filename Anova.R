
# Kruskal Wallis ----------------------------------------------------------

# Load necessary libraries
library(tidyverse)

# Assuming df is your existing dataframe
# Step 1: Select columns starting with "Frust" and reshape the data
df_long <- df %>%
  select(starts_with("Frust")) %>% 
  pivot_longer(cols = everything(), names_to = "Variable", values_to = "Value")

# Step 2: Perform Kruskal-Wallis test
kruskal_result <- kruskal.test(Value ~ Variable, data = df_long)

# Display the Kruskal-Wallis test result
print(kruskal_result)

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



# Likert scale as Continuous data (Linear Mixed Model) ---------------------------------------------------------

# Load necessary packages
library(lme4)
library(ggplot2)
library(dplyr)

# Fit the linear mixed model treating Likert data as continuous
lmm <- lmer(Value ~ Variable + (1 | ID), data = justFrust_long)
# Summarize the model
summary(lmm)

# Calculate p-values manually
p_value_lumber <- 2 * (1 - pnorm(abs(-1.379)))
p_value_sand <- 2 * (1 - pnorm(abs(-1.379)))

p_value_lumber
p_value_sand
