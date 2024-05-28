# FOR MAC
chosen_file <- file.choose() # Interactively choose a file to determine the correct path
directory_path <- dirname(chosen_file) # Extract the directory path from the chosen file
setwd(directory_path) # Set the working directory to the extracted path

# FOR ALL
# List all CSV files in the folder that match the pattern "lumber_p" followed by digits
csv_files <- list.files(pattern = "lumber_p\\d+\\.csv")

# Initialize an empty list to store data frames
participant_data <- list()

# Loop through each file and read the data
for (file in csv_files) {
  # Extract the participant number from the file name
  participant_number <- sub("lumber_p(\\d+)\\.csv", "\\1", file)
  
  # Read the CSV file
  lumber_log_data <- read.csv(file, sep = ";")
  
  # Select the desired columns (replace 'Event', 'BCIConfidence' with actual column names)
  selected_lumber_columns <- lumber_log_data[, c("Event", "BCIConfidence")]
  
  # Find the index of the "GameStarted" event
  game_started_index <- which(selected_lumber_columns$Event == "GameStarted")
  
  # Filter rows to keep only those after the "GameStarted" event
  if (length(game_started_index) > 0) {
    selected_lumber_columns <- selected_lumber_columns[(game_started_index + 1):nrow(selected_lumber_columns), ]
  }
  
  # Further filter to include only rows where the Event is "Resting"
  resting_data <- selected_lumber_columns[selected_lumber_columns$Event == "Resting", ]
  
  # Add the data frame to the list, using the participant number as the list name
  participant_data[[paste("participant", participant_number, sep = "_")]] <- resting_data
}

# Initialize a data frame to store the summary statistics
lumber_summary_data <- data.frame(ID = integer(), NumberOfSwings = integer(), AverageBCIConfidence = numeric())

# Calculate the average BCI Confidence and count of "Resting" occurrences for each participant
for (id in names(participant_data)) {
  # Extract participant number
  participant_number <- as.integer(sub("participant_", "", id))
  
  # Get the participant's data
  data <- participant_data[[id]]
  
  # Calculate the number of swings (count of "Resting" occurrences)
  number_of_swings <- nrow(data)
  
  # Ensure that BCIConfidence is numeric and remove any non-numeric or missing values
  numeric_bci_confidence <- suppressWarnings(as.numeric(data$BCIConfidence))
  numeric_bci_confidence <- numeric_bci_confidence[!is.na(numeric_bci_confidence)]
  
  # Calculate the average BCI Confidence
  average_bci_confidence <- mean(numeric_bci_confidence)
  
  # Add the statistics to the summary data frame
  lumber_summary_data <- rbind(lumber_summary_data, data.frame(ID = participant_number, NumberOfSwings = number_of_swings, AverageBCIConfidence = average_bci_confidence))
}

# Print the summary data frame
print(lumber_summary_data)
