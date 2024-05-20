# Load necessary library
library(ggplot2)

# Read the CSV file
data <- read.csv("JoyAndFrustQuan.csv")

# Inspect the data to ensure it has been read correctly
head(data)

# Create a vector of custom colors (replace with your desired colors)
custom_colors <- c("lightblue", "lightyellow", "pink", "orange", "purple")

# Create the bar chart with custom colors
ggplot(data, aes(x = Game, y = Frustrating, fill = Game)) +
  geom_bar(stat = "identity", width = 0.7, color = "darkgrey") +  # Add black outline to the bars
  labs(title = "Bar Chart of Games vs Frustration", 
       x = "Games", 
       y = "Frustration") +
  scale_fill_manual(values = custom_colors) +  # Specify custom colors
  theme_minimal()  # Use a clean theme