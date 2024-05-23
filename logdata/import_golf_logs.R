# FOR MAC
chosen_file <- file.choose() # Interactively choose a file to determine the correct path
directory_path <- dirname(chosen_file) # Extract the directory path from the chosen file
setwd(directory_path) # Set the working directory to the extracted path

# FOR ALL
# List all CSV files in the folder that match the pattern "golf_p" followed by digits
csv_files <- list.files(pattern = "golf_p\\d+\\.csv")

# Initialize an empty list to store data frames
participant_data <- list()

# Loop through each file and read the data
for (file in csv_files) {
  # Extract the participant number from the file name
  participant_number <- sub("golf_p(\\d+)\\.csv", "\\1", file)
  
  # Read the CSV file
  golf_log_data <- read.csv(file, sep = ";")
  
  # Select the desired columns (replace 'Event', 'BallWasHit' with actual column names)
  selected_golf_columns <- golf_log_data[, c("Event", "BallWasHit")]
  
  # Find the index of the "GameStarted" event
  game_started_index <- which(selected_golf_columns$Event == "GameStarted")
  
  # Filter rows to keep only those after the "GameStarted" event
  if (length(game_started_index) > 0) {
    selected_golf_columns <- selected_golf_columns[(game_started_index + 1):nrow(selected_golf_columns), ]
  }
  
  # Further filter to include only rows where the Event is "Resting"
  resting_data <- selected_golf_columns[selected_golf_columns$Event == "Resting", ]
  
  # Add the data frame to the list, using the participant number as the list name
  participant_data[[paste("participant", participant_number, sep = "_")]] <- resting_data
}

# Initialize a data frame to store the summary statistics
summary_data <- data.frame(ID = integer(), Hits = integer(), Misses = integer(), TotalSwings = integer(), HitRate = numeric())

# Calculate the statistics for each participant
for (id in names(participant_data)) {
  # Extract participant number
  participant_number <- as.integer(sub("participant_", "", id))
  
  # Get the participant's data
  data <- participant_data[[id]]
  
  # Calculate hits, misses, and total swings
  hits <- sum(data$BallWasHit == TRUE, na.rm = TRUE)
  misses <- sum(data$BallWasHit == FALSE, na.rm = TRUE)
  total_swings <- hits + misses
  
  # Calculate hit rate
  hit_rate <- if (total_swings > 0) (hits / total_swings) * 100 else 0
  
  # Add the statistics to the summary data frame
  summary_data <- rbind(summary_data, data.frame(ID = participant_number, Hits = hits, Misses = misses, TotalSwings = total_swings, HitRate = hit_rate))
}

# Print the summary data frame
print(summary_data)
