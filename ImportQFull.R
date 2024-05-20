df <- read.csv("QuestionnaireFull.csv")

# Original column names
original_names <- names(df)

# Abbreviated column names
abbreviated_names <- c(
  "ID",   # Keep the first column as is
  "Goal1",         # "The goal of the game was clear to me (+)...2"
  "Easy1",         # "Striking the wood was not too difficult (+)"
  "Focus1",        # "I was fully focused on MI when lifting the axe (+)"
  "Frust1",        # "I felt frustrated when I did low damage to the wood (-)"
  "Feed1",         # "The game gave clear feedback on how well I struck the wood (+)"
  "Free1",         # "I felt free to play the game in my own way (+)...7"
  "Ctrl1",         # "I felt in control of how hard I struck the wood (+)"
  "Hard1",         # "Striking the wood hard was not too easy (+)"
  "Good1",         # "I felt I was good at playing this game (+)...10"
  "Know1",         # "It was easy to know how to strike the wood hard (+)"
  "Time1",         # "I had a good time playing this game (+)...12"
  "Goal2",         # "The goal of the game was clear to me (+)...13"
  "Easy2",         # "Hitting the golf ball was not too difficult (+)"
  "Focus2",        # "I was fully focused on MI when winding up a shot (+)"
  "Frust2",        # "I felt frustrated when I missed the ball (-)"
  "Feed2",         # "The game gave clear feedback on how well I hit the golf ball (+)"
  "Free2",         # "I felt free to play the game in my own way (+)...18"
  "Ctrl2",         # "I felt in control of how hard I hit the golf ball (+)"
  "Hard2",         # "Hitting the golf ball was not too easy (+)"
  "Good2",         # "I felt I was good at playing this game (+)...21"
  "Know2",         # "It was easy to know how to shoot the golf ball far (+)"
  "Time2",         # "I had a good time playing this game (+)...23"
  "Goal3",         # "The goal of the game was clear to me (+)...24"
  "Easy3",         # "Choosing a colour was not too difficult (+)"
  "Focus3",        # "I was fully focused on MI when choosing colours (+)"
  "Frust3",        # "I felt frustrated when the clock chose the wrong colour (-)"
  "Feed3",         # "The game gave clear feedback on what colour was chosen (+)"
  "Free3",         # "I felt free to play the game in my own way (+)...29"
  "Ctrl3",         # "I felt in control of what colours were chosen (+)"
  "Hard3",         # "Choosing a colour was not too easy (+)"
  "Good3",         # "I felt I was good at playing this game (+)...32"
  "Know3",         # "It was easy to know how to choose the colours I wanted (+)"
  "Time3"          # "I had a good time playing this game (+)...34"
)

# Assign the abbreviated names to the data frame
names(df) <- abbreviated_names

# Replace the values in "ID" with row numbers
df$ID <- seq.int(nrow(df))

# Check the abbreviated column names
names(df)
