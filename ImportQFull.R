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
