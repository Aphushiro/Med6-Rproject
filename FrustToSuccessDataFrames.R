# Load necessary library
library(ggplot2)

# Read the first CSV file into a data frame
golfdf <- read.csv("golfParticipantSuccess.csv")


# Grouping data in the example script (assuming `df` is defined earlier)
justFrust <- df %>% 
  group_by(ID, FrustLumber, FrustGolf, FrustSand) %>% 
  summarise()