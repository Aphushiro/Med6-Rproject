# Load necessary library
library(ggplot2)
library(dplyr)
library(ggbeeswarm)

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


ggplot(qualData, aes(x = Most))

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


# Success Rate vs Most Frustrating ----------------------------------------



names(golfMeans)[names(golfMeans) == "MeanConfidence"] <- "Golf"
golfMeans <- golfMeans %>%
  mutate(ID = row_number())

names(lumberMeans)[names(lumberMeans) == "MeanConfidence"] <- "Lumber"
lumberMeans <- lumberMeans %>%
  mutate(ID = row_number())

qualData <- qualData %>%
  right_join(golfMeans) %>%
  right_join(lumberMeans)

longData <- qualData %>%
  pivot_longer(cols = c(Golf, Lumber), names_to = "Category", values_to = "Confidence")

# Define colors based on conditions
longData <- longData %>%
  mutate(Color = case_when(
    Category == "Golf" & MostFrustrating == "Golf" ~ "red",
    Category == "Lumber" & MostFrustrating == "Lumber" ~ "red",
    TRUE ~ "gray"
  ))

# Create the plot with necessary adjustments
p <- ggplot(longData, aes(x = Category, y = Confidence, color = Color)) +
  geom_quasirandom(width = 0.2) +  # Use geom_quasirandom for beeswarm plot
  scale_color_identity() +
  #theme_minimal() +
  theme(
    text = element_text(color = "black", size = 12, face = "bold"),       # Change all text to white, increase size and bolden
    axis.text = element_text(color = "black", size = 10, face = "bold"),  # Change axis text to white, increase size and bolden
    axis.title = element_text(color = "black", size = 12, face = "bold"), # Change axis titles to white, increase size and bolden
    panel.grid.major = element_blank(),         # Remove major gridlines
    #panel.grid.minor = element_,         # Remove minor gridlines
    plot.title = element_text(color = "black", size = 14, face = "bold")  # Change plot title to white, increase size and bolden (if any)
  ) +
  labs(y = "Success Rate", x = "") + 
  ylim(c(0.05, 1.05))  # Adjust y-axis limits as needed

p


ggsave(filename = "confidence_plot.png", plot = p, device = "png", width = 3, height = 3.5, units = "in", bg = "transparent")
