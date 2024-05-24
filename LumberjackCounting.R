# Load necessary library
library(tidyverse)

# Function to process each CSV file
process_file <- function(file) {
  data <- read.csv2(file, stringsAsFactors = FALSE)
  resting_data <- data %>% filter(Event == "Resting")
  resting_confidences <- resting_data %>%
    filter(!is.na(BCIConfidence) & as.numeric(BCIConfidence) > 0.0) %>%
    select(BCIConfidence)
  resting_confidences_vector <- as.numeric(resting_confidences$BCIConfidence)
  return(resting_confidences_vector)
}

# List of CSV file paths
csv_files <- list.files(path = "LumberData/LumberGame", pattern = "[0-9]+lumber.csv", full.names = TRUE)

# Sort files based on the numeric part of their names
csv_files <- csv_files[order(as.numeric(gsub("\\D", "", csv_files)))]

# Process each file and store results in a list
all_resting_confidences <- list()
for (file in csv_files) {
  participant <- gsub("\\D", "", file)
  confidences <- process_file(file)
  all_resting_confidences[[participant]] <- confidences
}

# Determine the maximum length of the confidence vectors
max_lengths <- max(sapply(all_resting_confidences, length))

# Convert the list to a dataframe, with each file's data in separate columns
all_resting_confidences_df <- bind_cols(
  lapply(all_resting_confidences, function(x) {
    length(x) <- max_lengths
    return(x)
  })
)

# Rename the columns to "P1", "P2", ..., "Pn"
colnames(all_resting_confidences_df) <- paste0("P", gsub("\\D", "", names(all_resting_confidences)))

# Print the resulting dataframe
print(all_resting_confidences_df)
