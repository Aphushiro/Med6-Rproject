
# Import QualData ---------------------------------------------------------

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






# Import Quationnaire Data ------------------------------------------------
df <- read.csv("QuestionnaireFull.csv")

# Original column names
original_names <- names(df)

# Abbreviated column names
abbreviated_names <- c(
  "ID",   # Keep the first column as is
  "GoalLumber",         # "The goal of the game was clear to me (+)...Golf"
  "EasyLumber",         # "Striking the wood was not too difficult (+)"
  "FocusLumber",        # "I was fully focused on MI when lifting the axe (+)"
  "FrustLumber",        # "I felt frustrated when I did low damage to the wood (-)"
  "FeedLumber",         # "The game gave clear feedback on how well I struck the wood (+)"
  "FreeLumber",         # "I felt free to play the game in my own way (+)...7"
  "CtrlLumber",         # "I felt in control of how hard I struck the wood (+)"
  "HardLumber",         # "Striking the wood hard was not too easy (+)"
  "GoodLumber",         # "I felt I was good at playing this game (+)...Lumber0"
  "KnowLumber",         # "It was easy to know how to strike the wood hard (+)"
  "TimeLumber",         # "I had a good time playing this game (+)...LumberGolf"
  "GoalGolf",         # "The goal of the game was clear to me (+)...LumberSand"
  "EasyGolf",         # "Hitting the golf ball was not too difficult (+)"
  "FocusGolf",        # "I was fully focused on MI when winding up a shot (+)"
  "FrustGolf",        # "I felt frustrated when I missed the ball (-)"
  "FeedGolf",         # "The game gave clear feedback on how well I hit the golf ball (+)"
  "FreeGolf",         # "I felt free to play the game in my own way (+)...Lumber8"
  "CtrlGolf",         # "I felt in control of how hard I hit the golf ball (+)"
  "HardGolf",         # "Hitting the golf ball was not too easy (+)"
  "GoodGolf",         # "I felt I was good at playing this game (+)...GolfLumber"
  "KnowGolf",         # "It was easy to know how to shoot the golf ball far (+)"
  "TimeGolf",         # "I had a good time playing this game (+)...GolfSand"
  "GoalSand",         # "The goal of the game was clear to me (+)...Golf4"
  "EasySand",         # "Choosing a colour was not too difficult (+)"
  "FocusSand",        # "I was fully focused on MI when choosing colours (+)"
  "FrustSand",        # "I felt frustrated when the clock chose the wrong colour (-)"
  "FeedSand",         # "The game gave clear feedback on what colour was chosen (+)"
  "FreeSand",         # "I felt free to play the game in my own way (+)...Golf9"
  "CtrlSand",         # "I felt in control of what colours were chosen (+)"
  "HardSand",         # "Choosing a colour was not too easy (+)"
  "GoodSand",         # "I felt I was good at playing this game (+)...SandGolf"
  "KnowSand",         # "It was easy to know how to choose the colours I wanted (+)"
  "TimeSand"          # "I had a good time playing this game (+)...Sand4"
)

# Assign the abbreviated names to the data frame
names(df) <- abbreviated_names

# Replace the values in "ID" with row numbers
df$ID <- seq.int(nrow(df))

# Check the abbreviated column names
names(df)


# Cohen's D ---------------------------------------------------------------

# Extracting the variables of interest
frust_lumber <- df$FrustLumber
frust_golf <- df$FrustGolf
frust_sand <- df$FrustSand

# Calculating the mean difference for Golf to Lumber
mean_diff_lumber <- mean(frust_golf) - mean(frust_lumber)

# Calculating the pooled standard deviation for Golf to Lumber
pooled_sd_lumber <- sqrt((sd(frust_lumber)^2 + sd(frust_golf)^2) / 2)

# Cohen's d for Golf to Lumber
cohen_d_lumber <- mean_diff_lumber / pooled_sd_lumber

# Calculating the mean difference for Golf to Sand
mean_diff_sand <- mean(frust_golf) - mean(frust_sand)

# Calculating the pooled standard deviation for Golf to Sand
pooled_sd_sand <- sqrt((sd(frust_sand)^2 + sd(frust_golf)^2) / 2)

# Cohen's d for Golf to Sand
cohen_d_sand <- mean_diff_sand / pooled_sd_sand

# Output Cohen's d for both comparisons
print(paste("Cohen's d for Golf to Lumber:", round(cohen_d_lumber, 2)))
print(paste("Cohen's d for Golf to Sand:", round(cohen_d_sand, 2)))





