# Load necessary library
library(ggplot2)

# Read the CSV file
qualData <- read.csv("JoyAndFrustQuan.csv")

# Inspect the data to ensure it has been read correctly
head(qualData)

# Ensure the levels of the Game factor are in the desired order
qualData$Game <- factor(qualData$Game, levels = c("LumberJack", "Golf", "Sand"))

# Create a vector of custom colors with 50% alpha
custom_colors <- c("#896043", "#3d913d", "#e0cd53")

# Create the bar chart with custom colors, correct order, and no legend
ggplot(qualData, aes(x = Game, y = Frustrating, fill = Game)) +
  geom_bar(stat = "identity", width = 0.7, color = "darkgrey") +  # Add black outline to the bars
  labs(title = "Most Frustrating Game", 
       x = "Games", 
       y = "Number of Participants") +
  scale_fill_manual(values = custom_colors) +  # Specify custom colors
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5))  # Remove the legend
