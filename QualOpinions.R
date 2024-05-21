# Load necessary library
library(ggplot2)

# Read the CSV file (assuming your CSV is correctly named and located)
qualData <- read.csv("MostEnjFrust.csv")

# Inspect the data to ensure it has been read correctly
head(qualData)

# Ensure the levels of the Game factor are in the desired order
qualData$MostFrustrating <- factor(qualData$MostFrustrating, levels = c("Lumber", "Golf", "Sand", "Undecided"))
qualData$MostEnjoyable <- factor(qualData$MostEnjoyable, levels = c("Lumber", "Golf", "Sand", "Undecided"))

# Create a vector of custom colors with 50% alpha
custom_colors <- c("#896043", #Lumber
                   "#3d913d", #Golf
                   "#e0cd53", #Sand
                   "gray") #Undecided

# Create the bar chart for Most Frustrating Game with custom colors, correct order, and no legend
ggplot(qualData, aes(x = MostFrustrating, fill = MostFrustrating)) +
  geom_bar(width = 0.7, color = "darkgrey") +  # Add black outline to the bars
  labs(title = "Most Frustrating Game", 
       x = "Games", 
       y = "Number of Participants") +
  scale_fill_manual(values = custom_colors) +  # Specify custom colors
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5))  # Remove the legend

# Create the bar chart for Most Enjoyable Game with custom colors, correct order, and no legend
ggplot(qualData, aes(x = MostEnjoyable, fill = MostEnjoyable)) +
  geom_bar(width = 0.7, color = "darkgrey") +  # Add black outline to the bars
  labs(title = "Most Enjoyable Game", 
       x = "Games", 
       y = "Number of Participants") +
  scale_fill_manual(values = custom_colors) +  # Specify custom colors
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5))  # Remove the legend
