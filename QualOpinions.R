# Load necessary library
library(ggplot2)

# Read the CSV file
data <- read.csv("JoyAndFrustQuan.csv")

# Inspect the data to ensure it has been read correctly
head(data)

# Ensure the levels of the Game factor are in the desired order
data$Game <- factor(data$Game, levels = c("LumberJack", "Golf", "Sand"))

# Create a vector of custom colors (replace with your desired colors)
custom_colors <- c("lightblue", "lightyellow", "pink")

# Create the bar chart with custom colors and correct order
ggplot(data, aes(x = Game, y = Frustrating, fill = Game)) +
  geom_bar(stat = "identity", width = 0.7, color = "darkgrey") +  # Add black outline to the bars
  labs(title = "Bar Chart of Games vs Frustration", 
       x = "Games", 
       y = "Participants picking game as most frustrating") +
  scale_fill_manual(values = custom_colors) +  # Specify custom colors
  theme_minimal()  # Use a clean theme
